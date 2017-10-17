#
# Component Makefile
#

COMPONENT_ADD_INCLUDEDIRS := platform/os/include IoT-SDK_V2.0/src/sdk-impl/include IoT-SDK_V2.0/src/sdk-impl/imports IoT-SDK_V2.0/src/mqtt $(IDF_PATH)/components/mbedtls/include IoT-SDK_V2.0/src/sdk-impl IoT-SDK_V2.0/src/packages/LITE-log IoT-SDK_V2.0/src/packages/LITE-utils IoT-SDK_V2.0/src/packages/LITE-utils IoT-SDK_V2.0/src/utils/digest IoT-SDK_V2.0/src/utils/misc IoT-SDK_V2.0/src/import/desktop/include IoT-SDK_V2.0/src/system IoT-SDK_V2.0/src/guider IoT-SDK_V2.0/src/security

COMPONENT_SRCDIRS := platform/os/esp32 IoT-SDK_V2.0/src platform/ssl/mbedtls IoT-SDK_V2.0/src/guider IoT-SDK_V2.0/src/mqtt IoT-SDK_V2.0/src/ota IoT-SDK_V2.0/src/scripts IoT-SDK_V2.0/src/security IoT-SDK_V2.0/src/shadow IoT-SDK_V2.0/src/system IoT-SDK_V2.0/src/packages/LITE-utils IoT-SDK_V2.0/src/packages/LITE-log IoT-SDK_V2.0/src/packages IoT-SDK_V2.0/src/utils/digest IoT-SDK_V2.0/src/utils/misc IoT-SDK_V2.0/src/sdk-impl IoT-SDK_V2.0/src/mqtt/MQTTPacket
