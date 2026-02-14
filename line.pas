
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
  agg^.lineCap(CapRound);
  agg^.lineWidth(8);
  agg^.lineColor(0, 0, 255, 255);
  agg^.line(FImageW div 4, FImageH div 4, 3 * FImageW div 4, 3 * FImageH div 4);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
