#
# Copyright (C) 2019 The Android Open Source Project
# Copyright (C) 2019 The TWRP Open Source Project
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
#

_DEVICE := TB128FU
DEVICE_PATH := device/lenovo/$(_DEVICE)
DEVICE_ROOT := $(DEVICE_PATH)/recovery/root

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := bengal
TARGET_NO_BOOTLOADER := true

# Platform
BOARD_USES_QCOM_HARDWARE := true
QCOM_BOARD_PLATFORMS += bengal
TARGET_BOARD_PLATFORM := bengal
TARGET_BOARD_PLATFORM_GPU := qcom-adreno610
TARGET_USES_QCOM_BSP := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 
BOARD_KERNEL_CMDLINE += earlycon=msm_geni_serial,0x4a90000 
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom 
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0 
BOARD_KERNEL_CMDLINE += androidboot.memcg=1 
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000 
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237 
BOARD_KERNEL_CMDLINE += service_locator.enable=1 
BOARD_KERNEL_CMDLINE += swiotlb=2048 
BOARD_KERNEL_CMDLINE += loop.max_part=7 
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive 

BOARD_HEADER_VERSION       := 2
BOARD_KERNEL_PAGESIZE      := 4096
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0x00000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_DTB_OFFSET           := 0x01f00000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBIMAGE_DIR :=  $(DEVICE_PATH)/prebuilt
TARGET_PREBUILT_DTB := $(BOARD_PREBUILT_DTBIMAGE_DIR)/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144                       # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06000000
BOARD_BOOTIMAGE_PARTITION_SIZE     := 0x06000000

# File system
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

# dynamic partitions
BOARD_SUPER_PARTITION_SIZE := 0x200000000
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor
# BOARD_QTI_DYNAMIC_PARTITIONS_SIZE = (BOARD_SUPER_PARTITION_SIZE/2) - 4MB
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 0xFFC00000

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# We need /cache (Tablet does not have it tho)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 102400 # Who cares?

BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_USES_PRODUCTIMAGE := true

# the usual hack
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Metadata
BOARD_USES_METADATA_PARTITION := true

#Assert
TARGET_OTA_ASSERT_DEVICE := $(_DEVICE)

# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# decryption
TW_INCLUDE_CRYPTO := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

#AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Treble
BOARD_VNDK_VERSION := current

# TWRP flags
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_TOUCHSCREEN_FLIP_Y := true
RECOVERY_TOUCHSCREEN_SWAP_XY := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_DEFAULT_BRIGHTNESS := "80"
TW_DEVICE_VERSION := Royna
TW_EXCLUDE_APEX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_TWRPAPP := true
TW_EXTRA_LANGUAGES := true
TW_HAS_EDL_MODE := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_PYTHON := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_ROTATION := 270
TW_SCREEN_BLANK_ON_BOOT := true
TW_THEME := landscape_hdpi
TW_USE_TOOLBOX := true

# TWRP Debug Flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true

TW_OVERRIDE_SYSTEM_PROPS := \ "ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

