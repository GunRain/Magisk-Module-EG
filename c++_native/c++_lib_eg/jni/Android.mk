LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(LOCAL_PATH)/main.cpp

LOCAL_MODULE := c++_lib_eg

LOCAL_CPPFLAGS := -O3

include $(BUILD_SHARED_LIBRARY)