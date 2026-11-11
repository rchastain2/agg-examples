
SOURCES := $(filter-out clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

FPGUI ?= $(HOME)/Documents/sources/fpgui

PC := fpc
PFLAGS := -Mobjfpc -Sh
#PFLAGS += -ghl

ifdef PPU
PFLAGS += -Fu$(FPGUI)/framework/target/units
else
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/x11
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/gui
PFLAGS += -Fi$(FPGUI)/framework/src/main/resources
endif

PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/extras/aggpas
PFLAGS += -Fu../..
PFLAGS += -Fifactory

UNITS := units
PFLAGS += -FU$(UNITS)

.PHONY: all clean distclean

all: $(TARGETS)

demo: clockutils.pas factory/clocksize.inc

%: %.pas | $(UNITS)
	@$(PC) $< $(PFLAGS)

$(UNITS):
	@mkdir $@

clean:
	@rm -fv $(UNITS)/*.o $(UNITS)/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
