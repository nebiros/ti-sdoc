# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ti-sdoc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Juan Felipe Alvarez Saldarriaga"]
  gem.email         = ["nebiros@gmail.com"]
  gem.description   = <<-EOF
    Appcelerator's Titanium Mobile API parser, it dumps a SDOC file
    that can be used in NetBeans for code completion or Aptana.
  EOF
  gem.summary       = %q{Appcelerator's Titanium Mobile API SDOC generator.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ti-sdoc"
  gem.require_paths = ["lib"]
  gem.version       = Ti::Sdoc::VERSION
end
