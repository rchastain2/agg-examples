
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
  agg^.clearAll(0, 0, 0, 0);
  //agg^.clearAll(255, 255, 255);
  agg^.noFill;

  // First rectangle
  agg^.rectangle(30, 30, 130, 130);

  // Scale 40% on X axis and 20% on Y axis
  agg^.Scale(1.4, 1.2);

  // The same rectangle in a new coordinates
  agg^.lineColor($FF, $00, $00);
  agg^.rectangle(30, 40, 130, 130);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
