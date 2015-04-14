# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
# require "sim_launcher/version"

Gem::Specification.new do |s|
  s.name        = "emu-ctl"
  s.version     = EmuCtl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nemo Oudeis"]
  s.email       = ["gems@oudeis.eu"]
  s.homepage    = ""
  s.summary     = %q{command line tool to easily control android simulators}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.post_install_message = <<-EOS

  ******************************************************
  * emu-ctl expects the Android SDK on your $PATH.     *
  *                                                    *
  ******************************************************

  EOS

end
