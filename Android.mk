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

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

ifneq ($(filter otterx, $(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)

include $(call all-makefiles-under,$(LOCAL_PATH))

#Create WLAN NVS symlink
include $(CLEAR_VARS)

LOCAL_MODULE := wlan_nvs_symlink
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): WLAN_NVS_FILE := /data/misc/wifi/wl1271-nvs.bin
$(LOCAL_BUILT_MODULE): WLAN_NVS_SYMLINK := $(TARGET_OUT)/etc/firmware/ti-connectivity/wl1271-nvs.bin
$(LOCAL_BUILT_MODULE): $(LOCAL_PATH)/Android.mk
$(LOCAL_BUILT_MODULE):
	$(hide) echo "Symlink: $(WLAN_NVS_SYMLINK) -> $(WLAN_NVS_FILE)"
	$(hide) mkdir -p $(dir $@)
	$(hide) mkdir -p $(dir $(WLAN_NVS_SYMLINK))
	$(hide) rm -rf $@
	$(hide) rm -rf $(WLAN_NVS_SYMLINK)
	$(hide) ln -sf $(WLAN_NVS_FILE) $(WLAN_NVS_SYMLINK)
	$(hide) touch $@

endif
