
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

procedure TAggExample1.Draw(agg: Agg2D_ptr);
var
  c1, c2: Color;
begin
  agg^.clearAll(0, 0, 0, 0);
  
  agg^.lineColor(0, 0, 255, 255);
  agg^.lineWidth(3);
  agg^.lineCap(CapRound);
  agg^.curve(10, 10, 10, 90, 190, 90);
  agg^.curve(10, 110, 10, 190, 190, 190, 190, 110);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
