
program AggEx;

{
  procedure ellipse(cx, cy, rx, ry: double);
  
  procedure fillRadialGradient(x, y, r: double; c1, c2: Color; profile: double = 1.0); overload;
  procedure fillRadialGradient(x, y, r: double; c1, c2, c3: Color); overload;
  procedure fillRadialGradient(x, y, r: double); overload;
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
  c1, c2, c3: Color;
begin
  agg^.clearAll(0, 0, 0, 0);
  
  agg^.LineCap(CapRound);
  agg^.LineWidth(3);
  agg^.LineColor(0, 0, 255);
  
  //agg^.fillColor(255, 0, 0, 255);
  agg^.blendMode(BlendAlpha);
  c1.Construct(255, 255, 0, 255);
  c2.Construct(0, 0, 127);
  c3.Construct(0, 255, 0, 0);
  agg^.fillRadialGradient(100, 100, 90, c1, c2, c3);
  
  agg^.ellipse(100, 100, 90, 90);
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
