# mb-surround

Ruby code for encoding, decoding, and processing positional audio in various
forms.  This is a companion library to an [educational video series I'm making
about sound][0].

This relies on [mb-sound][1] and [mb-geometry][2], and you might also be
interested in [mb-sound-jackffi][3], [mb-math][4], and [mb-util][5].

## Installation

Follow the installation instructions for [mb-sound][1], then repeat for this
repo.

If you would like to use this code as a Gem, add this to your Gemfile:

```ruby
# your-project/Gemfile
gem 'mb-surround', git: 'https://github.com/mike-bourgeous/mb-surround.git'

# Also specify Git location for other mb-* dependencies
gem 'mb-sound', git: 'https://github.com/mike-bourgeous/mb-sound.git'
gem 'mb-geometry', git: 'https://github.com/mike-bourgeous/mb-geometry.git'
gem 'mb-util', git: 'https://github.com/mike-bourgeous/mb-util.git'
gem 'mb-math', git: 'https://github.com/mike-bourgeous/mb-math.git'
```

## Usage

TODO: Write usage instructions here

## Contributing

Since this library is meant to accompany a video series, most new features will
be targeted at what's covered in episodes as they are released.  If you think
of something cool to add that relates to the video series, then please open a
pull request.


[0]: https://www.youtube.com/playlist?list=PLpRqC8LaADXnwve3e8gI239eDNRO3Nhya
[1]: https://github.com/mike-bourgeous/mb-sound
[2]: https://github.com/mike-bourgeous/mb-geometry
[3]: https://github.com/mike-bourgeous/mb-sound-jackffi
[4]: https://github.com/mike-bourgeous/mb-math
[5]: https://github.com/mike-bourgeous/mb-util
