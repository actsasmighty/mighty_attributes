# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mighty_attributes/version"

Gem::Specification.new do |spec|
  spec.name          = "mighty_attributes"
  spec.version       = MightyAttributes::VERSION
  spec.authors       = ["Michael Sievers"]

  spec.summary       = %q{Attributes for (active) models}
  spec.homepage      = "https://github.com/actsasmighty/mighty_attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
