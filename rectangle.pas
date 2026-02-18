
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
  c1.Construct(0, 0, 255);
  c2.Construct(255, 0, 255, 127);
  agg^.clearAll(0, 0, 0, 0);
  agg^.noLine;
  
  agg^.fillColor(c1);
  agg^.rectangle(  0, 0, 100, 200);
  
  agg^.fillLinearGradient(100, 0, 200, 0, c1, c2);
  agg^.rectangle(100, 0, 200, 200);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
