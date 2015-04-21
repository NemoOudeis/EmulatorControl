module EmuCtl

  class Target
    attr_accessor(:id, :name, :skins, :abi, :api_lvl)

    def initialize(desc)
      @lines = desc.split("\n")
      @id = /id: \d+ .* "(.+)"/.match(desc)[1]
      @name = /Name: (.+)/.match(desc)[1]
      @skins = /Skins: (.*)/.match(desc)[1].split(',').map{|n| n.strip}
      @abi = /ABIs : (.+)/.match(desc)[1]
      @abi = nil if @abi.include?('no ABIs.')
      @api_lvl = /API level.? (\d+)/.match(desc)[1].to_i
    end

    def to_s
      "#{@id}\n\tName: #{@name}\n\t#{@skins}\n\tABI: #{abi}"
    end
  end

  class Avd
    attr_accessor(:name, :target, :abi, :skin)

    def initialize(desc)
      @lines = desc.split("\n")
      @name = /Name: (.+)/.match(desc)[1]
      @skin = /Skin: (.+)/.match(desc)[1]
      @target = /Target: (.+)/.match(desc)[1]
      @abi = /Tag\/ABI: (.+)/.match(desc)[1]
    end

    def has_id?(id)
      puts "checking me '#{@name}' for '#{id}'"
      @name.include?(id)
    end

    def to_s
      "#{@name}"
    end
  end

  class Emulator
    attr_accessor(:qualifier, :api_lvl, :os_name, :sdk)

    def initialize(qual, api_lvl, os_name, sdk)
      @qualifier = qual
      @api_lvl = api_lvl
      @os_name = os_name
      @sdk = sdk
    end

    def to_s
      "#{qualifier}: Running #{os_name} on API Level #{api_lvl} with sdk #{sdk}"
    end

  end
end
