
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := $(HOME)/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := $(HOME)/Documents/sources/fpgui
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
AGGEXT := $(FPGUI)/extras/aggpas
endif

MATHLIB_VER := 1_3_0
MATHLIB := $(HOME)/Documents/sources/mathlib-fp/$(MATHLIB_VER)/src

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
ifndef LCL
PFLAGS += -Fu$(AGGEXT)
endif
PFLAGS += -Fu$(MATHLIB)

PFLAGS += -FUunits

all: $(TARGETS)

%: %.pas
ifeq ($(OS),Windows_NT)
	@if not exist units mkdir units
else
	@[ -d units ] || mkdir -p units
endif
	@rm -fv $@
	@$(PC) $< $(PFLAGS)
	@./$@

clean:
	@rm -fv *.bak *.log $(TARGETS)

distclean: clean
	@rm -fv units/*.o units/*.ppu
