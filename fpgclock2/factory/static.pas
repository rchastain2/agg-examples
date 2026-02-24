
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

{$I clocksize}

procedure TAggExample1.Draw(agg: Agg2D_ptr);
type
  TPoint = record
    x, y: double;
  end;
const
{$IFDEF Unix}
  //CFont = 'arial.ttf';
  CFont = '../../Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
var
  LHour, i: integer;
  LAngle, x, y: double;
  LPointWidth: integer;
  LPoints1: array[0..11] of TPoint;
  LPoints2: array[0..10] of TPoint;
  LLight, LDark, LWhite: Color;
begin
  LLight.Construct(35, 151, 212); // #2397D4
  LDark.Construct(38, 47, 69); // #262F45
  LWhite.Construct(255, 255, 255);
  
  agg^.translate(CImgWidth div 2, CImgHeight div 2);
  agg^.clearAll(LLight);
  
  agg^.lineWidth(CLineWidth);
  agg^.lineColor(LDark);
  agg^.fillColor(LWhite);
  agg^.ellipse(0, 0, CRadius1, CRadius1);
  
  agg^.noLine;
  agg^.fillColor(LDark);
  for LHour := 0 to 11 do
  begin
    x := CRadius2 * Cos(PI/2 - LHour * PI/6);
    y := CRadius2 * Sin(PI/2 - LHour * PI/6);
    LPointWidth := CPointWidth[LHour mod 3 = 0];
    agg^.ellipse(x, y, LPointWidth, LPointWidth);
    LPoints1[LHour].x := x;
    LPoints1[LHour].y := y;
  end;
  
  agg^.noLine;
  agg^.font(CFont, 18);
  agg^.textAlignment(AlignRight, AlignBottom);
  agg^.text(CImgWidth div 2 - 12, - CImgHeight div 2 + 12, 'AGGPas', true, 0.0, 0.0);
  
  LAngle := PI/2;
  for i := 0 to 10 do
  begin
    LPoints2[i].x := CRadius4 * Cos(LAngle);
    LPoints2[i].y := CRadius4 * Sin(LAngle);
    LAngle := LAngle - 2*PI/11; // Merci PA !
  end;
  
  //agg^.lineWidth(1);
  //agg^.lineColor(LLight);
  //agg^.lineCap(CapRound);
  //agg^.fillColor(LLight);
  //agg^.fillRadialGradient(0, 0, CRadius2, LLight, LWhite);
  agg^.fillRadialGradient(0, 0, CRadius2, LDark, LWhite);
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
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(CImgWidth, CImgHeight, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
