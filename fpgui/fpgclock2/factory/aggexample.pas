
unit AggExample;

interface

uses
  SysUtils,
  agg_2D;

type
  TAggExample = class
  public
    constructor Create(AWidth, AHeight: integer; AFileName: string);
    destructor Destroy; override;
    procedure DrawImage;
    procedure SaveToPng;
  private
    FFileName: string;
    FData: array of byte;
  protected
    FWidth, FHeight: integer;
    procedure Draw(agg: Agg2D_ptr); virtual;
  public
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;
  
implementation

uses
  FPImage,
  FPWritePNG;

const
  CColorW = 4;

constructor TAggExample.Create(AWidth, AHeight: integer; AFileName: string);
begin
  FWidth := AWidth;
  FHeight := AHeight;
  FFileName := AFileName;
  
  SetLength(FData, FWidth * FHeight * CColorW);
end;

destructor TAggExample.Destroy;
begin
  SetLength(FData, 0);
  inherited;
end;

procedure TAggExample.DrawImage;
var
  agg: Agg2D_ptr;
begin
  New(agg, Construct);
  agg^.attach(@(FData[0]), FWidth, FHeight, FWidth * CColorW);
  Draw(agg);
  Dispose(agg, Destruct);
end;

procedure TAggExample.Draw(agg: Agg2D_ptr);
begin
  agg^.clearAll(0, 0, 0, 0);
end;

procedure TAggExample.SaveToPng;
var
  img: TFPMemoryImage;
  png: TFPWriterPNG;
  c: TFPColor;
  x, y: integer;
  
  function getBufItemAsWord(ADelta: byte): Word;
  var
    i: integer;
    v, a: Word;
  begin
    i := x * CColorW + (FHeight - y - 1) * FWidth * CColorW;
    v := FData[i + ADelta];
    a := FData[i + 3];
    if (ADelta <> 3) and (a > 0) and (a < 255) then
    begin
      v := v * 255 div a;
      if v > 255 then
        v := 255;
    end;
    result := (v shl 8) or v;
  end;
  
begin
  img := TFPMemoryImage.create(FWidth, FHeight);
  
  for x := 0 to FWidth - 1 do
    for y := 0 to FHeight - 1 do
    begin
      c.red   := getBufItemAsWord(2);
      c.green := getBufItemAsWord(1);
      c.blue  := getBufItemAsWord(0);
      c.alpha := getBufItemAsWord(3);
      img.Colors[x, y] := c;
    end;
  
  png := TFPWriterPNG.Create;
  png.UseAlpha := TRUE;
  png.WordSized := FALSE;
  img.SaveToFile(FFileName, png);
  png.Free;
  img.Free;
end;

end.
