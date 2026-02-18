
program AggEx;

{
  procedure moveTo(x, y: double);
  procedure moveRel(dx, dy: double);

  procedure lineTo(x, y: double);
  procedure lineRel(dx, dy: double);

  procedure horLineTo(x: double);
  procedure horLineRel(dx: double);

  procedure verLineTo(y: double);
  procedure verLineRel(dy: double);

  procedure arcTo(rx, ry, angle: double; largeArcFlag, sweepFlag: boolean; x, y: double);
  procedure arcRel(rx, ry, angle: double; largeArcFlag, sweepFlag: boolean; dx, dy: double);
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
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineCap(CapRound);
  agg^.lineWidth(5);
  agg^.lineColor(0, 0, 255);
  agg^.fillColor(255, 0, 0, 127);
  
  agg^.resetPath;
  agg^.moveTo( 10, 100);
  agg^.lineTo(100, 190);
  agg^.lineTo(190, 100);
  agg^.lineTo(100,  10);
  agg^.closePolygon;
  agg^.drawPath;
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
