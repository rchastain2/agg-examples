
SOURCES := $(filter-out clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifndef FPGUI
FPGUI := ~/Documents/pascal/sources/fpgui/develop
endif

PFLAGS := -Mobjfpc -Sh -ghl
PFLAGS += -FUunits

ifdef PPU
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
	@rm -fv *.o *.ppu

distclean: clean
	@rm -fv $(TARGETS)
