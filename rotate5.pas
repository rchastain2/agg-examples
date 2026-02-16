
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

const
  SURFACE_WIDTH = 480;
  SURFACE_HEIGHT = 480;

{ https://forum.lazarus.freepascal.org/index.php/topic,73489.msg576513.html#msg576513 }

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  agg^.lineCap(CapRound);
  agg^.lineColor(0, 0, 255, 255);
 
  // Draw circle in the center of the image
  // Basic transformation which converts world coordinates to image coordinates
  agg^.translate(0.5, 0.5);
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.lineWidth(0.05);
  agg^.ellipse(0, 0, 0.25, 0.25);  // Circle is at center of "world"
 
  // Draw square which touches the circle at 45°
  agg^.resetTransformations;   // important!
  agg^.translate(0.25+0.1, 0);     // Translate square horizontally so that it touches the circle on the x axis
  agg^.rotate(PI/4);               // Rotate the square by 45° around origin. Remember: square is not at origin any more!
  agg^.translate(0.5, 0.5);        // Now repeat the transformation to image coordinates that we already did for the circle.
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.lineWidth(0.02);
  agg^.rectangle(-0.1, -0.1, 0.1, 0.1);  // square is at the center of the "world" initially
 
  // Draw square which touches the circle at 135°
  agg^.resetTransformations;
  agg^.translate(0.25+0.1, 0);
  agg^.rotate(PI * 0.75);
  agg^.translate(0.5, 0.5);
  agg^.scale(SURFACE_WIDTH, SURFACE_HEIGHT);
  agg^.lineWidth(0.02);
  agg^.rectangle(-0.1, -0.1, 0.1, 0.1);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
