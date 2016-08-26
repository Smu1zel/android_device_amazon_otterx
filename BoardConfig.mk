#
# Copyright 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
-include vendor/amazon/otterx/BoardConfigVendor.mk

DEVICE_FOLDER := device/amazon/otterx
TARGET_BOARD_OMAP_CPU := 4430

# inherit from omap4
-include hardware/ti/omap4/BoardConfigCommon.mk

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_TI := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_FOLDER)/bluetooth

# Camera
TI_OMAP4_CAMERAHAL_VARIANT := false
USE_CAMERA_STUB := true

# Audio
BOARD_USES_GENERIC_AUDIO := false

# GCC
KERNEL_TOOLCHAIN_PREFIX := arm-eabi-
KERNEL_TOOLCHAIN := $(shell pwd)/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin

# WLAN Build
WLAN_MODULES:
	make clean -C hardware/ti/wlan/mac80211/compat_wl12xx
	make -j8 -C hardware/ti/wlan/mac80211/compat_wl12xx KERNEL_DIR=$(KERNEL_OUT) KLIB=$(KERNEL_OUT) KLIB_BUILD=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/compat/compat.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/mac80211/mac80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/wireless/cfg80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_spi.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_sdio.ko $(KERNEL_MODULES_OUT)
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/cfg80211.ko
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/compat.ko
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/mac80211.ko
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/wl12xx.ko
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/wl12xx_sdio.ko
	$(KERNEL_TOOLCHAIN)/$(KERNEL_TOOLCHAIN_PREFIX)strip --strip-unneeded $(KERNEL_MODULES_OUT)/wl12xx_spi.ko

TARGET_KERNEL_MODULES += WLAN_MODULES

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_RAMDISK_OFFSET := 0x2000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := mem=512M omapfb.fb_opt=-1,-1,-1,1,1024,600 cma=8M androidboot.selinux=permissive newbootargs
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
TARGET_BOOTLOADER_BOARD_NAME := otterx
TARGET_OTA_ASSERT_DEVICE := otterx
TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/ti/omap
TARGET_KERNEL_CONFIG := android_omap4_defconfig
TARGET_KERNEL_VARIANT_CONFIG := android_otterx_defconfig
TARGET_KERNEL_SELINUX_CONFIG := selinux_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_CACHEIMAGE_PARTITION_SIZE := 536870912
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 801112064
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6083296830

# Connectivity - Wi-Fi
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_FOLDER)/fstab.otterx
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

BOARD_SEPOLICY_DIRS += \
    $(DEVICE_FOLDER)/sepolicy

# Enable dalvik startup with a low memory footprint
TARGET_ARCH_LOWMEM := true
MALLOC_SVELTE := true