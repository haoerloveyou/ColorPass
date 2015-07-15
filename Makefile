ARCHS = armv7 arm64

TARGET = iphone:clang:latest:5.0

include theos/makefiles/common.mk

TWEAK_NAME = ColorPass
ColorPass_FILES = Tweak.xm
ColorPass_FRAMEWORKS = UIKit Foundation 
ColorPass_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += colorpassprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

export GO_EASY_ON_ME := 1

after-install::
	install.exec "killall -9 SpringBoard; killall -9 backboardd"


