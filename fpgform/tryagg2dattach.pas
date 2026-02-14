
(* https://forum.lazarus.freepascal.org/index.php/topic,26626.msg170290.html#msg170290 *)

program TryAgg2dAttach;

uses
  classes,
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_widget,
  fpg_checkbox,
  Agg2D;
  
type
  tfpgwidget1 = class(tfpgwidget)
  private
    img: tfpgimage;
    FShowPath: Boolean;
    FFlipY: Boolean;
    procedure SetShowPath(AValue: Boolean);
    procedure SetFlipY(AValue: Boolean);
  protected
    procedure HandlePaint; override;
  public
    constructor create(acom: tcomponent); override;
    procedure DoAggPainting;
    property ShowPath: boolean read FShowPath write SetShowPath;
    property FlipY: boolean read FFlipY write SetFlipY;
  end;

  TMainForm = class(TfpgForm)
    mywidget: tfpgwidget1;
    cb: TfpgCheckbox;
    cbflip: TfpgCheckbox;
    procedure OnShowPathChanged(Sender: TObject);
    procedure OnFlipYChanged(Sender: TObject);
    procedure AfterCreate; override;
  end;

procedure tfpgwidget1.SetShowPath(AValue: Boolean);
begin
  FShowPath := AValue;
  Invalidate;
end;

procedure tfpgwidget1.SetFlipY(AValue: boolean);
begin
  FFlipY := AValue;
  Invalidate;
end;

procedure tfpgwidget1.DoAggPainting;
var
  ac: tagg2d;
begin
  ac := tagg2d.Create(self);
  if ac.Attach(img, FFlipY) then
  begin
    ac.ClearAll(255, 255, 255);
    if FShowPath then
    begin
      // Indicate Path for Curve
      ac.LineColor($00, $00, $FF);
      ac.FillColor($00, $00, $FF);
      ac.LineWidth(0.2);

      ac.Rectangle( 00 - 4,  0 - 4,   0 + 4,  0 + 4);
      ac.Rectangle( 50 - 4, 50 - 4,  50 + 4, 50 + 4);
      ac.Rectangle(100 - 4,  0 - 4, 100 + 4,  0 + 4);
      ac.Rectangle(150 - 4, 50 - 4, 150 + 4, 50 + 4);

      ac.Line(0, 0, 50, 50);
      ac.Line(50, 50, 100, 0);
      ac.Line(100, 0, 150, 50);
    end;
    // Draw Cubic Bezier curve
    ac.LineWidth(3);
    ac.LineColor($32, $CD, $32);
    ac.Curve(0, 0, 50, 50, 100, 0, 150, 50);
  end;
  img.UpdateImage;
  ac.Free;
end;

constructor tfpgwidget1.create(acom: tcomponent);
begin
  inherited create(acom);
  FShowPath := False;
  FFlipY := False;
  img := tfpgimage.Create;
  img.AllocateImage(32, 300, 100);
end;

procedure tfpgwidget1.HandlePaint;
begin
  DoAggPainting;
  canvas.clear(clwhite);
  canvas.DrawImage(0, 0, img);
  //canvas.DrawArc(30, 30, 50, 50, 0, 135);
end;

procedure tmainform.OnSHowPathChanged(Sender: TObject);
begin
  mywidget.ShowPath := cb.Checked;
end;

procedure tmainform.OnFlipYChanged(Sender: TObject);
begin
  mywidget.FlipY := cbflip.Checked;
end;

procedure tmainform.AfterCreate;
begin
  width := 300;
  height := 100;
  mywidget := tfpgwidget1.create(self);
  mywidget.SetPosition(0, 0, 300, 100);

  cb := CreateCheckBox(self, 200, 0, 'Show Path');
  cb.OnChange := @OnShowPathChanged;

  cbflip := CreateCheckBox(self, 200, cb.Height, 'Flip Y');
  cbflip.OnChange := @OnFlipYChanged;
end;

var
  frm: TMainForm;
begin
  fpgApplication.Initialize;
  frm := TMainForm.Create(nil);
  frm.Show;
  fpgApplication.Run;
  frm.Free;
end.
