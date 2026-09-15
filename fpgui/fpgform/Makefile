
SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

FPGUI := ~/Documents/pascal/sources/fpgui/develop

PFLAGS := -Mobjfpc -Sh
PFLAGS += -FUunits

ifdef USE_PPU
PFLAGS += -Fu$(FPGUI)/framework/target/units
else
#PFLAGS += -Fi$(FPGUI)/src
#PFLAGS += -Fi$(FPGUI)/src/corelib
#PFLAGS += -Fu$(FPGUI)/src/corelib
#PFLAGS += -Fi$(FPGUI)/src/corelib/x11
#PFLAGS += -Fu$(FPGUI)/src/corelib/x11
#PFLAGS += -Fu$(FPGUI)/src/gui
#PFLAGS += -Fu$(FPGUI)/src/3rdparty/regex

PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui/db
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/3rdparty/regex
PFLAGS += -Fi$(FPGUI)/framework/target

#PFLAGS += -Fi$(FPGUI)/src/corelib/render/software
#PFLAGS += -Fu$(FPGUI)/src/corelib/render/software
#PFLAGS += -Fu$(FPGUI)/src/corelib/render/software/platform/linux
#PFLAGS += -Fu$(FPGUI)/src/corelib/render/software/ctrl
#PFLAGS += -Fu$(FPGUI)/src/corelib/render/software/util

PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software

PFLAGS += -Fu$(FPGUI)/extras/aggpas

#PFLAGS += -dAGGCanvas
endif

all: $(TARGETS)

%: %.pas
ifeq ($(OS),Windows_NT)
	@if not exist units mkdir units
else
	@[ -d units ] || mkdir -p units
endif
	@fpc $< $(PFLAGS)

clean:
	@rm -fv units/*.o units/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
