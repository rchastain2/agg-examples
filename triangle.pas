
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
begin
  agg^.clearAll(0, 0, 0, 0);
  
  //agg^.lineColor(0, 0, 255, 255);
  //agg^.lineWidth(1);
  agg^.noLine;
  
  agg^.fillColor(255, 0, 0);
  agg^.triangle(10, 10, 100, 190, 190, 10);
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
