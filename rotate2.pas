
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  Palette,
  agg_basics;

{
  https://www.crossgl.com/aggpas/documentation/index.html#Rotate
}

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

const
  SURFACE_WIDTH = 240;
  SURFACE_HEIGHT = 180;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  {
    One frequent case for rotation transformation is rotating something around its own axis. For example, if the user wants to rotate the whole TBitmap surface (around its axis), two more translations must be involved, because before rotation the center of rotation is at the coordinate origin (which is Top Left or Bottom Left corner). So the transformation sequence changes like this:
  }
  agg^.clearAll(0, 0, 0, 0);
  //agg^.noFill;
  agg^.noLine;

  // First rectangle
  agg^.fillColor(WithAlpha(CBlue, 127));
  agg^.rectangle(70, 40, 170, 140);

  // [!] set center point to the middle of TBitmap surface
  agg^.Translate(-SURFACE_WIDTH / 2, -SURFACE_HEIGHT / 2);

  // Rotate by 15 degrees
  agg^.rotate(Deg2Rad(15));

  // [!] restore the coordinate system
  agg^.Translate(SURFACE_WIDTH / 2, SURFACE_HEIGHT / 2);

  // The same rectangle in the new coordinates
  //agg^.lineColor($FF, $00, $00);
  agg^.fillColor(WithAlpha(CRed, 127));
  agg^.rectangle(70, 40, 170, 140);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
