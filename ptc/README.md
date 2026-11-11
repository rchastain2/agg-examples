# PTCPas + AGGPas demo

Animation drawn with the *agg_2D* unit in a [PTCPas](https://ptcpas.sourceforge.io/) console: random ellipses are drawn until a key is pressed.

Based on the *buffer.pp* example of PTCPas.

PTCPas is included in Free Pascal (*ptc* package).

## How to compile

```
make
```

Using Lazarus AGGPas units:
```
make LCL=1
```

Don't forget to edit the path to AGGPas in the Makefile.
