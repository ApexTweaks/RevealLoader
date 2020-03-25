FINALPACKAGE=1
include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e

TWEAK_NAME = RevealLoader

RevealLoader_FILES = Tweak.xm
RevealLoader_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
