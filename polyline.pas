
program AggEx;

{
  procedure polygon(xy: double_ptr; numPoints: int);
  procedure polyline(xy: double_ptr; numPoints: int);
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

const
  CPoints: array[0..13] of double = (20, 20, 20, 80, 60, 45, 100, 80, 140, 45, 180, 80, 180, 20);

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);

  agg^.lineCap(CapRound);
  agg^.lineWidth(5);
  agg^.lineColor(CDark);
  agg^.fillColor(WithAlpha(COrange, 127));

  agg^.polyline(@CPoints[0], 7);

  agg^.translate(0, 100);
  agg^.polygon(@CPoints[0], 7);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
