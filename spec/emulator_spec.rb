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
        targets = EmuCtl::Emulator.list_targets
        new_target = targets.last
        EmuCtl::Emulator.create(new_target.id, new_target.skins[0])
        expect(EmuCtl::Emulator.list.count).to eq(old_list.count + 1)
    end

    it 'looks up available targets' do
      expect(EmuCtl::Emulator.list_targets).to_not be_nil
    end
  end
end
