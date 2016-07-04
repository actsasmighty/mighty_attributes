# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "activemodel/attributes/version"

Gem::Specification.new do |spec|
  spec.name          = "activemodel-attributes"
  spec.version       = Activemodel::Attributes::VERSION
  spec.authors       = ["Michael Sievers"]

  spec.summary       = %q{Attributes for ActiveModel}
  spec.homepage      = "https://github.com/servizio-rb/activemodel-attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
end
