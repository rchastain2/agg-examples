
SOURCES := $(filter-out aggexample.pas clocksize.pas clockutils.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := ~/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := ~/Documents/sources/fpgui
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -ghl
#PFLAGS += -vt

PFLAGS += -Fu$(AGGPAS)

PFLAGS += -FUunits

all: $(TARGETS)

%: %.pas
ifeq ($(USER),roland)
	#pcfi $<
endif
	#lua pcb.lua agg_2d.txt $<
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
