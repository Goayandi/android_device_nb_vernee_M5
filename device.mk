#
# Copyright 2014 The Android Open-Source Project
# Copyright (C) 2018 Tobias Tefke
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

DEVICE_PATH := device/nb/vernee_M5

# Prebuilt kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := $(DEVICE_PATH)/boot.img-kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, vendor/nb/vernee_M5/vernee_M5-vendor.mk)

# Inherit from MTK_PROJECT_CONFIG
MTK_PROJECT_CONFIG ?= $(DEVICE_PATH)/ProjectConfig.mk
include $(MTK_PROJECT_CONFIG)

# Copy ProjectConfig.mk
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/ProjectConfig.mk:system/vendor/data/misc/ProjectConfig.mk

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissionsandroid.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.device_admin.xml:system/etc/permissions/android.software.device_admin.xml \
    frameworks/native/data/etc/android.software.managed_users.xml:system/etc/permissions/android.software.managed_users.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.webview.xml:system/etc/permissions/android.software.webview.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    $(DEVICE_PATH)/permissions/android.hardware.microphone.xml:system/etc/permissions/android.hardware.microphone.xml \
    $(DEVICE_PATH)/permissions/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    $(DEVICE_PATH)/permissions/com.android.location.provider.xml:system/etc/permissions/com.android.location.provider.xml \
    $(DEVICE_PATH)/permissions/com.android.media.remotedisplay.xml:system/etc/permissions/com.android.media.remotedisplay.xml \
    $(DEVICE_PATH)/permissions/com.android.mediadrm.signer.xml:system/etc/permissions/com.android.mediadrm.signer.xml \
    $(DEVICE_PATH)/permissions/platform.xml:system/etc/permissions/platform.xml

# default.prop overrides
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.all_log=0 \
    persist.sys.usb.config=mtp \
    camera.disable_zsl_mode=1

# Audio
$(call inherit-product, $(DEVICE_PATH)/configs/audio/audio_param/audio.mk)

# Bluetooth
$(call inherit-product, $(DEVICE_PATH)/bluetooth/bluetooth.mk)

# Carrier configs
$(call inherit-product, $(DEVICE_PATH)/configs/carrier/carrier.mk)

# Media
$(call inherit-product, $(DEVICE_PATH)/configs/media/media.mk)

# Internet access
$(call inherit-product, $(DEVICE_PATH)/configs/ip/ip.mk)

# legacy apache http client
PRODUCT_COPY_FILES += \
    prebuilts/sdk/org.apache.http.legacy/org.apache.http.legacy.jar:system/framework/org.apache.http.legacy.jar

# Other configuration files
$(call inherit-product, $(DEVICE_PATH)/configs/configs.mk)

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_PREBUILT_DPI := xhdpi hdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# FlipFlap
PRODUCT_PACKAGES += \
    FlipFlap

# GPS
PRODUCT_PACKAGES += \
    YGPS

# Snap
PRODUCT_PACKAGES += \
    Snap

# Shims
PRODUCT_PACKAGES += \
    libshim_libgui_ext \
    libshim_program_binary_builder \
    libshim_vtservice

# Dalvik configurations
$(call inherit-product, frameworks/native/build/phone-xxxhdpi-4096-dalvik-heap.mk)
$(call inherit-product, frameworks/native/build/phone-xxxhdpi-4096-hwui-memory.mk)

# Inherit the rest from mt6755-common
$(call inherit-product, $(DEVICE_PATH)/mt6755.mk)
