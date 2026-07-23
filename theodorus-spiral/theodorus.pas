
program AggEx;

uses
  SysUtils,
  agg_2D,
  agg_basics,
  AggExample,
  GeometryLib.Geometry;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH = 480;
  SURFACE_HEIGHT = 480;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
const
  CScale = 1 / 8;
  
  procedure DrawLine(const X1, Y1, X2, Y2: double);
  begin
    agg^.line(CScale * X1, CScale * Y1, CScale * X2, CScale * Y2);
  end;

  procedure DrawTriangle(const X1, Y1, X2, Y2, X3, Y3: double);
  begin
    agg^.triangle(CScale * X1, CScale * Y1, CScale * X2, CScale * Y2, CScale * X3, CScale * Y3);
  end;

const
  CNumTriangles = 12;
var
  V1, V2: TVector2D;
  P1: TPoint2D;
  i: integer;
begin
  agg^.clearAll(255, 255, 255, 255);
  
  agg^.lineCap(CapRound);
  agg^.lineColor(0, 0, 255, 63);
  agg^.lineWidth(0.001);
 {agg^.noLine;}
  agg^.fillColor(0, 0, 255, 63);
  
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  
  V1 := TVector2D.Create(1, 0);
  
 {DrawLine(0, 0, V1.X, V1.Y);}
  
  for i := 1 to CNumTriangles do
  begin
    V2 := V1.Perpendicular.Normalise;
    P1 := TPoint2D.Create(V1.X + V2.X, V1.Y + V2.Y);
    
   {DrawLine(V1.X, V1.Y, P1.X, P1.Y);
    DrawLine(0, 0, P1.X, P1.Y);}
    
    DrawTriangle(0, 0, V1.X, V1.Y, P1.X, P1.Y);
    
    V1 := TVector2D.Create(P1.X, P1.Y);
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
