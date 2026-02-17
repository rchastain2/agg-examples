
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

{ https://mathimages.swarthmore.edu/index.php/Cardioid }

procedure TAggExample1.Draw(agg: Agg2D_ptr);
const
  R = 0.3;
var
  a: double;
  x1, y1, x2, y2: double;
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineCap(CapRound);
  agg^.lineColor(0, 0, 255, 255);
  agg^.lineWidth(0.001);

  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  //agg^.translate(0.5, 0.5);
  //agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  
  //agg^.noFill;
  //agg^.ellipse(0, 0, R, R);
  
  agg^.lineWidth(0.0015);
  
  a := 0;
  
  while a < 2 * PI - PI / 72 do
  begin
    x1 := 0;
    y1 := -R;
    x2 := R * Cos(PI - a);
    y2 := R * Sin(PI - a);
    
    //agg^.moveTo(x1, y1);
    //agg^.lineTo(x2, y1);
    //agg^.lineTo(x2, y2);
    agg^.line(x1, y1, x2, y1);
    agg^.line(x2, y1, x2, y2);
    
    a := a + PI / 36;
    
    agg^.translate(-SURFACE_WIDTH div 2, -SURFACE_HEIGHT div 2);
    agg^.rotate(PI / 36);
    agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  end;
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
