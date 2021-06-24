require_relative 'lib/mb/surround/version'

Gem::Specification.new do |spec|
  spec.name          = "mb-surround"
  spec.version       = MB::Surround::VERSION
  spec.authors       = ["Mike Bourgeous"]
  spec.email         = ["mike@mikebourgeous.com"]

  spec.summary       = %q{Ruby code for encoding, decoding, and processing positional audio.}
  spec.description   = %q{
    Ruby code for encoding, decoding, and processing positional audio.  This
    code accompanies my educational video series about sound.
  }
  spec.homepage      = 'https://github.com/mike-bourgeous/mb-surround'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.1")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|sounds|tmp|coverage)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'cmath'
  spec.add_runtime_dependency 'numo-narray'

  spec.add_runtime_dependency 'mb-sound'
  spec.add_runtime_dependency 'mb-geometry'
  spec.add_runtime_dependency 'mb-math'
  spec.add_runtime_dependency 'mb-util'
end
