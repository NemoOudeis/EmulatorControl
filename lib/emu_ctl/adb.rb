module EmuCtl
  class ADB
    def self.cli_opt(emu_qual)
      "#{"-s #{emu_qual}" unless emu_qual.nil?}"
    end

    def self.devices
      _, stdout, _ = Open3.popen3('adb devices -l')
      lines = []
      stdout.each_line { |l| lines.push(l) if l.include?('emulator') }
      lines.map{ |em| /(emulator-\d+)/.match(em)[1] }.map{ |qual| emu_info(qual) }
    end

    def self.emu_info(emu_qual=nil)
      _, stdout, _ = Open3.popen3("adb #{cli_opt(emu_qual)} shell getprop")
      pattern = /\[.+\]: \[(.+)\]/
      api_lvl, os_version, sdk = nil, nil, nil
      stdout.each_line do |l| 
        api_lvl = pattern.match(l)[1] if l.include?('ro.build.version.sdk') 
        os_version = pattern.match(l)[1] if l.include?('ro.build.version.release') 
        sdk = pattern.match(l)[1] if l.include?('ro.product.name') 
      end
      return Emulator.new(emu_qual, api_lvl, os_version, sdk)
    end

    def self.boot_complete?(emu_qual=nil)
      cmd = "adb #{cli_opt(emu_qual)} shell getprop dev.bootcomplete"
      _, stdout, stderr = Open3.popen3(cmd)
      return stderr.gets.nil?
    end

    def self.unlock_emulator(emu_qual=nil)
      tag = cli_opt(emu_qual)
      system "adb #{tag} shell input keyevent 82"
      system "adb #{tag} shell input keyevent 4"
    end

    def self.kill_emu(emu_qual)
      cmd = "adb #{cli_opt(emu_qual)} emu kill"
      puts cmd
      Open3.popen3(cmd)
    end
  end
end
