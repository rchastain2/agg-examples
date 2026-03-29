
{ https://rosettacode.org/wiki/Fractal_tree#Pascal }

program FractalTree;

uses
  SysUtils,
  Math,
  AggExample,
  agg_2D,
  agg_basics;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

procedure TAggExample1.Draw(agg: Agg2D_ptr);

procedure DrawTree(X1, Y1: double; Angle: double; Depth: integer);
var
  X2, Y2: double;
  Thickness: Integer;
begin
  if Depth = 0 then
    Exit;

  // Calculate the next point
  X2 := X1 + Cos(DegToRad(Angle)) * Depth * 6;
  Y2 := Y1 + Sin(DegToRad(Angle)) * Depth * 6;

  // Set the color based on depth
  agg^.lineColor(0, 255 - 15 * Depth, 0, 15 * Depth);
  
  // Dynamically calculate thickness (thicker at smaller depths)
  Thickness := Max(1, Depth div 5); // Ensure thickness is at least 1
  agg^.lineWidth(Thickness);
  
  // Draw the branch
  agg^.line(X1, Y1, X2, Y2);

  // Recursively draw the left and right branches
  DrawTree(X2, Y2, Angle - 15, Depth - 1);
  DrawTree(X2, Y2, Angle + 15, Depth - 1);
end;

const
  TreeDepth = 17; // Maximum depth of the tree
{$IFDEF Unix}
 {CFont = 'arial.ttf';}
  CFont = '../Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
begin
  agg^.clearAll($FF, $FA, $F0, 255);
  agg^.lineCap(CapRound);
  
  DrawTree(Width div 2, 0, 90, TreeDepth);
  
  agg^.noLine;
  agg^.fillColor(255, 0, 0);
  agg^.font(CFont, 30);
  agg^.textAlignment(AlignRight, AlignBottom);
  agg^.text(Width - 30, + 30, 'AGGPas', true, 0.0, 0.0);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(1600, 900, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
