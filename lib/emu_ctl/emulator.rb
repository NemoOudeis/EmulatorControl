module EmuCtl
  class Emulator
    def self.start(arg)
      raise 'invalid arg: nil' if arg.nil?
      emu = emulator_id(arg)
      puts "starting emulator: #{emu}"
      puts "emulator -no-boot-anim -avd #{emu} -no-snapshot-load -no-snapshot-save -no-window"
      system "emulator -no-boot-anim -avd #{emu} -no-snapshot-load -no-snapshot-save -no-window &"
      starting_up = true

      start = Time.now
      until ADB.boot_complete?
        sleep 2
        ellapsed = Time.now - start
        print "\r"
        print "Waiting for emulator " + "."*(ellapsed/2).to_i
        STDOUT.flush
        abort 'unable to start emulator for 6 minutes' if Time.now - start > 360
      end

      puts ''
      puts 'emulator up and running'
      _, stdout, _ = Open3.popen3('adb devices')
      stdout.each_line { |l| puts l }

      puts 'unlocking screen'
      ADB.unlock_emulator
      puts 'emulator ready'
    end

    def self.list
      _, stdout, _ = Open3.popen3('android list avd')
      lines = []
      stdout.each_line { |l| lines.push(l) }
      lines.join.split('---------').map { |desc| Avd.new(desc) }
    end

    def self.list_targets
      _, stdout, _ = Open3.popen3('android list targets')
      lines = []
      stdout.each_line { |l| lines.push(l) }
      target_descs = lines.join.split('----------').select { |t| t.include?('id: ') }
      target_descs.map { |desc| Target.new(desc) }
    end

    def self.create(id, skin)
      system "android create avd -n emu_#{id}_#{skin} -t #{id} -s #{skin}"
    end

    def self.delete(name)
      system "android delete avd -n #{name}"
    end
  end
end
