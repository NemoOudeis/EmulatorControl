module EmuCtl
  class Android
    def self.list_targets
      _, stdout, _ = Open3.popen3('android list targets')
      lines = []
      stdout.each_line { |l| lines.push(l) }
      target_descs = lines.join.split('----------').select { |t| t.include?('id: ') }
      target_descs.map { |desc| Target.new(desc) }
    end

    def self.list_avds
      _, stdout, _ = Open3.popen3('android list avd')
      lines = []
      stdout.each_line { |l| lines.push(l) }
      lines.join.split('---------').map { |desc| Avd.new(desc) }
    end

    def self.create_avd(id, skin)
      system "android create avd -n emu_#{id}_#{skin} -t #{id} -s #{skin}"
    end

    def self.remove_avd(name)
      system "android delete avd -n #{name}"
    end
  end
end
