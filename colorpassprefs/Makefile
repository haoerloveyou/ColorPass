ARCHS = armv7 arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

BUNDLE_NAME = colorpassprefs
colorpassprefs_CFLAGS = -fno-objc-arc
colorpassprefs_FILES = colorpassprefsListController.mm About.mm 
colorpassprefs_INSTALL_PATH = /Library/PreferenceBundles
colorpassprefs_FRAMEWORKS = Foundation UIKit MessageUI Social CoreGraphics
colorpassprefs_LIBRARIES = colorpicker MobileGestalt
colorpassprefs_PRIVATE_FRAMEWORKS = Preferences



include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard; killall -9 backboardd"

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/colorpassprefs.plist$(ECHO_END)
