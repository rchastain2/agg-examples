
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics;

{
  procedure arc(cx, cy, rx, ry, start, sweep: double);
}

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
  
  agg^.LineCap(CapRound);
  agg^.LineWidth(5);
  agg^.LineColor(0, 0, 255);
  
  //agg^.fillColor(255, 0, 0, 255);
  c1.Construct(255, 0, 0, 255);
  c2.Construct(255, 0, 0, 0);
  agg^.FillLinearGradient(0, 0, FImageW, FImageH, c1, c2);
  
  agg^.Arc(FImageW div 2, FImageH div 2, FImageW div 3, FImageH div 3, Deg2Rad(90), Deg2Rad(360));
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
