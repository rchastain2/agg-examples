# AGGPas examples

Drawing with *agg_2D.pas* unit. Creation of a PNG image, using *fcl-image* library.

![Image](arc.png)

## Where to find AGGPas

AGGPas is part of fpGUI and of Lazarus.

### fpGUI

```
git clone https://github.com/graemeg/fpGUI.git
```

Units, including *agg_2D*, are in [framework/src/main/pascal/corelib/render/software](https://github.com/graemeg/fpGUI/tree/develop/framework/src/main/pascal/corelib/render/software).

### Lazarus

```
git clone https://gitlab.com/freepascal.org/lazarus/lazarus.git
```

Units are in [components/aggpas/src](https://gitlab.com/freepascal.org/lazarus/lazarus/-/tree/main/components/aggpas/src?ref_type=heads).

## How to compile examples

Compile one example:
```
make arc
```

Compile all examples:
```
make
```

Compile all examples using LCL:
```
make LCL=1
```

You will have to edit *Makefile* and provide a path to your AGGPas units.

## Other examples

| Folder | Description |
| --- | --- |
| [fpgui/fpgclock](fpgui/fpgclock) | Simple clock in an fpGUI window |
| [fpgui/fpgclock2](fpgui/fpgclock2) | Clock in an fpGUI window, with a dial pre-rendered to a PNG image |
| [fpgui/fpgform](fpgui/fpgform) | Drawing in an fpGUI form |
| [mathlib](mathlib) | Examples using the [mathlib-fp](https://github.com/ikelaiah/mathlib-fp) library |
| [msegui/tbitmap](msegui/tbitmap) | MSEgui, windowless: drawing in a bitmap saved to a PNG file |
| [msegui/tbitmap-2](msegui/tbitmap-2) | Same, AGGPas attached directly to the bitmap |
| [msegui/tpaintbox-tbitmap](msegui/tpaintbox-tbitmap) | MSEgui: drawing in a paint box |
| [msegui/tpaintbox-tbitmap-2](msegui/tpaintbox-tbitmap-2) | Same, AGGPas attached directly to the bitmap |
| [ptc](ptc) | Animation in a PTCPas console |

## Credits

The *AggExample* unit is derived from [Agg2DConsole.dpr](https://github.com/graemeg/fpGUI/blob/develop/extras/aggpas/agg-demos/Agg2DConsole.dpr).

The examples use [Nougat font](https://www.dafont.com/fr/nougat.font) by Dieter Steffmann.

## See also

- [Chess Image 2](https://github.com/rchastain2/chess-image-2)
