
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
  agg^.noLine;
  
  agg^.fillColor(CBlue);
  agg^.rectangle(  0, 0, 100, 200);
  
  agg^.fillLinearGradient(100, 0, 200, 0, CBlue, WithAlpha(CRed, 127));
  agg^.rectangle(100, 0, 200, 200);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(200, 200, ChangeFileExt({$I %FILE%}, '.png'));
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
