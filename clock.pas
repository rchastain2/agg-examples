
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  agg_basics,
  clockutils;

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
var
  LLight, LDark, LWhite: Color;
  LAngles: TClockAngles;
  LHour: integer;
begin
  //LLight.Construct(35, 151, 212); // #2397D4
  //LDark.Construct(38, 47, 69); // #262F45
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
    agg^.ellipse(R2 * Cos(LHour * PI/6), R2 * Sin(LHour * PI/6), 4, 4);
  
  agg^.lineWidth(8);
  agg^.lineColor(LDark);
  
  LAngles := GetClockAngles;
  agg^.line(0, 0, R4 * Cos(LAngles.Hour),   R4 * Sin(LAngles.Hour));
  agg^.line(0, 0, R3 * Cos(LAngles.Minute), R3 * Sin(LAngles.Minute));
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
