
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

  // Star
  agg^.LineCap(CapRound);
  agg^.LineWidth(5);
  agg^.LineColor(0, 128, 0);
  c1.Construct(0, 0, 255, 200);
  c2.Construct(0, 0, 255, 50);
  agg^.FillLinearGradient(200, 200, 300, 300, c1, c2);
  agg^.Star(100, 100, 30, 70, 55, 5);
  
end;

var
  p: TAggExample1;
  
begin
  Randomize;
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
