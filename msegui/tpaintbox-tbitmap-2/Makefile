
ifndef MSEGUI
MSEGUI := mseide-msegui
# git clone https://github.com/mse-org/mseide-msegui.git
# git clone https://github.com/mse-org/mseide-msegui.git --single-branch --depth 1
endif

ifndef FPGUI
FPGUI := fpgui
# git clone https://github.com/graemeg/fpGUI.git fpgui
# git clone https://github.com/graemeg/fpGUI.git fpgui --single-branch --depth 1
endif

ifeq ($(OS),Windows_NT)
OS := windows
else
OS := linux
endif

PC := fpc
PFLAGS := -Mobjfpc -Sh
PFLAGS += -Fu$(MSEGUI)/lib/common/*
PFLAGS += -Fu$(MSEGUI)/lib/common/kernel/$(OS)

TEMP := units
PFLAGS += -FU$(TEMP)

ifdef PPU
PFLAGS += -Fu$(FPGUI)/framework/target/units
else
PFLAGS += -Fi$(FPGUI)/framework/src/main/pascal/corelib/render/software
PFLAGS += -Fu$(FPGUI)/framework/src/main/pascal/corelib/render/software
endif

PFLAGS += -vhq
#PFLAGS += -vm6058
#PFLAGS += -vm4046
#PFLAGS += -vm5062
#PFLAGS += -vm5024
#PFLAGS += -vm5071

ifdef DEBUG
PFLAGS += -gl
else
PFLAGS += -dRELEASE
PFLAGS += -XX -Xs -CX
endif

PROGRAM := demo
SOURCES := $(filter-out $(PROGRAM).pas,$(wildcard *.pas))

$(PROGRAM): $(PROGRAM).pas $(SOURCES) $(TEMP)
	@$(PC) $(PFLAGS) $<

$(TEMP):
	mkdir $@

clean:
	rm -f $(TARGETS) $(TEMP)/*.o $(TEMP)/*.ppu

distclean: clean
	rm -f *.bak *.bak? *.sta $(PROGRAM) $(PROGRAM).dbg $(PROGRAM).exe
