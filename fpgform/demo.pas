
(* https://forum.lazarus.freepascal.org/index.php/topic,26626.msg170290.html#msg170290 *)

program AggExample;

uses
  classes,
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_widget,
  Agg2D;
  
type
  TFpgWidget1 = class(TFpgWidget)
  private
    img: TFpgImage;
  protected
    procedure HandlePaint; override;
  public
    constructor Create(acom: tcomponent); override;
    procedure DoAggPainting;
  end;

  TfpgForm1 = class(TfpgForm)
    wg: TFpgWidget1;
    procedure AfterCreate; override;
  end;

const
  CImgWidth  = 400;
  CImgHeight = CImgWidth;
  CImgLeft   = 40;
  CImgTop    = CImgLeft;

procedure TFpgWidget1.DoAggPainting;
var
  ac: tagg2d;
begin
  ac := tagg2d.Create(self);
  if ac.Attach(img, FALSE) then
  begin
    ac.ClearAll(255, 255, 255);
    ac.LineColor($00, $00, $FF);
    ac.LineWidth(3);

    ac.Line(0, 0, 50, 50);
    ac.Line(50, 50, 100, 0);
    ac.Line(100, 0, 150, 50);
  end;
  img.UpdateImage;
  ac.Free;
end;

constructor TFpgWidget1.Create(acom: tcomponent);
begin
  inherited Create(acom);
  img := TFpgImage.Create;
  img.AllocateImage(32, CImgWidth, CImgHeight);
end;

procedure TFpgWidget1.HandlePaint;
begin
  DoAggPainting;
  //Canvas.Clear(clWhite);
  Canvas.DrawImage(0, 0, img);
end;

procedure TfpgForm1.AfterCreate;
begin
  Width := CImgWidth + 2 * CImgLeft;
  Height := CImgHeight + 2 * CImgTop;
  wg := TFpgWidget1.Create(self);
  wg.SetPosition(CImgLeft, CImgTop, CImgWidth, CImgHeight);
end;

var
  frm: TfpgForm1;

begin
  fpgApplication.Initialize;
  frm := TfpgForm1.Create(nil);
  frm.Show;
  fpgApplication.Run;
  frm.Free;
end.
