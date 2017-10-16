#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

PROJECT_NAME := main

COMPONENT_ADD_INCLUDEDIRS := components/esp32-aliyun/platform/os/include

include $(IDF_PATH)/make/project.mk
