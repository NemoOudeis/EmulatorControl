require "emu_ctl"

RSpec.describe EmuCtl::Target do
  describe 'init' do
  	conosole_output = "
id: 1 or \"android-14\"
	Name: Android 4.0
    Type: Platform
    API level: 14
    Revision: 4
    Skins: HVGA, QVGA, WQVGA400, WVGA800 (default)
Tag/ABIs : no ABIs.
"

    it 'parses console output of `android list target`' do
		target = EmuCtl::Target.new(conosole_output)
		expect(target.id).to eq("android-14")
		expect(target.name).to eq("Android 4.0")
    end

    it 'converts skins into string list' do
		target = EmuCtl::Target.new(conosole_output)
		expect(target.skins).to eq(['HVGA', 'QVGA', 'WQVGA400', 'WVGA800 (default)'])
    end

    it 'converts "API level" to integer' do
		target = EmuCtl::Target.new(conosole_output)
		expect(target.api_lvl).to eq(14)
    end

    it 'converts "no ABIs" to nil' do
		target = EmuCtl::Target.new(conosole_output)
		expect(target.abi).to eq(nil)
    end

    conosole_output2 = "
id: 13 or \"Google Inc.:Google APIs:18\"
    Name: Google APIs
    Type: Add-On
    Vendor: Google Inc.
    Revision: 3
    Description: Android + Google APIs
    Based on Android 4.3.1 (API level 18)
    Libraries:
     * com.google.android.media.effects (effects.jar)
         Collection of video effects
     * com.android.future.usb.accessory (usb.jar)
         API for USB Accessories
     * com.google.android.maps (maps.jar)
         API for Google Maps
    Skins: HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800 (default), WVGA854, WXGA720, WXGA800, WXGA800-7in
Tag/ABIs : default/armeabi-v7a"

	it 'recognizes Based on `Android X.Y.Z (API level XX)` correctly' do
		target = EmuCtl::Target.new(conosole_output2)
		expect(target.api_lvl).to eq(18)
    end
  end
end


RSpec.describe EmuCtl::Avd do
  describe 'init' do
  	conosole_output = "
Name: ci_avd
    Path: /Users/Dave/.android/avd/ci_avd.avd
  Target: Android 4.1.2 (API level 16)
 Tag/ABI: default/armeabi-v7a
    Skin: WVGA800
"

    it 'parses console output of `android list avd`' do
		avd = EmuCtl::Avd.new(conosole_output)
		expect(avd.name).to eq("ci_avd")
    end

    it 'parses skin' do
		avd = EmuCtl::Avd.new(conosole_output)
		expect(avd.skin).to eq('WVGA800')
    end

    it 'parses abi' do
		avd = EmuCtl::Avd.new(conosole_output)
		expect(avd.abi).to eq('default/armeabi-v7a')
    end

    it 'parses target' do
		avd = EmuCtl::Avd.new(conosole_output)
		expect(avd.target).to eq('Android 4.1.2 (API level 16)')
    end
  end
end


