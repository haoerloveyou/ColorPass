ARCHS = armv7 arm64
TARGET = iphone:clang:latest:9.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

BUNDLE_NAME = colorpass
colorpass_CFLAGS = -fno-objc-arc
colorpass_FILES = colorpass.mm About.mm
colorpass_INSTALL_PATH = /Library/PreferenceBundles
colorpass_FRAMEWORKS = Foundation UIKit MessageUI Social CoreGraphics
colorpass_LIBRARIES = colorpicker MobileGestalt
colorpass_PRIVATE_FRAMEWORKS = Preferences



include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/colorpass.plist$(ECHO_END)
