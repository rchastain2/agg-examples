program demo;

{$IFDEF FPC}{$MODE objfpc}{$H+}{$ENDIF}
{$IFDEF FPC}
{$IFDEF mswindows}{$APPTYPE console}{$ENDIF}
{$ENDIF}

uses
{$IFDEF FPC}{$IFDEF unix}
  cthreads,
{$ENDIF}{$ENDIF}
  msetypes,
  msegraphutils,
  msegraphics,
  msebitmap,
  mseformatpngwrite,
  agg_2D,
  Palette,
  agg_basics;

const
  WIDTH = 400;
  HEIGHT = 400;
  FILENAME = 'output.png';

procedure Draw(ABitmap: tmaskedbitmap);
var
  pixels: puint32;
  agg: agg2d_ptr;
  psrc: pbyte;
  y: integer;
begin
  pixels := getmem(ABitmap.width * ABitmap.height * sizeof(uint32));
  fillbyte(pixels^, ABitmap.width * ABitmap.height * sizeof(uint32), 0);

  new(agg, construct);
  agg^.attach(pbyte(pixels), ABitmap.width, ABitmap.height, ABitmap.width * 4);
  agg^.clearall(CWhite);
  agg^.lineColor(CDark);
  agg^.fillLinearGradient(0, 0, ABitmap.width, ABitmap.height, COrange, WithAlpha(COrange, 0));
  agg^.arc(ABitmap.width div 2, ABitmap.height div 2, ABitmap.width div 3, ABitmap.height div 3, Deg2Rad(90), Deg2Rad(360));
  dispose(agg, destruct);

  psrc := pbyte(pixels);
  for y := 0 to ABitmap.height - 1 do
  begin
    move(psrc^, ABitmap.scanline[y]^, ABitmap.width * 4);
    inc(psrc, ABitmap.width * 4);
  end;

  freemem(pixels);
end;

var
  bitmap: tmaskedbitmap;

begin
  bitmap := tmaskedbitmap.create(bmk_rgb);
  try
    bitmap.size := makesize(WIDTH, HEIGHT);
    bitmap.init(cl_white);
    Draw(bitmap);
    bitmap.writetofile(FILENAME, 'png', []);
    writeln('Written: ', FILENAME);
  finally
    bitmap.free;
  end;
end.
