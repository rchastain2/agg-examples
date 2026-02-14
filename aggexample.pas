
unit AggExample;

interface

uses
  SysUtils,
  agg_2D,
  agg_basics;

type
  TAggExample = class
  public
    constructor Create(AImageW, AImageH: integer; AFileName: string);
    destructor Destroy; override;
    procedure DrawImage;
    procedure SaveToPng;
  private
    FFileName: string;
    FData: array of int8;
  protected
    FImageW, FImageH: integer;
    procedure Draw(agg: Agg2D_ptr); virtual;
  end;
  
implementation

uses
  FPimage,
  FPWritePNG;

const
  CColorW = 4;

constructor TAggExample.Create(AImageW, AImageH: integer; AFileName: string);
begin
  FImageW := AImageW;
  FImageH := AImageH;
  FFileName := AFileName;
  
  SetLength(FData, FImageW * FImageH * CColorW);
end;

destructor TAggExample.Destroy;
begin
  SetLength(FData, 0);
end;

procedure TAggExample.DrawImage;
var
  agg: Agg2D_ptr;
begin
  New(agg, Construct);
  agg^.attach(@(FData[0]), FImageW, FImageH, FImageW * CColorW);
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
    y1: integer;
  begin
    y1 := FImageH - y - 1;
    result :=
      Word(FData[x * CColorW + y1 * FImageW * CColorW + ADelta] shl 8) or
      Word(128);
  end;
  
begin
  img := TFPMemoryImage.create(FImageW, FImageH);
  
  for x := 0 to FImageW - 1 do
    for y := 0 to FImageH - 1 do
    begin
      c.red   := getBufItemAsWord(2);
      c.green := getBufItemAsWord(1);
      c.blue  := getBufItemAsWord(0);
      c.alpha := getBufItemAsWord(3);
      img.Colors[x, y] := c;
    end;
  
  png := TFPWriterPNG.Create;
  png.UseAlpha := TRUE;
  img.SaveToFile(FFileName, png);
  png.Free;
  
  img.Free;
end;

end.
