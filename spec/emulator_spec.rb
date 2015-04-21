require "emu_ctl"

RSpec.describe EmuCtl::Ctl do
  describe 'lists' do
    it 'looks up existings avds' do
      expect(EmuCtl::Ctl.list).to_not be_nil
    end

    it 'looks up available targets' do
      expect(EmuCtl::Ctl.list_targets).to_not be_nil
    end
  end

  describe 'emulator creation and deletion' do
    it 'creates new emulator' do
      old_list = EmuCtl::Ctl.list
      # only targets with default abi
      target = EmuCtl::Ctl.list_targets.select{|t| t.abi.include?('default')}.last
      puts "creating emulator for target #{target.name} and skin #{target.skins[0]}"

      EmuCtl::Ctl.create(target, target.skins[0])
      expect(EmuCtl::Ctl.list.count).to eq(old_list.count + 1)
    end

    it 'deletes emulators' do
      old_list = EmuCtl::Ctl.list
      emu = old_list.last
      puts "deleting emulator #{emu}"
      EmuCtl::Ctl.delete(emu)
      expect(EmuCtl::Ctl.list.count).to eq(old_list.count - 1)
    end

    it 'looks up available targets' do
      expect(EmuCtl::Ctl.list_targets).to_not be_nil
    end
  end
end
