
SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

FPGUI ?= $(HOME)/Documents/sources/fpgui

PC := fpc
PFLAGS := -Mobjfpc -Sh

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
PFLAGS += -Fu../..

UNITS := units
PFLAGS += -FU$(UNITS)

.PHONY: all clean distclean

all: $(TARGETS)

%: %.pas | $(UNITS)
	@$(PC) $< $(PFLAGS)

$(UNITS):
	@mkdir $@

clean:
	@rm -fv $(UNITS)/*.o $(UNITS)/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
