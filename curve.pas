
program AggEx;

uses
  SysUtils,
  AggExample,
  agg_2D,
  Palette;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
  end;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
  
  agg^.lineColor(CBlue);
  agg^.lineWidth(3);
  agg^.lineCap(CapRound);
  agg^.curve(10, 10, 10, 90, 190, 90);
  agg^.curve(10, 110, 10, 190, 190, 190, 190, 110);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
