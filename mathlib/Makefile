
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := $(HOME)/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := $(HOME)/Documents/sources/fpgui
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

MATHLIB_VER := 1_4_0
MATHLIB := $(HOME)/Documents/sources/mathlib-fp/$(MATHLIB_VER)/src

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu$(MATHLIB)
PFLAGS += -Fu..

UNITS := units
PFLAGS += -FU$(UNITS)

ifeq ($(OS),Windows_NT)
PREFIX :=
else
PREFIX := ./
endif

.PHONY: all clean distclean

all: $(TARGETS)

%: %.pas aggexample.pas | $(UNITS)
	@rm -fv $@
	@$(PC) $< $(PFLAGS)
	@$(PREFIX)$@

$(UNITS):
	@mkdir $@

clean:
	@rm -fv *.bak *.log

distclean: clean
	@rm -fv $(TARGETS) $(UNITS)/*.o $(UNITS)/*.ppu
