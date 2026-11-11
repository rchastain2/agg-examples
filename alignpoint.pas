
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  Palette;

{
  https://www.crossgl.com/aggpas/documentation/index.html#AlignPoint

 Description
    Due to the anti-aliasing technique (which is heavily used in AGG), it may sometimes be hard to render lines that are e.g. exactly 1 pixel wide.
    You can read more about this issue in the CrossGL documentation (see URL above).
    This line alignment problem can be partially solved by aligning the coordinates to 0.5 subpixels (in screen coordinates), so that the lines always have a 100% opaque area.
    The basic formula for this alignment is: x = floor(x) + 0.5
    This method is a helper method for reversely calculating world coordinates in such a way that, after the current transformations, they become aligned on the 0.5 fractional subpixel boundary.

Parameters
    x : PDouble
    Initial X world (user) system coordinate. This parameter receives the aligned value of the X coordinate (in the world coordinate system) that will snap to the 0.5 subpixel boundary on the X axis when rendering on screen.
    y : PDouble
    Initial Y world (user) system coordinate. This parameter receives the aligned value of the Y coordinate (in the world coordinate system) that will snap to the 0.5 subpixel boundary on the Y axis when rendering on screen.
}

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
var
  x1, y1, x2, y2: double;
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineColor(CDark);

  // Initial coordinates
  x1 := 10;
  y1 := 30;
  x2 := 150;
  y2 := 30;

  // This line seems to be bold with line width = 1
  agg^.Line(x1, y1, x2, y2);

  // We correct coordinates
  agg^.AlignPoint(@x1, @y1);
  agg^.AlignPoint(@x2, @y2);

  // We shift coordinates down to see the result beneath
  agg^.Translate(0, 50);

  // After correction,
  // this line seems to be ok with line width = 1
  agg^.Line(x1, y1, x2, y2);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
