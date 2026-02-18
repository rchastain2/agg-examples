
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

{
  https://www.crossgl.com/aggpas/documentation/index.html#AlignPoint

 Description
    Due to the Anti Aliasing technique (that's heavily used in AGG), it may be sometimes hard to achieve rendering of lines, that are eg. exactly 1 pixel wide.
    You can read more about this issue here.
    This line alignment problem can be partially solved by aligning the coordinates to the 0.5 subpixels (in screen coordinates), so that the lines would always have 100% opaque area.
    Basic formula to do this alignment is: x = floor(x) + 0.5
    This method is a helper method for reversely calculating world coordinates in such a way, that after the current transformations they become aligned on 0.5 fractional subpixel boundary.

Parameters
    x : PDouble
    Initial X world (user) system coordinate. This parameter receives aligned value of X coordinate (in world coordinates system), that will snap to the 0.5 subpixel boundary on X axis when rendering on screen.
    y : PDouble
    Initial Y world (user) system coordinate. This parameter receives aligned value of Y coordinate (in world coordinates system), that will snap to the 0.5 subpixel boundary on Y axis when rendering on screen.
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
