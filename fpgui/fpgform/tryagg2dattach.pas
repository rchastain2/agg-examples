
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
  TFpgWidget1 = class(TFpgWidget)
  private
    FImg: TFpgImage;
    FShowPath: Boolean;
    FFlipY: Boolean;
    procedure SetShowPath(AValue: Boolean);
    procedure SetFlipY(AValue: Boolean);
  protected
    procedure HandlePaint; override;
  public
    constructor Create(AComp: TComponent); override;
    procedure DoAggPainting;
    property ShowPath: boolean read FShowPath write SetShowPath;
    property FlipY: boolean read FFlipY write SetFlipY;
  end;

  TMainForm = class(TfpgForm)
    FWidget1: TFpgWidget1;
    FFCheckBoxShow: TfpgCheckbox;
    FFCheckBoxFlip: TfpgCheckbox;
    procedure OnShowPathChanged(Sender: TObject);
    procedure OnFlipYChanged(Sender: TObject);
    procedure AfterCreate; override;
  end;

procedure TFpgWidget1.SetShowPath(AValue: Boolean);
begin
  FShowPath := AValue;
  Invalidate;
end;

procedure TFpgWidget1.SetFlipY(AValue: boolean);
begin
  FFlipY := AValue;
  Invalidate;
end;

procedure TFpgWidget1.DoAggPainting;
var
  ac: TAgg2D;
begin
  ac := TAgg2D.Create(self);
  if ac.Attach(FImg, FFlipY) then
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
  FImg.UpdateImage;
  ac.Free;
end;

constructor TFpgWidget1.Create(AComp: TComponent);
begin
  inherited Create(AComp);
  FShowPath := False;
  FFlipY := False;
  FImg := TFpgImage.Create;
  FImg.AllocateImage(32, 300, 100);
end;

procedure TFpgWidget1.HandlePaint;
begin
  DoAggPainting;
  Canvas.clear(clwhite);
  Canvas.DrawImage(0, 0, FImg);
  //Canvas.DrawArc(30, 30, 50, 50, 0, 135);
end;

procedure tmainform.OnSHowPathChanged(Sender: TObject);
begin
  FWidget1.ShowPath := FFCheckBoxShow.Checked;
end;

procedure tmainform.OnFlipYChanged(Sender: TObject);
begin
  FWidget1.FlipY := FFCheckBoxFlip.Checked;
end;

procedure tmainform.AfterCreate;
begin
  width := 300;
  height := 100;
  FWidget1 := TFpgWidget1.Create(self);
  FWidget1.SetPosition(0, 0, 300, 100);

  FFCheckBoxShow := CreateCheckBox(self, 200, 0, 'Show Path');
  FFCheckBoxShow.OnChange := @OnShowPathChanged;

  FFCheckBoxFlip := CreateCheckBox(self, 200, FFCheckBoxShow.Height, 'Flip Y');
  FFCheckBoxFlip.OnChange := @OnFlipYChanged;
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
