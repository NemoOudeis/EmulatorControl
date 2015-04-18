# Emulator Control

Commandline util to maintain android emulators on headless machines (or just without window in gerneral).

[![Gem Version](https://badge.fury.io/rb/emu_ctl.svg)](http://badge.fury.io/rb/emu_ctl)

# NOT READY FOR PRODUCTION

## WHY?

Using the android emulator on CI is painful. For jenkins there is a nice emulator plugin, but unfortunately it is not very reliable, emulators tend to break for no reason and manual cleanup work becomes necessary. This gem makes the emulator scriptable so you have more control what happens with the emulator for CI

## Installation

    $ gem install emu_ctl

## Usage

    $ emu_ctl
    Usage: 
        emu_ctl list            prints all available emulators
        emu_ctl running         shows all running emulators
        emu_ctl kill            kills all running emulators
        emu_ctl launch ID       runs the emulator with ID,
                                ID is an integer form the output of `list`
        emu_ctl targets         shows all possible targets and skins, will only  display targets with abi
        emu_ctl new ID SKIN     creates a new avd with API level according to ID and skin SKIN
                                check `targets` for possible values (depends on installed sdk packages)
                                Only works for targets with default abi
        emu_ctl rm ID           deletes avd with ID returned in list