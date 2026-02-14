# AGGPas examples

Drawing with *agg_2D.pas* unit. Creation of a PNG image, using *fcl-image* library.

![Image](arc.png)

## Where to find AGGPas

AGGPas is part of fpGUI and of Lazarus.

### fpGUI

```
git clone https://github.com/graemeg/fpGUI.git
```

<!--
```
git clone --single-branch --branch maint https://github.com/graemeg/fpGUI.git
```

```
SHA1=e127c5b09e31cdd240b16f3fff4509aefbc30ec0
URL=https://github.com/graemeg/fpGUI.git
PROJECT_NAME=e127c5b
git clone $URL $PROJECT_NAME
cd $PROJECT_NAME
git reset --hard $SHA1
```
-->

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

You will have to edit *Makefile* and provide a path to your AGGPas units.

## Credits

The *AggExample* unit is derived from [Agg2DConsole.dpr](https://github.com/graemeg/fpGUI/blob/develop/extras/aggpas/agg-demos/Agg2DConsole.dpr).

The examples uses [Nougat font](https://www.dafont.com/fr/nougat.font) by Dieter Steffmann.
