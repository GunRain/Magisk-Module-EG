LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(LOCAL_PATH)/main.cpp

LOCAL_MODULE := c++_exe_eg

LOCAL_CPPFLAGS := -static -O3

include $(BUILD_EXECUTABLE)