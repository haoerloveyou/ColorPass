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
