# fpGUI form + AGGPas demo

Drawing with the *Agg2D* unit in an fpGUI form, using `TAgg2D.Attach` on a `TfpgImage`.

- *demo.pas*: text, linear gradient and arc. Press Esc to quit.
- *tryagg2dattach.pas*: Bézier curve, with check boxes to show the control points and to flip the Y axis.

Based on [this discussion](https://forum.lazarus.freepascal.org/index.php/topic,26626.msg170290.html#msg170290) on the Lazarus forum.

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
