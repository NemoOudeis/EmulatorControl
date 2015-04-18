# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "emu_ctl/version"

Gem::Specification.new do |s|
  s.name          = "emu_ctl"
  s.version       = EmuCtl::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Nemo Oudeis"]
  s.email         = ["nemo@oudeis.eu"]
  s.homepage      = "https://github.com/NemoOudeis/EmulatorControl"
  s.summary       = %q{command line tool to easily control android emulators}
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.post_install_message = <<-EOS

  ****************************************************
  *  emu_ctl expects the Android SDK on your $PATH.  *
  *  (at least `android` and `adb`)                  *
  ****************************************************

  EOS

  s.add_development_dependency "rspec", "~> 3.2.0"
  s.add_development_dependency "bundler", "~> 1.8"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "guard-rspec", "~> 4.5.0"
end
