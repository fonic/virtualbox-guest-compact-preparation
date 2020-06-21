# VirtualBox Guest Compact Preparation
Simple script to prepare Windows guests for VDI compacting.

## Download
Refer to the [releases](https://github.com/fonic/virtualbox-guest-additions-updater/releases) section for downloads links.

## Installation
Extract the downloaded archive to `C:\Program Files\VirtualBox Guest Compact Preparation` on your Windows guest. Move the included desktop shortcut to the guest's desktop for easy access.

## Configuration
There's nothing to configure.

## Usage
1. Make sure the Windows guest is up to date (i.e. no updates pending)

2. Run _VirtualBox Guest Compact Preparation_ via desktop shortcut<br/>
   _NOTE: depending on your setup, this may take quite a while to complete_

3. Shutdown the Windows guest

4. On the host, run `VBoxManage modifymedium disk "<vdi-file>" --compact` to compact the guest's VDI file(s)
