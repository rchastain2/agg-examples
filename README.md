# AGGPas examples

Drawing with *agg_2D.pas* unit. Creation of a PNG image, using *fcl-image* library.

![Image](arc.png)

## Where to find AGGPas

AGGPas is part of fpGUI and of Lazarus.

### fpGUI

```
git clone https://github.com/graemeg/fpGUI.git
```

Units are in [framework/src/main/pascal/corelib/render/software](https://github.com/graemeg/fpGUI/tree/develop/framework/src/main/pascal/corelib/render/software).

The *agg_2D* unit is in [extras/aggpas](https://github.com/graemeg/fpGUI/tree/develop/extras/aggpas).

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

## Credits

The *AggExample* unit is derived from [Agg2DConsole.dpr](https://github.com/graemeg/fpGUI/blob/develop/extras/aggpas/agg-demos/Agg2DConsole.dpr).

The examples uses [Nougat font](https://www.dafont.com/fr/nougat.font) by Dieter Steffmann.

## See also

- [Chess Image 2](https://github.com/rchastain2/chess-image-2)
