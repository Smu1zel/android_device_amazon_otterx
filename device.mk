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

$(call inherit-product-if-exists, hardware/ti/omap4/omap4.mk)

#ifeq ($(TARGET_PREBUILT_KERNEL),)
#LOCAL_KERNEL := $(DEVICE_FOLDER)-kernel/kernel
#else
#LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
#endif

#PRODUCT_COPY_FILES := \
#	$(LOCAL_KERNEL):kernel

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi
# A list of dpis to select prebuilt apk, in precedence order.
PRODUCT_AAPT_PREBUILT_DPI := mdpi hdpi xhdpi

# Device overlay
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/fstab.otterx:/root/fstab.otterx \
    $(DEVICE_FOLDER)/init.otterx.rc:/root/init.otterx.rc \
    $(DEVICE_FOLDER)/init.otterx.usb.rc:/root/init.otterx.usb.rc \
    $(DEVICE_FOLDER)/init.recovery.otterx.rc:/root/init.recovery.otterx.rc \
    $(DEVICE_FOLDER)/ueventd.otterx.rc:/root/ueventd.otterx.rc

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# Hardware HALs
PRODUCT_PACKAGES += \
    lights.otterx \
    power.otterx \
    sensors.otterx \
    audio.primary.otterx \
    audio_policy.default \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler

# Misc
PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    charger_res_images

# Filesystem management tools
PRODUCT_PACKAGES += \
    sdcard \
    setup_fs \
    make_ext4fs \
    e2fsck \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs

# Audio Support
PRODUCT_PACKAGES += \
    libaudioutils \
    tinyplay \
    tinymix \
    tinycap \

# Misc / Testing
PRODUCT_PACKAGES += \
    strace \
    libjni_pinyinime \
    sh

ADDITIONAL_BUILD_PROPERTIES += \
    ro.sf.lcd_density=160

# Set dirty regions off
ADDITIONAL_BUILD_PROPERTIES += \
    hwui.render_dirty_regions=false

# wifi-only device
ADDITIONAL_BUILD_PROPERTIES += \
    ro.carrier=wifi-only

# Recovery USB
ADDITIONAL_BUILD_PROPERTIES += \
    usb.vendor=1949 \
    usb.product.adb=0006 \
    usb.product.mtpadb=0006

# Low-RAM optimizations
ADDITIONAL_BUILD_PROPERTIES += \
    ro.config.low_ram=true \
    persist.sys.force_highendgfx=true \
    dalvik.vm.jit.codecachesize=0 \
    config.disable_atlas=true \
    ro.config.max_starting_bg=8 \
    ro.sys.fw.bg_apps_limit=16 \
    sys.mem.max_hidden_apps=10

# Device settings
ADDITIONAL_BUILD_PROPERTIES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=120 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    omap.enhancement=true \
    ro.crypto.state=unencrypted \
    persist.sys.usb.config=mtp,adb \
    persist.sys.root_access=3 \
    ro.bq.gpu_to_cpu_unsupported=1 \
    media.stagefright.cache-params=18432/20480/15 \
    ro.ksm.default=1 \
    camera2.portability.force_api=1 \
    omap.audio.mic.main=AMic0 \
    omap.audio.mic.sub=AMic1 \
    omap.audio.power=PingPong \

PRODUCT_CHARACTERISTICS := tablet,nosdcard

PRODUCT_LOCALES := en_US es_US de_DE zh_CN

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapgrowthlimit=48m \
    dalvik.vm.heapsize=128m \
    dalvik.vm.heaptargetutilization=0.9 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=2m

$(call inherit-product-if-exists, vendor/amazon/otterx/device-vendor.mk)
