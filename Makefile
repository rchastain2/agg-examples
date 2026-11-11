
SOURCES := $(filter-out aggexample.pas clockutils.pas palette.pas,$(wildcard *.pas))
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
PFLAGS += -Fu$(AGGPAS)

UNITS := units
PFLAGS += -FU$(UNITS)

ifeq ($(OS),Windows_NT)
PREFIX :=
else
PREFIX := ./
endif

.PHONY: all clean distclean

all: $(TARGETS)

clock: clockutils.pas

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
