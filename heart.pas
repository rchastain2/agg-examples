
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

  procedure DrawHeart(x, y, r, d: double);
  var
    y1, y2, y3, y4, x1, x2, x3, x4: double;
  begin
    y1 := y - r;
    y2 := y - r / 3;
    y3 := y + r / 3;
    y4 := y + r;
    x1 := x - r;
    x2 := x - d;
    x3 := x + d;
    x4 := x + r;
    
    agg^.curve(x,  y4, x2, y3, x1, y3, x1, y2);
    agg^.curve(x1, y2, x1, y1, x2, y1, x,  y2);
    agg^.curve(x,  y2, x3, y1, x4, y1, x4, y2);
    agg^.curve(x4, y2, x4, y3, x3, y3, x,  y4);
  end;

begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineColor(255, 0, 0);
  agg^.lineWidth(5);
  
  agg^.translate(-Width div 2, -Height div 2);
  agg^.rotate(Deg2Rad(180));
  agg^.translate(Width div 2, Height div 2);
  
  DrawHeart(Width / 2, Height / 2, Width / 3, 0);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
