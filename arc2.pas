
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  Palette,
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
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineWidth(5);
  agg^.lineCap(CapRound);
  agg^.lineColor(CDark);
  
  agg^.fillColor(WithAlpha(COrange, 191));
  agg^.arc(100, 300, 80, 80, Deg2Rad(90), Deg2Rad(360));
  
  agg^.fillLinearGradient(220, 220, 380, 380, COrange, WithAlpha(COrange, 0));
  agg^.arc(300, 300, 80, 80, Deg2Rad(90), Deg2Rad(360));
  
  agg^.noFill;
  agg^.arc(100, 100, 80, 80, Deg2Rad(90), Deg2Rad(360));
  
  agg^.fillColor(WithAlpha(COrange, 191));
  agg^.arc(300, 100, 80, 80, Deg2Rad(180), Deg2Rad(90));
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(400, 400, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
