
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

procedure TAggExample1.Draw(agg: Agg2D_ptr);
const
{$IFDEF Unix}
  //CFont = 'arial.ttf';
  CFont = 'Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
var
  c1, c2: Color;
begin
  agg^.clearAll(0, 0, 0, 0);
  
  agg^.noLine;
  //agg^.lineWidth(1);
  //agg^.lineColor(0, 0, 128);
  //agg^.fillColor(0, 0, 128);
  c1.Construct(0, 0, 255, 255);
  c2.Construct(255, 0, 0, 255);
  agg^.fillLinearGradient(20, 20, 100, 20, c1, c2);
  agg^.Font(CFont, 28, false, false, VectorFontCache, 0);//Deg2Rad(45));
  agg^.Text(20, 20, 'AGGPas');
  
  //agg^.font(char_ptr(FONT_TIMES), 14.0, false, false);
  //agg^.text(100, 20, char_ptr(PChar('Regular Raster Text')));
  
  //agg^.textAlignment(AlignCenter, AlignCenter);
  //agg^.text(
  //  (xb1 + xb2) / 2.0,
  //  (yb1 + yb2) / 2.0,
  //  char_ptr(PChar('Aqua Button')),
  //  true, 0.0, 0.0);
  
  //agg^.font(char_ptr(FONT_TIMES), 40.0, false, false, VectorFontCache);
  //agg^.textAlignment(AlignLeft, AlignBottom);
  //agg^.text(250.0, 150.0, char_ptr(PChar('Left-Bottom')), true, 0, 0);
  //agg^.textAlignment(AlignCenter, AlignBottom);
  //agg^.text(250.0, 200.0, char_ptr(PChar('Center-Bottom')), true, 0, 0);
  //agg^.textAlignment(AlignRight, AlignBottom);
  //agg^.text(250.0, 250.0, char_ptr(PChar('Right-Bottom')), true, 0, 0);
  //agg^.textAlignment(AlignLeft, AlignCenter);
  //agg^.text(250.0, 300.0, char_ptr(PChar('Left-Center')), true, 0, 0);
  //agg^.textAlignment(AlignCenter, AlignCenter);
  //agg^.text(250.0, 350.0, char_ptr(PChar('Center-Center')), true, 0, 0);
  //agg^.textAlignment(AlignRight, AlignCenter);
  //agg^.text(250.0, 400.0, char_ptr(PChar('Right-Center')), true, 0, 0);
  //agg^.textAlignment(AlignLeft, AlignTop);
  //agg^.text(250.0, 450.0, char_ptr(PChar('Left-Top')), true, 0, 0);
  //agg^.textAlignment(AlignCenter, AlignTop);
  //agg^.text(250.0, 500.0, char_ptr(PChar('Center-Top')), true, 0, 0);
  //agg^.textAlignment(AlignRight, AlignTop);
  //agg^.text(250.0, 550.0, char_ptr(PChar('Right-Top')), true, 0, 0);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
