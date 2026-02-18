
program Clock;
{$MODE objfpc}{$H+}

uses
{$IFDEF UNIX}
  CThreads,
{$ENDIF}
  Classes, SysUtils,
  
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_widget,
  
  Agg2D,
  
  clockutils;

type
  TClockWidget = class(TFpgWidget)
  private
    FImage: TFpgImage;
  protected
    procedure HandlePaint; override;
  public
    constructor Create(AComp: TComponent); override;
    procedure DoAggPainting;
  end;
  
  TClockForm = class(TFpgForm)
  private
    procedure TimerFired(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  protected
    procedure HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean); override;
  public
    LTimer: TfpgTimer;
    LWidget: TClockWidget;
    constructor Create(AOwner: TComponent); override;
    procedure AfterCreate; override;
  end;

const
  CImgWidth  = 400;
  CImgHeight = CImgWidth;

procedure TClockWidget.DoAggPainting;
const
{$IFDEF Unix}
  //CFont = 'arial.ttf';
  CFont = '../Nougat-ExtraBlack.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
const
  CRadius1 = 7 * CImgWidth div 16;
  CRadius2 = 6 * CImgWidth div 16;
  CRadius3 = 5 * CImgWidth div 16;
  CRadius4 = 4 * CImgWidth div 16;
  CLineWidth = 10;
  CPointWidth: array[boolean] of integer = (CLineWidth div 2 + 1, CLineWidth div 2 + 2);
var
  LAgg: TAgg2D;
  LLightBlue, LDarkBlue: TAggColor;
  LPointWidth: integer;
  LAngles: TClockAngles;
  LHour: integer;
begin
  LAgg := TAgg2D.Create(self);
  if LAgg.Attach(FImage, FALSE) then
  begin
    LLightBlue.Construct(35, 151, 212); // #2397D4
    LDarkBlue.Construct(38, 47, 69); // #262F45
    
    LAgg.Translate(CImgWidth div 2, CImgHeight div 2);
    LAgg.ClearAll(LLightBlue);
    
    LAgg.LineWidth(CLineWidth);
    LAgg.LineColor(LDarkBlue);
    LAgg.FillColor(255, 255, 255);
    LAgg.Ellipse(0, 0, CRadius1, CRadius1);
    
    LAgg.NoLine;
    LAgg.FillColor(LDarkBlue);
    for LHour := 0 to 11 do
    begin
      LPointWidth := CPointWidth[LHour mod 3 = 0];
      LAgg.Ellipse(CRadius2 * Cos(LHour * PI / 6), CRadius2 * Sin(LHour * PI / 6), LPointWidth, LPointWidth);
    end;
    
    LAngles := GetClockAngles(TRUE);
    
    LAgg.LineWidth(CLineWidth);
    LAgg.LineColor(LDarkBlue);
    LAgg.Line(0, 0, CRadius4 * Cos(LAngles.Hour),   CRadius4 * Sin(LAngles.Hour));
    LAgg.Line(0, 0, CRadius3 * Cos(LAngles.Minute), CRadius3 * Sin(LAngles.Minute));
    
    LAgg.NoLine;
    LAgg.Font(CFont, 18);
    LAgg.TextAlignment(AGG_AlignRight, AGG_AlignBottom);
    LAgg.Text(CImgWidth div 2 - 12, CImgHeight div 2 - 12, 'AGGPas', true, 0.0, 0.0);
  end;
  FImage.UpdateImage;
  LAgg.Free;
end;

constructor TClockWidget.Create(AComp: TComponent);
begin
  inherited Create(AComp);
  FImage := TFpgImage.Create;
  FImage.AllocateImage(32, CImgWidth, CImgHeight);
end;

procedure TClockWidget.HandlePaint;
begin
  DoAggPainting;
  //Canvas.Clear(clWhite);
  Canvas.DrawImage(0, 0, FImage);
end;

constructor TClockForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LTimer := TfpgTimer.Create(1000);
  LTimer.OnTimer := @TimerFired;
  LTimer.Enabled := TRUE;
end;

procedure TClockForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  LTimer.Enabled := FALSE;
end;

procedure TClockForm.FormDestroy(Sender: TObject);
begin
  LTimer.Destroy;
end;

procedure TClockForm.HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean);
begin
  if KeyCode = KeyEscape then
  begin
    Consumed := TRUE;
    Close;
  end;
  inherited HandleKeyPress(KeyCode, ShiftState, Consumed);
end;

procedure TClockForm.TimerFired(Sender: TObject);
begin
  LWidget.Invalidate;
end;

procedure TClockForm.AfterCreate;
begin
  Name := 'ClockForm';
  SetPosition(0, 0, CImgWidth, CImgHeight);
  WindowTitle := 'Simple clock for fpGUI & AGGPas';
  WindowPosition := wpScreenCenter;
  
  Width := CImgWidth;
  Height := CImgHeight;
  
  LWidget := TClockWidget.Create(self);
  LWidget.SetPosition(0, 0, CImgWidth, CImgHeight);
end;

var
  frm: TClockForm;

begin
  fpgApplication.Initialize;
  frm := TClockForm.Create(nil);
  try
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end.
