#
# Component Makefile
#

COMPONENT_ADD_INCLUDEDIRS := platform/os/include IoT-SDK/src/tfs IoT-SDK/src/packages/iot-coap-c IoT-SDK/src/tfs/platform IoT-SDK/src/sdk-impl/exports IoT-SDK/src/sdk-impl/imports IoT-SDK/src/mqtt $(IDF_PATH)/components/mbedtls/include IoT-SDK/src/sdk-impl IoT-SDK/src/packages/LITE-log IoT-SDK/src/packages/LITE-utils IoT-SDK/src/packages/LITE-utils IoT-SDK/src/utils/digest IoT-SDK/src/utils/misc IoT-SDK/src/import/desktop/include/tfs IoT-SDK/src/system IoT-SDK/src/guider IoT-SDK/src/security

COMPONENT_SRCDIRS := platform/os/esp32 IoT-SDK/src/tfs IoT-SDK/src/packages/iot-coap-c IoT-SDK/src/tfs/platform IoT-SDK/src platform/ssl/mbedtls IoT-SDK/src/guider IoT-SDK/src/coap IoT-SDK/src/mqtt IoT-SDK/src/ota IoT-SDK/src/scripts IoT-SDK/src/security IoT-SDK/src/shadow IoT-SDK/src/system IoT-SDK/src/packages/LITE-utils IoT-SDK/src/packages/LITE-log IoT-SDK/src/packages IoT-SDK/src/utils/digest IoT-SDK/src/utils/misc IoT-SDK/src/sdk-impl IoT-SDK/src/mqtt/MQTTPacket

CFLAGS += -D IOTX_DEBUG

CFLAGS += -D MQTT_COMM_ENABLED

CFLAGS += -D OTA_SIGNAL_CHANNEL=1