# Simple clock

Clock for fpGUI & AGGPas. The whole clock (dial and hands) is redrawn every second with the *Agg2D* unit.

See [fpgclock2](../fpgclock2) for a variant where the dial is pre-rendered.

## How to compile

Compile using source:
```
make
```

Compile using compiled units:
```
make PPU=1
```

Don't forget to edit the path to fpGUI in the Makefile.
