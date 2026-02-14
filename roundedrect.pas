
program AggEx;

{
  procedure roundedRect(x1, y1, x2, y2, r: double); overload;
  procedure roundedRect(x1, y1, x2, y2, rx, ry: double); overload;
  procedure roundedRect(x1, y1, x2, y2, rxBottom, ryBottom, rxTop, ryTop: double); overload;
}

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
  agg^.lineWidth(5);
  //agg^.lineColor(0, 0, 255);
  c1.Construct(0, 0, 0, 0);
  agg^.lineColor(c1);
  
  //agg^.fillColor(255, 0, 0, 255);
  c1.Construct(60, 160, 255, 255);
  c2.Construct(100, 255, 255, 0);
  agg^.fillLinearGradient(10, 10, 190, 190, c1, c2);
  agg^.roundedRect(20, 20, 180, 180, 10);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
