
SOURCES := $(filter-out aggexample.pas clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := ~/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := ~/Documents/pascal/sources/fpgui/develop
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
AGGEXT := $(FPGUI)/extras/aggpas
endif

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
ifndef LCL
PFLAGS += -Fu$(AGGEXT)
endif

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
