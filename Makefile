THEOS_PACKAGE_DIR_NAME = debs
TARGET = iphone:clang:latest:9.0
ARCHS = armv7 arm64
THEOS_DEVICE_IP = 10.0.1.32
PACKAGE_VERSION = 1.2

include theos/makefiles/common.mk

TWEAK_NAME = ColorPass
ColorPass_FILES = Tweak.xm
ColorPass_FRAMEWORKS = UIKit Foundation
ColorPass_LIBRARIES = colorpicker
ColorPass_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk


SUBPROJECTS += colorpass
include $(THEOS_MAKE_PATH)/aggregate.mk

export GO_EASY_ON_ME := 1

after-install::
	install.exec "killall -9 SpringBoard"
