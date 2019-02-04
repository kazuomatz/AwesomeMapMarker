
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "awesome_map_marker/version"

Gem::Specification.new do |spec|
  spec.name          = "awesome_map_marker"
  spec.version       = AwesomeMapMarker::VERSION
  spec.authors       = ["Kazuo Matsunaga"]
  spec.email         = ["getlasterror@gmail.com"]

  spec.summary       = %q{AwesomeMapMarker is a library that generates markers from Fontawesome 5. }
  spec.description   = %q{AwesomeMapMarker is a library that generates markers from Fontawesome 5. Generate marker for plotting on maps such as Google Map, Open Street Map and iOS App etc. }
  spec.homepage      = "https://github.com/kazuomatz/awesome_map_marker"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"

  spec.add_runtime_dependency 'mini_magick', '~> 4.8'
end
