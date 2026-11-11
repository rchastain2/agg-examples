
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
  Palette;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineCap(CapRound);
  agg^.lineWidth(5);
  agg^.lineColor(CDark);
  agg^.fillColor(WithAlpha(COrange, 127));
  agg^.ellipse(100, 100, 80, 60);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
