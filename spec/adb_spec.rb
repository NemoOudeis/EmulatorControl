require "emu_ctl"

RSpec.describe EmuCtl::ADB do
  describe 'lists', :wip => true do
    it 'looks up  running emulators' do
      devices = EmuCtl::ADB.devices
      puts devices
      expect(devices).to_not be_nil
    end
  end
end
