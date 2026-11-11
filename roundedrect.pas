
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
  //agg^.lineColor(0, 0, 255);
  agg^.lineColor(CDark);
  
  //agg^.fillColor(255, 0, 0, 255);
  agg^.fillLinearGradient(10, 10, 190, 190, CBlue, WithAlpha(CGreen, 0));
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
