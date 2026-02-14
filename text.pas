
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
  
  // Text
  agg^.NoLine;
  //agg^.LineWidth(1);
  //agg^.LineColor(0, 0, 128);
  //agg^.FillColor(0, 0, 128);
  c1.Construct(0, 0, 255, 255);
  c2.Construct(255, 0, 0, 255);
  agg^.FillLinearGradient(20, 20, 100, 20, c1, c2);
  agg^.Font(CFont, 28, false, false, VectorFontCache, 0);//Deg2Rad(45));
  agg^.Text(20, 20, 'AGGPas');
  
  //m_graphics.font(char_ptr(FONT_TIMES), 14.0, false, false);
  //m_graphics.fillColor(0, 0, 0);
  //m_graphics.noLine;
  //m_graphics.text(100, 20, char_ptr(PChar('Regular Raster Text')));
  
  //clr.Construct(0, 0, 0, 0);
  //m_graphics.lineColor(clr);
  //c1.Construct(100, 200, 255, 255);
  //c2.Construct(255, 255, 255, 0);
  //m_graphics.fillLinearGradient(xb1, yb1, xb1, yb1 + 30, c1, c2);
  //m_graphics.roundedRect(xb1 + 3, yb1 + 2.5, xb2 - 3, yb1 + 30, 9, 18, 1, 1);
  //clr.Construct(0, 0, 50, 200);
  //m_graphics.fillColor(clr);
  //m_graphics.noLine;
  //m_graphics.textAlignment(AlignCenter, AlignCenter);
  //m_graphics.text(
  //  (xb1 + xb2) / 2.0,
  //  (yb1 + yb2) / 2.0,
  //  char_ptr(PChar('Aqua Button')),
  //  true, 0.0, 0.0);
  
  //m_graphics.font(char_ptr(FONT_TIMES), 40.0, false, false, VectorFontCache);
  //m_graphics.textAlignment(AlignLeft, AlignBottom);
  //m_graphics.text(250.0, 150.0, char_ptr(PChar('Left-Bottom')), true, 0, 0);
  //m_graphics.textAlignment(AlignCenter, AlignBottom);
  //m_graphics.text(250.0, 200.0, char_ptr(PChar('Center-Bottom')), true, 0, 0);
  //m_graphics.textAlignment(AlignRight, AlignBottom);
  //m_graphics.text(250.0, 250.0, char_ptr(PChar('Right-Bottom')), true, 0, 0);
  //m_graphics.textAlignment(AlignLeft, AlignCenter);
  //m_graphics.text(250.0, 300.0, char_ptr(PChar('Left-Center')), true, 0, 0);
  //m_graphics.textAlignment(AlignCenter, AlignCenter);
  //m_graphics.text(250.0, 350.0, char_ptr(PChar('Center-Center')), true, 0, 0);
  //m_graphics.textAlignment(AlignRight, AlignCenter);
  //m_graphics.text(250.0, 400.0, char_ptr(PChar('Right-Center')), true, 0, 0);
  //m_graphics.textAlignment(AlignLeft, AlignTop);
  //m_graphics.text(250.0, 450.0, char_ptr(PChar('Left-Top')), true, 0, 0);
  //m_graphics.textAlignment(AlignCenter, AlignTop);
  //m_graphics.text(250.0, 500.0, char_ptr(PChar('Center-Top')), true, 0, 0);
  //m_graphics.textAlignment(AlignRight, AlignTop);
  //m_graphics.text(250.0, 550.0, char_ptr(PChar('Right-Top')), true, 0, 0);
end;

var
  p: TAggExample1;
  
begin
  Randomize;
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
