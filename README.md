# AGGPas examples

Drawing with *agg_2D.pas* unit. Creation of a PNG image, using *fcl-image* library.

![Image](arc.png)

## Where to find AGGPas

AGGPas is part of fpGUI and of Lazarus.

### fpGUI

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

### Lazarus

```
git clone https://gitlab.com/freepascal.org/lazarus/lazarus.git
```

Units are in [components/aggpas/src](https://gitlab.com/freepascal.org/lazarus/lazarus/-/tree/main/components/aggpas/src?ref_type=heads) folder.

## How to compile examples

I compile the examples using *make*.

Compile one example:
```
make arc
```

Compile all examples:
```
make
```

If you use *make* you will have to edit *Makefile* and provide a path to your AGGPas units.

## AggExample unit

The *AggExample* unit derives from [Agg2DConsole.dpr](https://github.com/graemeg/fpGUI/blob/develop/extras/aggpas/agg-demos/Agg2DConsole.dpr) program.
