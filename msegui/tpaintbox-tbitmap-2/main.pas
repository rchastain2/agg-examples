
unit main;

{$IFDEF FPC}{$MODE objfpc}{$H+}{$ENDIF}

interface

uses
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msestat,
  msemenus,
  msegui,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  msesimplewidgets,
  msebitmap,
  msekeyboard;

type
  tmainfo = class(tmainform)
    tpaintbox1: tpaintbox;
    procedure mainfo_oncreate(const sender: TObject);
    procedure mainfo_ondestroy(const sender: TObject);
    procedure tpaintbox1_onpaint(const sender: twidget; const acanvas: tcanvas);
    procedure mainfo_onkeyup(const sender: twidget; var ainfo: keyeventinfoty);
  private
    fbitmap: tbitmap;
  end;

var
  mainfo: tmainfo;

implementation

uses
  main_mfm,
  agg_2D,
  Palette,
  agg_basics;

procedure tmainfo.mainfo_oncreate(const sender: TObject);
begin
  fbitmap := tbitmap.create(bmk_rgb);
  fbitmap.clear;
  fbitmap.size := makesize(tpaintbox1.bounds_cx, tpaintbox1.bounds_cy);
  fbitmap.init(cl_red);
end;

procedure tmainfo.mainfo_ondestroy(const sender: TObject);
begin
  fbitmap.free;
end;

procedure tmainfo.tpaintbox1_onpaint(const sender: twidget; const acanvas: tcanvas);
var
  agg: agg2d_ptr;
begin
  new(agg, construct);
  agg^.attach(pbyte(fbitmap.scanline[0]), fbitmap.width, fbitmap.height, fbitmap.scanlinestep);
  agg^.clearall(CWhite);
  agg^.lineColor(CDark);
  agg^.fillLinearGradient(0, 0, fbitmap.width, fbitmap.height, COrange, WithAlpha(COrange, 0));
  agg^.arc(fbitmap.width div 2, fbitmap.height div 2, fbitmap.width div 3, fbitmap.height div 3, Deg2Rad(90), Deg2Rad(360));
  dispose(agg, destruct);
  fbitmap.paint(acanvas, nullpoint);
end;

procedure tmainfo.mainfo_onkeyup(const sender: twidget; var ainfo: keyeventinfoty);
begin
  if ainfo.key = KEY_ESCAPE then
    application.terminated := TRUE;
end;

end.
