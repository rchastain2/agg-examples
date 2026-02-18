
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

{
  https://www.crossgl.com/aggpas/documentation/index.html#Rotate
}

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH = 240;
  SURFACE_HEIGHT = 180;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  //agg^.noFill;
  agg^.noLine;

  // First rectangle
  agg^.fillColor($00, $00, $FF, $7F);
  agg^.rectangle(70, 40, 170, 140);

  // Rotate by 15 degrees
  agg^.rotate(Deg2Rad(15));

  // The same rectangle in a new coordinates
  //agg^.lineColor($FF, $00, $00);
  agg^.fillColor($FF, $00, $00, $7F);
  agg^.rectangle(70, 40, 170, 140);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
