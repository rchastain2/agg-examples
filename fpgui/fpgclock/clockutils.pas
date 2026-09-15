
unit ClockUtils;

interface

type
  TClockAngles = record
    Hour, Minute, Second: double;
  end;

function GetClockAngles(const AntiTrigonometric: boolean = FALSE): TClockAngles;

implementation

uses
  SysUtils;

function GetClockAngles(const AntiTrigonometric: boolean): TClockAngles;
const
  CNoon1 = PI / 2;
  CNoon2 = 3 * PI / 2;
var
  LHour, LMinute, LSecond, LMSecond: word;
begin
  DecodeTime(Time, LHour, LMinute, LSecond, LMSecond);
  {
  result.Hour   := LHour   * PI / 6  + CNoon + LMinute * PI / 360;
  result.Minute := LMinute * PI / 30 + CNoon + LSecond * PI / 1800;
  result.Second := LSecond * PI / 30 + CNoon;
  }
  result.Second := LSecond * PI / 30;
  result.Minute := LMinute * PI / 30 + result.Second / 60;
  result.Hour   := LHour   * PI /  6 + result.Minute / 12;
  
  if AntiTrigonometric then { antitrigonometric direction, unit Agg2D }
  begin
    result.Second := CNoon2 + result.Second;
    result.Minute := CNoon2 + result.Minute;
    result.Hour   := CNoon2 + result.Hour;
  end else                  { trigonometric direction, unit agg_2D }
  begin
    result.Second := CNoon1 - result.Second;
    result.Minute := CNoon1 - result.Minute;
    result.Hour   := CNoon1 - result.Hour;
  end;
end;

end.
