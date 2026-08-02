program VectorRotationDemo;

{$mode objfpc}{$H+}{$J-}
{$MODESWITCH ADVANCEDRECORDS}

uses
  SysUtils, Math,
  agg_2D,
  agg_basics,
  AggExample,
  MathBase.SharedTypes,
  GeometryLib.Geometry;

type
  TVector2D_ = record helper for TVector2D
    function Rotate(const Angle: Double): TVector2D;
  end;

function TVector2D_.Rotate(const Angle: Double): TVector2D;
var CosA, SinA, X_, Y_: Double;
begin
  SinCos(Angle, SinA, CosA);
  X_ := X;
  Y_ := Y;
  Result.X := X_ * CosA - Y_ * SinA;
  Result.Y := X_ * SinA + Y_ * CosA;
end;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH  = 480;
  SURFACE_HEIGHT = 480;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
  
  procedure DrawLine(const X1, Y1, X2, Y2: Double);
  begin
    agg^.line(X1, Y1, X2, Y2);
  end;
  
  procedure DrawVector(const V: TVector2D);
  begin
    agg^.line(0, 0, V.X, V.Y);
  end;

var
  V: TVector2D;
  c1, c2, c3: Color;
  n: Integer;

begin
  c1.Construct($FF, $FF, $E0, $FF);
  c2.Construct($FF, $CC, $00, $FF);
  c3.Construct($FF, $8C, $00, $FF);
  
  agg^.clearAll(c1);
  agg^.lineCap(CapRound);
  
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  
  agg^.lineWidth(0.002);
  agg^.lineColor(c2);
  
  DrawLine(-0.4, 0, 0.4, 0);
  DrawLine(0, -0.4, 0, 0.4);
  
  V := TVector2D.Create(0.35, 0);
  
  agg^.lineWidth(0.003);
  agg^.lineColor(c3);
  
  DrawVector(V);
  
  for n := 1 to 8 do
  begin
    V := V.Rotate(PI / 12);
    DrawVector(V);
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
