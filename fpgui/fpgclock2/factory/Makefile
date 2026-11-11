
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := $(HOME)/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := $(HOME)/Documents/sources/fpgui
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -ghl
#PFLAGS += -vt
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu../../..

UNITS := units
PFLAGS += -FU$(UNITS)

ifeq ($(OS),Windows_NT)
PREFIX :=
else
PREFIX := ./
endif

.PHONY: all clean distclean

all: $(TARGETS)

static: clocksize.inc

%: %.pas aggexample.pas | $(UNITS)
	@rm -fv $@
	@$(PC) $< $(PFLAGS)
	@$(PREFIX)$@

$(UNITS):
	@mkdir $@

clean:
	@rm -fv *.bak *.log $(TARGETS)

distclean: clean
	@rm -fv $(UNITS)/*.o $(UNITS)/*.ppu
