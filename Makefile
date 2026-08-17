ARCHS = arm64
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = LinkedInUpdateBypass

LinkedInUpdateBypass_FILES = Bypass.m
LinkedInUpdateBypass_FRAMEWORKS = Foundation UIKit
LinkedInUpdateBypass_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/library.mk
