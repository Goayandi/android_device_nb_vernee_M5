#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifneq ($(MTKPATH),)
-include $(MTKPATH)/BoardConfigVendor.mk
endif

# include non-open-source-parts
include vendor/nb/vernee_M5/vernee_M5-vendor.mk


TARGET_CYANOGEN_COMMON := mt6755

COMMON_PATH := device/nb/vernee_M5
TARGET_SPECIFIC_HEADER_PATH := $(COMMON_PATH)/include

TARGET_BOARD_PLATFORM ?= mt6755

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

BOARD_FLASH_BLOCK_SIZE := 4096

MTK_PROJECT_CONFIG := $(COMMON_PATH)/ProjectConfig.mk
include $(MTK_PROJECT_CONFIG)

MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$($(t))\"))

BOARD_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)
BOARD_GLOBAL_CPPFLAGS += $(MTK_INTERNAL_CDEFS)

# Common properties
TARGET_SYSTEM_PROP := $(COMMON_PATH)/system.prop

# FSTAB
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/fstab.mt6755

# Audio
BOARD_USES_MTK_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1
USE_CUSTOM_AUDIO_POLICY := 1

# Bootloader
TARGET_NO_BOOTLOADER := true

# Kernel
TARGET_USES_64_BIT_BINDER := true

BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_MKBOOTIMG_ARGS := --board "1509963705" --kernel_offset 0x00008000 --ramdisk_offset 0x04f88000 --tags_offset 0x03f88000

# Partition details
#TODO: Set correct values
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 10612759
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10612759 # Temporary
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 528482304
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3699437568
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57529056256
BOARD_FLASH_BLOCK_SIZE := 4096


# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_HCILP_INCLUDED := 0
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_PATH)/bluetooth/include
BOARD_CONNECTIVITY_MODULE := conn_soc

# CMHW
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS += $(COMMON_PATH)/cmhw

ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
		WITH_DEXPREOPT ?= true
  endif
endif

# Display
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 1
PRESENT_TIME_OFFSET_FROM_VSYNC_NS := 0
MTK_HWC_SUPPORT := yes
MTK_HWC_VERSION := 1.5.0

# Mediatek support
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
MTK_HARDWARE := true
MTK_SEPOLICY := true

# Media
TARGET_HAS_LEGACY_CAMERA_HAL1 := true
TARGET_OMX_LEGACY_RESCALING := true

# GPS
ifeq ($(MTK_GPS_SUPPORT), yes)
    BOARD_GPS_LIBRARIES := true
else
    BOARD_GPS_LIBRARIES := false
endif
BOARD_MEDIATEK_USES_GPS := true

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true

# RIL
BOARD_RIL_CLASS := ../../../device/nb/vernee_M5/ril

# Releasetools
#TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)

# Sensors
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_NO_SENSOR_PERMISSION_CHECK := true

# SELinux
BOARD_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy
BOARD_SECCOMP_POLICY := $(COMMON_PATH)/seccomp

# Wireless
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM := /dev/wmtWifi
WIFI_DRIVER_FW_PATH_AP := AP
WIFI_DRIVER_FW_PATH_STA := STA
WIFI_DRIVER_FW_PATH_P2P := P2P

# Release Tools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)

# Misc
EXTENDED_FONT_FOOTPRINT := true

# TWRP
RECOVERY_VARIANT := twrp
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
DEVICE_RESOLUTION := 720x1280
DEVICE_SCREEN_WIDTH := 720
DEVICE_SCREEN_HEIGHT := 1280
TW_THEME := portrait_hdpi
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_DEVICE_VERSION := 0
RECOVERY_SDCARD_ON_DATA := true
TW_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness/
TW_INCLUDE_CRYPTO := true
TW_MAX_BRIGHTNESS := 255
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"
