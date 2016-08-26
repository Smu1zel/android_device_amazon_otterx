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

DEVICE_FOLDER := device/amazon/otterx

#ifeq ($(TARGET_PREBUILT_KERNEL),)
#LOCAL_KERNEL := $(DEVICE_FOLDER)-kernel/kernel
#else
#LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
#endif

#PRODUCT_COPY_FILES := \
#	$(LOCAL_KERNEL):kernel

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/fstab.otterx:/root/fstab.otterx \
    $(DEVICE_FOLDER)/init.otterx.rc:/root/init.otterx.rc \
    $(DEVICE_FOLDER)/init.otterx.usb.rc:/root/init.otterx.usb.rc \
    $(DEVICE_FOLDER)/init.recovery.otterx.rc:/root/init.recovery.otterx.rc \
    $(DEVICE_FOLDER)/ueventd.otterx.rc:/root/ueventd.otterx.rc

$(call inherit-product-if-exists, vendor/amazon/otterx/device-vendor.mk)
