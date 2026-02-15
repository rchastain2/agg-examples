
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

FPGUI := ~/Documents/pascal/sources/fpgui/develop

## fpGUI 1
#AGGPAS := $(FPGUI)/src/corelib/render/software

## fpGUI 2
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
AGGEXT := $(FPGUI)/extras/aggpas

#LAZARUS := ~/Documents/sources/lazarus
#AGGPAS := $(LAZARUS)/components/aggpas/src

PFLAGS := -Mdelphi
PFLAGS += -ghl

PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)/platform/linux
PFLAGS += -Fu$(AGGPAS)/ctrl
PFLAGS += -Fu$(AGGPAS)/util
PFLAGS += -Fu$(AGGEXT)

PFLAGS += -FUunits

all: $(TARGETS)

%: %.pas
ifeq ($(OS),Windows_NT)
	@if not exist units mkdir units
else
	@[ -d units ] || mkdir -p units
endif
	@[ -d units ] || mkdir -p units
	@rm -fv $@
	@fpc $< $(PFLAGS)
	@./$@

clean:
	@rm -fv units/*.o units/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
