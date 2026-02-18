
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

const
  SURFACE_WIDTH = 200;
  SURFACE_HEIGHT = 200;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineColor(0, 0, 255);
  agg^.lineWidth(25);

  agg^.resetPath;
  agg^.moveTo(20, SURFACE_HEIGHT - 20);
  agg^.lineTo(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  agg^.lineTo(SURFACE_WIDTH - 20, SURFACE_HEIGHT - 20);

  // Default (AGG_JoinRound)
  agg^.drawPath(StrokeOnly);

  // Change to AGG_JoinMiter
  agg^.lineJoin(JoinMiter);
  agg^.translate(0, -40);
  agg^.drawPath(StrokeOnly);

  // Change to AGG_JoinBevel
  agg^.lineJoin(JoinBevel);
  agg^.translate(0, -40);
  agg^.drawPath(StrokeOnly);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
