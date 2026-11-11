
SOURCES := $(filter-out clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifndef FPGUI
FPGUI := ~/Documents/sources/fpgui
endif

PFLAGS := -Mobjfpc -Sh -ghl
PFLAGS += -FUunits

ifdef PPU
PFLAGS += -Fu$(FPGUI)/framework/target/units
else
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui
PFLAGS += -Fi$(FPGUI)/framework/target

#PFLAGS += -dAGGCanvas
endif

PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/extras/aggpas

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
