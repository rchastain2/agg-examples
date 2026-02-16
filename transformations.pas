
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH = 480;
  SURFACE_HEIGHT = 480;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
var
  x, y, nx, ny: double;
  af: Transformations_;
begin
  agg^.clearAll(0, 0, 0, 0);
  //agg^.ClearAll(255, 255, 255);
  agg^.NoLine;

  // Red Arrow
  agg^.FillColor(255, 0, 0, 128);
  agg^.Triangle(100, 20, 40, 100, 160, 100);
  agg^.Rectangle(70, 100, 130, 170);

  // Coordinates will be reflected along line
  // defined as from 0:0 to 90:85
  x := 90;
  y := 85;

  nx := x / Sqrt(x * x + y * y);
  ny := y / Sqrt(x * x + y * y);

  af.affineMatrix[0] := 2.0 * nx * nx - 1.0;
  af.affineMatrix[1] := 2.0 * nx * ny;
  af.affineMatrix[2] := 2.0 * nx * ny;
  af.affineMatrix[3] := 2.0 * ny * ny - 1.0;
  af.affineMatrix[4] := 0.0;
  af.affineMatrix[5] := 0.0;

  // Add Reflection Transformation by utilizing
  // custom matrix set-up function
  agg^.Transformations(@af);

  // Blue Arrow (same as Red)
  agg^.FillColor(0, 0, 255, 128);
  agg^.Triangle(100, 20, 40, 100, 160, 100);
  agg^.Rectangle(70, 100, 130, 170);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
