
(* https://forum.lazarus.freepascal.org/index.php/topic,26626.msg170290.html#msg170290 *)

program AggExample;

uses
  classes,
  SysUtils,
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_widget,
  Agg2D,
  Palette;
  
type
  TFpgWidget1 = class(TFpgWidget)
  private
    img: TFpgImage;
  protected
    procedure HandlePaint; override;
  public
    constructor Create(AComp: TComponent); override;
    procedure DoAggPainting;
  end;

  TfpgForm1 = class(TFpgForm)
    wg: TFpgWidget1;
    procedure AfterCreate; override;
  protected
    procedure HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean); override;
  end;

const
  CImgWidth  = 400;
  CImgHeight = CImgWidth;
  CImgLeft   = 40;
  CImgTop    = CImgLeft;

procedure TFpgWidget1.DoAggPainting;
const
{$IFDEF Unix}
  //CFont = '../../fonts/arial.ttf';
  CFont = '../../fonts/Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
var
  ac: TAgg2D;
begin
  ac := TAgg2D.Create(self);
  if ac.Attach(img, FALSE) then
  begin
    ac.ClearAll(CWhite);
    ac.LineColor(CDark);
    ac.LineWidth(3);
    
    //ac.FillColor($FF, $00, $FF);
    ac.FillLinearGradient(0, 0, CImgWidth, 0, COrange, WithAlpha(COrange, 0));
    
    ac.Font({$IFDEF Unix}ExtractFilePath(ParamStr(0)) + {$ENDIF}CFont, 40);
    ac.TextAlignment(AGG_AlignCenter, AGG_AlignCenter);
    ac.Text(CImgWidth div 2, CImgHeight div 2, 'AGGPas');
    
    ac.NoLine;
    ac.FillColor(WithAlpha(CBlue, $80));
    ac.Arc(CImgWidth div 3, CImgHeight div 2, CImgWidth div 4, CImgHeight div 4, Deg2Rad(45), Deg2Rad(270));
  end;
  img.UpdateImage;
  ac.Free;
end;

constructor TFpgWidget1.Create(AComp: TComponent);
begin
  inherited Create(AComp);
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
  WindowTitle := 'TFpgForm & AGGPas';
  
  wg := TFpgWidget1.Create(self);
  wg.Left := CImgLeft;
  wg.Top := CImgTop;
  wg.Width := CImgWidth;
  wg.Height := CImgHeight;
end;

procedure TfpgForm1.HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean);
begin
  if KeyCode = keyEscape then
  begin
    Consumed := TRUE;
    Close;
  end;
  
  inherited HandleKeyPress(KeyCode, ShiftState, Consumed);
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
