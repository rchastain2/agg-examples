
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
  CIterations = 11;

var
  c: Color;
  V1, V2, old: TVector2D;
  n: integer;

begin
  agg^.clearAll(255, 255, 255, 255);
  
  agg^.lineCap(CapRound);
  agg^.lineWidth(1 / 1000);
  c.Construct(0, 0, 255, 63);
  agg^.lineColor(c);
  agg^.fillColor(c);
  
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  
  WriteLn('| Vector coordinates | Length | Square root |');
  WriteLn('| --- | --- | --- |');
  
  V1 := TVector2D.Create(1, 0);
  
  for n := 1 to CIterations do
  begin
    old := V1;
    
    V2 := V1.Normalise.Perpendicular;
    V1 := V1 + V2;
    
    WriteLn(Format('| %s | %.4f | √%d |', [V1.ToString, V1.Magnitude, n + 1]));
    
    DrawTriangle(0, 0, old.X, old.Y, V1.X, V1.Y);
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
