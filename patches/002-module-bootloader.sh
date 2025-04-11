#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Remove btrfs and zfs subvolume mechanism
sed -i -r 's/(def is_(btrfs|zfs)_root\(partition\):)/\1\n    return False/g' src/modules/bootloader/main.py

# Patches for grub-install and grub-mkconfig to install without chroot
sed -i -r 's/(def install_grub\(efi_directory, fw_type\):)/\1\n    installation_root_path = libcalamares.globalstorage.value\("rootMountPoint"\)/g' src/modules/bootloader/main.py
sed -i -r 's/(run_grub_install\(\w+,\s?\w+,)(\s?\w+\))/\1 installation_root_path,\2/g' src/modules/bootloader/main.py
sed -i -r 's/(libcalamares\.job\.configuration\["grubInstall"\],)/\1 "--boot-directory=" + installation_root_path + "\/boot",/g' src/modules/bootloader/main.py
sed -i -r 's/("--efi-directory=" \+)( efi_directory,)/\1 installation_root_path +\2/g' src/modules/bootloader/main.py
sed -i -r 's/(libcalamares\.job\.configuration\["grubCfg"\])/installation_root_path + \1/g' src/modules/bootloader/main.py

# Disable use_systemd_naming
sed -i -r 's/(use_systemd_naming = ).+/\1False/g' src/modules/bootloader/main.py

# Return right after refind-install to prevent non-related configurations
sed -i -r 's/(\s+)(check_target_env_call)\(\["refind-install"\]\)/\1\2(["refind-install --alldrivers"])\n\1open(conf_path, "w")\n\1return/g' src/modules/bootloader/main.py
