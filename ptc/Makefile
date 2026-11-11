
SOURCES := $(wildcard *.pas)
TARGETS := $(SOURCES:%.pas=%)

ifdef LCL
LAZARUS := $(HOME)/Documents/sources/lazarus
AGGPAS := $(LAZARUS)/components/aggpas/src
else
FPGUI := $(HOME)/Documents/sources/fpgui
AGGPAS := $(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

PC := fpc
PFLAGS := -Mobjfpc -Sh
PFLAGS += -Fu$(AGGPAS)
PFLAGS += -Fu..

UNITS := units
PFLAGS += -FU$(UNITS)

.PHONY: all clean distclean

all: $(TARGETS)

%: %.pas | $(UNITS)
	@$(PC) $< $(PFLAGS)

$(UNITS):
	@mkdir $@

clean:
	@rm -fv *.bak *.bak? *.log $(UNITS)/*.o $(UNITS)/*.ppu

distclean: clean
	@rm -fv $(TARGETS)
