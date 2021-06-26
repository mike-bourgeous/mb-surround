# frozen_string_literal: true
source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'rake', '~> 13.0'

# Dependencies on sibling projects
gem 'mb-sound', github: 'mike-bourgeous/mb-sound.git'
gem 'mb-geometry', github: 'mike-bourgeous/mb-geometry.git'
gem 'mb-math', github: 'mike-bourgeous/mb-math.git'
gem 'mb-util', github: 'mike-bourgeous/mb-util.git'

# Comment this out if you don't want to use Jack via FFI or don't want to install FFI.
gem 'mb-sound-jackffi', '>= 0.0.15.usegit', github: 'mike-bourgeous/mb-sound-jackffi.git'
