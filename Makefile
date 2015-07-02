ARCHS = armv7 arm64

TARGET = iphone:clang:latest:5.0

include theos/makefiles/common.mk

TWEAK_NAME = ColorPass
ColorPass_FILES = Tweak.xm
ColorPass_FRAMEWORKS = UIKit Foundation 
ColorPass_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += colorpassprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
