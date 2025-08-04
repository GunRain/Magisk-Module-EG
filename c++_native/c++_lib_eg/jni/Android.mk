LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(LOCAL_PATH)/main.cc

LOCAL_MODULE := c++_lib_eg

LOCAL_CPPFLAGS := -Wall -Wextra -O3 -std=c++23
LOCAL_LDFLAGS := -Wl,--strip-all

include $(BUILD_SHARED_LIBRARY)