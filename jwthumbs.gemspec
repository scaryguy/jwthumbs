# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jwthumbs/version'

Gem::Specification.new do |spec|
  spec.name          = "jwthumbs"
  spec.version       = Jwthumbs::VERSION
  spec.authors       = ["scary.mac"]
  spec.email         = ["soner2@gmail.com"]
  spec.description   = %q{A Ruby gem for creating a sprite of thumbnails and a .VTT file to use with JWPlayer and all other HTML5 video players.}
  spec.summary       = %q{Create thumb sprites with a .VTT file}
  spec.homepage      = "http://github.com/scaryguy/jwthumbs"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features|fixtures)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
