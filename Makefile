
SOURCES := $(filter-out aggexample.pas,$(wildcard *.pas))
TARGETS := $(SOURCES:%.pas=%)

#FPGUI := ~/Documents/pascal/sources/fpgui/1dde402
FPGUI := ~/Documents/pascal/sources/fpgui/develop
#AGGPAS := $(FPGUI)/src/corelib/render/software
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software

#LAZARUS := ~/Documents/sources/lazarus
#AGGPAS := $(LAZARUS)/components/aggpas/src

PFLAGS := -Mdelphi
PFLAGS += -ghl

PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)/platform/linux
PFLAGS += -Fu$(AGGPAS)/ctrl
PFLAGS += -Fu$(AGGPAS)/util

PFLAGS += -Fu$(FPGUI)/extras/aggpas

all: $(TARGETS)

%: %.pas
	@rm -fv $@
	@fpc $< $(PFLAGS)
	@./$@

clean:
	@rm -fv *.o *.ppu

distclean: clean
	@rm -fv $(TARGETS)
