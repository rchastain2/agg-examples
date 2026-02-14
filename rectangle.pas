
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
  
  //agg^.lineColor(0, 0, 255, 255);
  //agg^.lineWidth(1);
  agg^.noLine;
  //agg^.fillColor(255, 0, 255, 255);
  c1.Construct(0, 0, 255, 200);
  c2.Construct(0, 0, 255, 50);
  agg^.fillLinearGradient(100, 100, 150, 150, c1, c2);
  agg^.rectangle(100, 100, 190, 190);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
