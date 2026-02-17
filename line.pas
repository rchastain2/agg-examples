
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
  w4, h4: integer;
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineWidth(8);
  agg^.lineColor(0, 0, 255, 255);
  
  w4 := Width div 4;
  h4 := Height div 4;
  
  agg^.lineCap(CapButt);
  agg^.line(1 * w4, 3 * h4, 3 * w4, 3 * h4);
  
  agg^.lineCap(CapSquare);
  agg^.line(1 * w4, 2 * h4, 3 * w4, 2 * h4);
  
  agg^.lineCap(CapRound);
  agg^.line(1 * w4, 1 * h4, 3 * w4, 1 * h4);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
