#!/usr/bin/env ruby
# Direct-synthesis analytic wave generator-based monophonic synthesizer.
# For episode 4 of Code, Sound, & Surround
# (C)2021 Mike Bourgeous
#
# Requires jackd.

require 'bundler/setup'

require 'mb-sound'
require 'mb-sound-jackffi'

# Tune B to match 60Hz frame rate
MB::Sound::Oscillator.tune_freq = 480
MB::Sound::Oscillator.tune_note = 71

show_messages = !!ARGV.delete('--show')
jack = MB::Sound::JackFFI['CplxSynth']
output = jack.output(port_names: ['Left', 'Right'], channels: 2, connect: :physical)
manager = MB::Sound::MIDI::Manager.new(jack: jack, connect: ARGV[0] || :physical, channel: 0)

OSC_COUNT = 1
osc_pool = MB::Sound::MIDI::VoicePool.new(
  manager,
  OSC_COUNT.times.map { MB::Sound::MIDI::Voice.new(wave_type: :complex_ramp) }
)

panner = MB::Sound::ComplexPan.new
softclip = MB::Sound::SoftestClip.new(threshold: 0.15)
gain = 0.6

manager.on_cc(73, default: -2, range: -2..1) do |attack|
  t = 10.0 ** attack
  osc_pool.each do |v|
    v.amp_envelope.attack_time = t
    v.filter_envelope.attack_time = t # TODO: separate
  end
end
manager.on_cc(75, default: -1.5, range: -2..1) do |decay|
  t = 10.0 ** decay
  osc_pool.each do |v|
    v.amp_envelope.decay_time = t
    v.filter_envelope.decay_time = t # TODO: separate
  end
end
manager.on_cc(70, default: 0.5, range: 0..2) do |sustain|
  osc_pool.each do |v|
    v.amp_envelope.sustain_level = sustain
    v.filter_envelope.sustain_level = sustain
  end
end
manager.on_cc(72, default: -0.5, range: -2..1) do |release|
  t = 10.0 ** release
  osc_pool.each do |v|
    v.amp_envelope.release_time = t
    v.filter_envelope.release_time = t # TODO: separate filter from amp
  end
end

manager.on_cc(74, default: 0.8, range: 0..3) do |decade|
  # Filter cutoff
  freq = 20.0 * 10.0 ** decade
  freq = 18000 if freq > 18000
  osc_pool.each do |v|
    v.cutoff = freq
  end
end
manager.on_cc(71, default: 4, range: 0.5..8) do |quality|
  # Filter resonance
  osc_pool.each do |v|
    v.quality = quality
  end
end
manager.on_cc(79, default: 5, range: 1..20) do |intensity|
  # Envelope intensity
  osc_pool.each do |v|
    v.filter_intensity = intensity
  end
end

manager.on_cc(1, range: 0..(Math::PI / 2000)) do |mod|
  # Mod wheel
  osc_pool.each do |v|
    v.random_advance = mod
  end
end

manager.on_cc(118, default: 0, range: -0.8..0.8) do |pan|
  # Vector X
  panner.pan = pan
end

manager.on_cc(119, default: 0, range: Math::PI..0) do |phase|
  # Vector Y
  panner.phase = phase
end

manager.on_cc(4) do |distortion|
  # Foot pedal
  threshold = MB::M.scale(distortion, 0..1, 0.8..0.1)
  limit = MB::M.scale(distortion, 0..1, 1.0..0.3)
  gain = MB::M.scale(distortion, 0..1, 0.6..3.0)
  softclip.threshold = threshold
  softclip.limit = limit
end

if show_messages
  manager.on_event do |e|
    unless e.is_a?(MIDIMessage::SystemRealtime)
      puts MB::U.highlight(e)
    end
  end
end

loop do
  manager.update

  data = osc_pool.sample(output.buffer_size)
  re = softclip.process(data.real * gain)
  im = softclip.process(data.imag * gain)
  left, right = panner.process(re + im * 1i)
  output.write([left.real, right.real])
end
