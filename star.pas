
program AggEx;

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
  agg^.lineColor(CGreen);
  agg^.fillLinearGradient(30, 30, 170, 170, WithAlpha(CBlue, 200), WithAlpha(CBlue, 50));
  agg^.Star(100, 100, 30, 70, 55, 5);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
