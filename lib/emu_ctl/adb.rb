module EmuCtl
  class ADB
    def self.devices
      _, stdout, _ = Open3.popen3('adb devices')
      lines = []
      stdout.each_line { |l| lines.push(l) }
      lines.join
    end

    def self.boot_complete?
      _, stdout, stderr = Open3.popen3('adb shell getprop dev.bootcomplete')
      return stderr.gets.nil?
    end

    def self.unlock_emulator
      system 'adb shell input keyevent 82'
      system 'adb shell input keyevent 4'
    end
  end
end
