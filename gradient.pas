
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
  
  agg^.noLine;
  
  
  agg^.fillRadialGradient(50, 150, 40, CWhite, CBlue);
  agg^.rectangle(0, 100, 100, 200);
  
  agg^.fillRadialGradient(150, 150, 40, CWhite, CBlue, WithAlpha(CRed, 127));
  agg^.rectangle(100, 100, 200, 200);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
