
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
  SURFACE_WIDTH = 480;
  SURFACE_HEIGHT = 480;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  //agg^.ClearAll(255, 255, 255);

  // Bold line & drawing path
  agg^.LineWidth(25);

  agg^.ResetPath;
  agg^.MoveTo(30, 90);
  agg^.LineTo(90, 30);
  agg^.LineTo(150, 90);

  // Default AGG_JoinRound
  agg^.Translate(10, -10);
  agg^.DrawPath(StrokeOnly);

  // Change to AGG_JoinMiter
  agg^.LineJoin(JoinMiter);
  agg^.Translate(0, 50);
  agg^.DrawPath(StrokeOnly);

  // Change to AGG_JoinBevel
  agg^.LineJoin(JoinBevel);
  agg^.Translate(0, 50);
  agg^.DrawPath(StrokeOnly);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
