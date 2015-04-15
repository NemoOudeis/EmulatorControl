require "emu_ctl"

RSpec.describe EmuCtl::Emulator do
  describe 'lists' do
    it 'looks up existings avds' do
      expect(EmuCtl::Emulator.list).to_not be_nil
    end

    it 'looks up available targets' do
      expect(EmuCtl::Emulator.list_targets).to_not be_nil
    end
  end

  describe 'emulator creation and deletion' do
    it 'creates new emulator' do
      old_list = EmuCtl::Emulator.list
      # only targets with default abi
      target = EmuCtl::Emulator.list_targets.select{|t| t.abi.include?('default')}.last
      puts "creating emulator for target #{target.name} and skin #{target.skins[0]}"

      EmuCtl::Emulator.create(target, target.skins[0])
      expect(EmuCtl::Emulator.list.count).to eq(old_list.count + 1)
    end

    it 'deletes emulators' do
      old_list = EmuCtl::Emulator.list
      emu = old_list.last
      puts "deleting emulator #{emu}"
      EmuCtl::Emulator.delete(emu)
      expect(EmuCtl::Emulator.list.count).to eq(old_list.count - 1)
    end

    it 'looks up available targets' do
      expect(EmuCtl::Emulator.list_targets).to_not be_nil
    end
  end
end
