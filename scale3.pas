
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
  agg^.lineCap(CapRound);
  agg^.lineColor(0, 0, 255, 255);
 
  agg^.translate(0.5, 0.5);
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.lineWidth(0.05);  // in world coordinates!
  { https://forum.lazarus.freepascal.org/index.php/topic,73489.msg576462.html#msg576462 }
  
  agg^.ellipse(0, 0, 0.25, 0.25);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
