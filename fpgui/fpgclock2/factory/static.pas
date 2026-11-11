
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  Palette,
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
  {CFont = '../../../fonts/arial.ttf';}
  CFont = '../../../fonts/Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
var
  LHour, i: integer;
  LAngle, x, y: double;
  LPointWidth: integer;
  LPoints1: array[0..11] of TPoint;
  LPoints2: array[0..10] of TPoint;
begin

  agg^.translate(CImgWidth div 2, CImgHeight div 2);
  agg^.clearAll(CBlue);

  agg^.lineWidth(CLineWidth);
  agg^.lineColor(CDark);
  agg^.fillColor(CWhite);
  agg^.ellipse(0, 0, CRadius1, CRadius1);

  agg^.noLine;
  agg^.fillColor(CDark);
  for LHour := 0 to 11 do
  begin
    x := CRadius2 * Cos(PI / 2 - LHour * PI / 6);
    y := CRadius2 * Sin(PI / 2 - LHour * PI / 6);
    LPointWidth := CPointWidth[LHour mod 3 = 0];
    agg^.ellipse(x, y, LPointWidth, LPointWidth);
    LPoints1[LHour].x := x;
    LPoints1[LHour].y := y;
  end;

  agg^.noLine;
  agg^.font(char_ptr(PChar({$IFDEF Unix}ExtractFilePath(ParamStr(0)) + {$ENDIF}CFont)), 18);
  agg^.textAlignment(AlignRight, AlignBottom);
  agg^.text(CImgWidth div 2 - 12, - CImgHeight div 2 + 12, 'AGGPas', true, 0.0, 0.0);

  LAngle := PI / 2;
  for i := 0 to 10 do
  begin
    LPoints2[i].x := CRadius4 * Cos(LAngle);
    LPoints2[i].y := CRadius4 * Sin(LAngle);
    LAngle := LAngle - 2 * PI / 11;
  end;

 {agg^.lineWidth(1);
  agg^.lineColor(CBlue);
  agg^.lineCap(CapRound);
  agg^.fillColor(CBlue);
  agg^.fillRadialGradient(0, 0, CRadius2, CBlue, CWhite);}
  agg^.fillRadialGradient(0, 0, CRadius2, CLightGray, CWhite);
  for i := 1 to 11 do
  begin
   {agg^.curve(0, 0, LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y);
    agg^.curve(LPoints2[i mod 11].x, LPoints2[i mod 11].y, 0, 0, LPoints1[i].x, LPoints1[i].y);
    agg^.curve(LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y, 0, 0);}
    agg^.resetPath;
   {agg^.curve(0, 0, LPoints2[i mod 11].x, LPoints2[i mod 11].y, LPoints1[i].x, LPoints1[i].y, 0, 0);}
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
