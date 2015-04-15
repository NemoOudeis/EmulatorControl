module EmuCtl
  @@EMU_TIMEOUT = 180

  class Emulator
    def self.start(emu)
      raise 'invalid name: nil' if emu.name.nil?
      puts "starting emulator: #{emu}"
      puts "emulator -no-boot-anim -avd #{emu.name} -no-snapshot-load -no-snapshot-save -no-window"
      system "emulator -no-boot-anim -avd #{emu.name} -no-snapshot-load -no-snapshot-save -no-window &"
      starting_up = true

      start = Time.now
      until ADB.boot_complete?
        sleep 2
        ellapsed = Time.now - start
        print "\r"
        print "Waiting for emulator " + "."*(ellapsed/2).to_i
        STDOUT.flush
        abort "unable to start emulator for #{@@EMU_TIMEOUT/60} minutes" if Time.now - start > @@EMU_TIMEOUT
      end

      puts ''
      puts 'emulator up and running'
      puts ADB.devices

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

    def self.create(target_id, skin)
      system "android create avd -n emu_#{target_id}_#{skin} -t #{target_id} -s #{skin}"
    end

    def self.delete(emu)
      system "android delete avd -n #{emu.name}"
    end

    def self.running_pids
      _, stdout, _ = Open3.popen3("pgrep 'emulator'")
      pids = []
      stdout.each_line { |l| pids.push(l.strip) }
      pids
    end

    def self.kill_all
      pids = Emulator.running_pids
      puts "found running emulators with pid: #{pids}"
      pids.each { |pid| system "kill -9 #{pid}" }
    end
  end
end
