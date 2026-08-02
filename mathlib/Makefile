
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

MATHLIB_VER := 1_4_0
MATHLIB := $(HOME)/Documents/sources/mathlib-fp/$(MATHLIB_VER)/src

PC := fpc
PFLAGS := -Mdelphi
PFLAGS += -Fi$(AGGPAS)
PFLAGS += -Fu$(AGGPAS)
ifndef LCL
PFLAGS += -Fu$(AGGEXT)
endif
PFLAGS += -Fu$(MATHLIB)

# Directory for compiled units
UNITS := units

PFLAGS += -FU$(UNITS)

ifeq ($(OS),Windows_NT)
PREFIX :=
else
PREFIX := ./
endif

all: $(TARGETS)

%: %.pas $(UNITS)
	$(info [INFO] Compile $<)
	@$(PC) $< $(PFLAGS)
	$(info [INFO] Execute $@)
	@$(PREFIX)$@

$(UNITS):
	$(info [INFO] Create directory for compiled units)
	@mkdir $@

clean:
	@rm -fv *.bak *.log

distclean: clean
	@rm -fv $(TARGETS) units/*.o units/*.ppu
