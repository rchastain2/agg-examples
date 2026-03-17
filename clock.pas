
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics,
  ClockUtils;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH = 400;
  SURFACE_HEIGHT = SURFACE_WIDTH;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
const
  R1 = 7 * SURFACE_WIDTH div 16;
  R2 = 6 * SURFACE_WIDTH div 16;
  R3 = 5 * SURFACE_WIDTH div 16;
  R4 = 4 * SURFACE_WIDTH div 16;
  R5 = 3 * SURFACE_WIDTH div 16;
var
  LLight, LDark, LWhite: Color;
  LAngles: TClockAngles;
  LHour, i: integer;
  LAngle, x, y: double;
type
  TPoint = record
    x, y: double;
  end;
var
  LPoints1: array[0..11] of TPoint;
  LPoints2: array[0..10] of TPoint;
begin
  (*
  LLight.Construct(35, 151, 212); // #2397D4
  LDark.Construct(38, 47, 69); // #262F45
  *)
  LLight.Construct(255, 0, 0, 127);
  LDark.Construct(0, 0, 255);
  LWhite.Construct(255, 255, 255);
  
  agg^.translate(SURFACE_WIDTH div 2, SURFACE_HEIGHT div 2);
  agg^.clearAll(LLight);
  
  agg^.lineWidth(8);
  agg^.lineColor(LDark);
  agg^.fillColor(LWhite);
  agg^.ellipse(0, 0, R1, R1);
  
  agg^.noLine;
  agg^.fillColor(LDark);
  for LHour := 0 to 11 do
  begin
    x := R2 * Cos(PI/2 - LHour * PI/6);
    y := -R2 * Sin(PI/2 - LHour * PI/6);
    agg^.ellipse(x, y, 4, 4);
    LPoints1[LHour].x := x;
    LPoints1[LHour].y := y;
  end;
  
  //(*
  LAngle := PI/2;
  for i := 0 to 10 do
  begin
    LPoints2[i].x := R4 * Cos(LAngle);
    LPoints2[i].y := -R4 * Sin(LAngle);
    LAngle := LAngle - 2*PI/11;
  end;
  
  //agg^.lineWidth(1);
  //agg^.lineColor(LLight);
  //agg^.lineCap(CapRound);
  //agg^.fillColor(LLight);
  agg^.fillRadialGradient(0, 0, R2, LLight, LWhite);
  for i := 1 to 11 do
  begin
    //agg^.curve(0, 0, LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y);
    //agg^.curve(LPoints2[i mod 11].x, LPoints2[i mod 11].y, 0, 0, LPoints1[i].x, LPoints1[i].y);
    //agg^.curve(LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y, 0, 0);
    
    agg^.resetPath;
    
    //agg^.curve(0, 0, LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y, 0, 0);
    agg^.curve(LPoints2[i mod 11].x, LPoints2[i mod 11].y, 0, 0, LPoints1[i].x, LPoints1[i].y, LPoints2[i mod 11].x, LPoints2[i mod 11].y);
    
    agg^.closePolygon;
    agg^.drawPath;
  end;
  //*)
  
  agg^.lineWidth(8);
  agg^.lineColor(LDark);
  
  LAngles := GetClockAngles();
  agg^.line(0, 0, R4 * Cos(LAngles.Hour),   -R4 * Sin(LAngles.Hour));
  agg^.line(0, 0, R3 * Cos(LAngles.Minute), -R3 * Sin(LAngles.Minute));
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
