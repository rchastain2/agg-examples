# Clock with pre-rendered dial

Clock for fpGUI & AGGPas. Unlike [fpgclock](../fpgclock), the dial is not redrawn every second: it is rendered once into *factory/static.png*, which the program loads and copies with `CopyImage`. Only the hands are drawn with the *Agg2D* unit.

![Image](factory/static.png)

## How to compile

Compile using source:
```
make
```

Compile using compiled units:
```
make PPU=1
```

To regenerate the dial image, run `make` in the *factory* folder.

Don't forget to edit the path to fpGUI in the Makefiles.
