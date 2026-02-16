
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

{
  https://www.crossgl.com/aggpas/documentation/index.html#Scale
}

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  //SURFACE_WIDTH = 480;
  //SURFACE_HEIGHT = 480;
  SURFACE_WIDTH = 240;
  SURFACE_HEIGHT = 180;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  {
    Scaling with negative factors generates reflections. That can be utilized to create a mirror-like effects. (One additional translation must be involved to get the effect.)
  }
  agg^.clearAll(0, 0, 0, 0);
  //agg^.ClearAll(255, 255, 255);
  agg^.NoFill;

  // First triangle
  agg^.Triangle(100, 20, 20, 100, 180, 100);

  // Reflect along X axis
  agg^.Scale(1, -1);
  agg^.Translate(0, 210);

  // The same triangle reflected in a new coordinates
  agg^.LineColor($FF, $00, $00);
  agg^.Triangle(100, 20, 20, 100, 180, 100);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
