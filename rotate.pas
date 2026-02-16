
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
  //agg^.clearAll(255, 255, 255);
  agg^.noFill;

  // First rectangle
  agg^.rectangle(70, 40, 170, 140);

  // Rotate by 15 degrees
  agg^.rotate(Deg2Rad(15));

  // The same rectangle in a new coordinates
  agg^.lineColor($FF, $00, $00);
  agg^.rectangle(70, 40, 170, 140);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
