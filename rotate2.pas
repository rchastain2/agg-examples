
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
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
  //SURFACE_WIDTH = 480;
  //SURFACE_HEIGHT = 480;
  SURFACE_WIDTH = 240;
  SURFACE_HEIGHT = 180;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  {
    One frequent case for rotation transformation is rotating something around it's own axis. For example, if user wants to rotate the whole TBitmap surface (around it's axis), two more translations must be involved, because before rotation the center of rotation is in coordinates origin (which is Top Left or Bottom Left corner). So the transformation sequence changes like this:
  }
  agg^.clearAll(0, 0, 0, 0);
  //agg^.ClearAll(255 ,255 ,255 );
  agg^.NoFill;

  // First rectangle
  agg^.Rectangle(70, 40, 170, 140);

  // [!] set center point to the middle of TBitmap surface
  agg^.Translate(-SURFACE_WIDTH / 2, -SURFACE_HEIGHT / 2);

  // Rotate by 15 degrees
  agg^.Rotate(Deg2Rad(15));

  // [!] return coordinates system back
  agg^.Translate(SURFACE_WIDTH / 2, SURFACE_HEIGHT / 2);

  // The same rectangle in a new coordinates
  agg^.LineColor($FF, $00, $00);
  agg^.Rectangle(70, 40, 170, 140);
end;

var
  p: TAggExample1;

begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
