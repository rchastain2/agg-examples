
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
  fpg_imgfmt_png,
  
  Agg2D,
  ClockUtils;

type
  TClockWidget = class(TFpgWidget)
  private
    FImage, FStatic: TFpgImage;
  protected
    procedure HandlePaint; override;
  public
    constructor Create(AComp: TComponent); override;
    destructor Destroy; override;
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

{$I clocksize}

procedure TClockWidget.DoAggPainting;
(* https://www.crossgl.com/aggpas/documentation/index.html#CopyImage2 *)
var
  LAgg: TAgg2D;
  LColor: TAggColor;
  LAngles: TClockAngles;
begin
  LAgg := TAgg2D.Create(self);
  if LAgg.Attach(FImage, FALSE) then
  begin
    //LLight.Construct(35, 151, 212); // #2397D4
    LColor.Construct(38, 47, 69); // #262F45
    
    LAgg.CopyImage(FStatic, 0, 0);
    
    LAgg.Translate(CImgWidth div 2, CImgHeight div 2);

    (*
    LAgg.LineWidth(CLineWidth);
    LAgg.LineColor(LDark);
    LAgg.FillColor(255, 255, 255);
    LAgg.Ellipse(0, 0, CRadius1, CRadius1);
    
    LAgg.NoLine;
    LAgg.FillColor(LDark);
    for LHour := 0 to 11 do
    begin
      LPointWidth := CPointWidth[LHour mod 3 = 0];
      LAgg.Ellipse(CRadius2 * Cos(LHour * PI / 6), CRadius2 * Sin(LHour * PI / 6), LPointWidth, LPointWidth);
    end;
    *)
    
    LAngles := GetClockAngles(TRUE);
    
    LAgg.LineWidth(CLineWidth);
    LAgg.LineColor(LColor);
   {LAgg.LineCap(AGG_CapSquare);}
    LAgg.Line(0, 0, CRadius4 * Cos(LAngles.Hour),   CRadius4 * Sin(LAngles.Hour));
    LAgg.Line(0, 0, CRadius3 * Cos(LAngles.Minute), CRadius3 * Sin(LAngles.Minute));
  end;
  FImage.UpdateImage;
  LAgg.Free;
end;

constructor TClockWidget.Create(AComp: TComponent);
const
  CFile = 'factory' + DirectorySeparator + 'static.png';
begin
  inherited Create(AComp);
  FImage := TFpgImage.Create;
  FImage.AllocateImage(32, CImgWidth, CImgHeight);
  FStatic := LoadImage_PNG(CFile);
  if not Assigned(FStatic) then
    raise Exception.Create('Failed to load ' + CFile);
end;

destructor TClockWidget.Destroy;
begin
  FStatic.Free;
  FImage.Free;
  inherited Destroy;
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
  //LWidget.Free;
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

  WindowTitle := 'Clock for fpGUI & AGGPas';
  
  SetPosition(0, 0, CImgWidth, CImgHeight);
  //Width := CImgWidth;
  //Width := CImgHeight;
  WindowPosition := wpScreenCenter;
  Sizeable := FALSE;
  
  LWidget := TClockWidget.Create(self);
  //LWidget.SetPosition(0, 0, CImgWidth, CImgHeight);
  LWidget.Width := CImgWidth;
  LWidget.Height := CImgHeight;
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
