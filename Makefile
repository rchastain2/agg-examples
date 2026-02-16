
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := ~/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := ~/Documents/pascal/sources/fpgui/develop
#AGGPAS := $(FPGUI)/src/corelib/render/software
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
AGGEXT := $(FPGUI)/extras/aggpas
endif

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -ghl
#PFLAGS += -vt

PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)/platform/linux
PFLAGS += -Fu$(AGGPAS)/ctrl
PFLAGS += -Fu$(AGGPAS)/util
ifndef LCL
PFLAGS += -Fu$(AGGEXT)
endif

PFLAGS += -FUunits

all: $(TARGETS)

%: %.pas
ifeq ($(USER),roland)
	#pcfi $<
endif
ifeq ($(OS),Windows_NT)
	@if not exist units mkdir units
else
	@[ -d units ] || mkdir -p units
endif
	@rm -fv $@
	@$(PC) $< $(PFLAGS)
	@./$@

clean:
	@rm -fv units/*.o units/*.ppu
	@rm -fv *.bak *.log

distclean: clean
	@rm -fv $(TARGETS)
