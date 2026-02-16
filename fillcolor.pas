
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

{
  https://www.crossgl.com/aggpas/documentation/index.html#fillColor
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
  //agg^.clearAll(255, 255, 255);

  // Changing fill color to HTML color Gold #FFD700
  agg^.fillColor($FF, $D7, $00);
  agg^.rectangle(30, 30, 180, 80);

  // Adding Alpha Transparency to previous fill color
  agg^.Translate(0, 80);
  agg^.fillColor($FF, $D7, $00, 128);
  agg^.rectangle(30, 30, 180, 80);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
