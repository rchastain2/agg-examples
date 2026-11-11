unit Palette;

{$MODE DELPHI}

interface

uses
  agg_color;

const
  CBlue:      rgba8 = (r: $1E; g: $66; b: $F5; a: $FF);
  CDark:      rgba8 = (r: $4C; g: $4F; b: $69; a: $FF);
  COrange:    rgba8 = (r: $FE; g: $64; b: $0B; a: $FF);
  CGreen:     rgba8 = (r: $40; g: $A0; b: $2B; a: $FF);
  CRed:       rgba8 = (r: $D2; g: $0F; b: $39; a: $FF);
  CLightGray: rgba8 = (r: $CC; g: $D0; b: $DA; a: $FF);
  CWhite:     rgba8 = (r: $EF; g: $F1; b: $F5; a: $FF);

function WithAlpha(const AColor: rgba8; AAlpha: byte): rgba8;

implementation

function WithAlpha(const AColor: rgba8; AAlpha: byte): rgba8;
begin
  result := AColor;
  result.a := AAlpha;
end;

end.
