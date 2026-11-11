
{ 
  ptcdemo.pas
  Example of animation using PTCPas and AGGPas
  Based upon <ptcpas>/examples/buffer.pp
}

program BufferExample;

{$MODE objfpc}

uses
  ptc,
  agg_2D,
  Palette;

const
  SURFACE_WIDTH = 400;
  SURFACE_HEIGHT = SURFACE_WIDTH;

var
  console: IPTCConsole;
  format: IPTCFormat;
  width, height: Integer;
  pixels: PUint32 = nil;
  agg: Agg2D_ptr;
  
begin
  try
    try
      { create console }
      console := TPTCConsoleFactory.CreateNew;

      { create format }
      format := TPTCFormatFactory.CreateNew(32, $00FF0000, $0000FF00, $000000FF);
      
      { open the console }
      console.Open('PTCPas & AGGPas example [Press Esc to quit]', SURFACE_WIDTH, SURFACE_HEIGHT, format);
      
      { get console dimensions }
      width := console.Width;
      height := console.Height;

      { allocate a buffer of pixels }
      pixels := GetMem(width * height * SizeOf(Uint32));
      FillByte(pixels^, width * height * SizeOf(Uint32), 0);
      
      { create agg object }
      New(agg, Construct);
      agg^.attach(pbyte(pixels), width, height, width * 4);
      agg^.clearAll(CDark);
      agg^.noLine;
      
      { loop until a key is pressed }
      while not console.KeyPressed do
      begin
        { draw a random ellipse }
        case Random(4) of
          0: agg^.fillColor(WithAlpha(CBlue, Random(256)));
          1: agg^.fillColor(WithAlpha(COrange, Random(256)));
          2: agg^.fillColor(WithAlpha(CGreen, Random(256)));
        else
          agg^.fillColor(WithAlpha(CRed, Random(256)));
        end;
        agg^.ellipse(Random(width), Random(height), 20, 20);
        
        { load pixels to console }
        console.Load(pixels, width, height, width * 4, format, TPTCPaletteFactory.CreateNew);
        
        { update console }
        console.Update;
      end;
      
      { free agg object }
      Dispose(agg, Destruct);
      
    finally
      { free pixels buffer }
      FreeMem(pixels);
      if Assigned(console) then
        console.close;
    end;
  except
    on error: TPTCError do
      { report error }
      error.report;
  end;
end.
