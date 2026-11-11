
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
  
  agg^.lineCap(CapRound);
  agg^.lineWidth(5);
  agg^.lineColor(CDark);
  
  //agg^.fillColor(255, 0, 0, 255);
  agg^.fillLinearGradient(0, 0, Width, Height, COrange, WithAlpha(COrange, 0));
  
  agg^.arc(Width div 2, Height div 2, Width div 3, Height div 3, Deg2Rad(90), Deg2Rad(360));
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
