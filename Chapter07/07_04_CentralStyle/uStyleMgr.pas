unit uStyleMgr;

interface

type
  TStyleMgr = class
    class procedure LoadCalypsoStyle;
    class procedure LoadVaperStyle;
    class procedure LoadWedgewoodStyle;
    class procedure LoadEmeraldStyle;
  end;

implementation

uses
  FMX.Styles;


{ TStyleMgr }

class procedure TStyleMgr.LoadCalypsoStyle;
begin
  {$IFDEF MSWINDOWS} TStyleManager.TrySetStyleFromResource('Style_Calypso_Windows');  {$ENDIF}
  {$IFDEF MACOS}     TStyleManager.TrySetStyleFromResource('Style_Calypso_Mac');      {$ENDIF}
  {$IFDEF IOS}       TStyleManager.TrySetStyleFromResource('Style_Calypso_iOS');      {$ENDIF}
  {$IFDEF ANDROID}   TStyleManager.TrySetStyleFromResource('Style_Calypso_Android');  {$ENDIF}
end;

class procedure TStyleMgr.LoadEmeraldStyle;
begin
  {$IFDEF MSWINDOWS} TStyleManager.TrySetStyleFromResource('Style_Emerald_Windows');  {$ENDIF}
  {$IFDEF MACOS}     TStyleManager.TrySetStyleFromResource('Style_Emerald_Mac');      {$ENDIF}
  {$IFDEF IOS}       TStyleManager.TrySetStyleFromResource('Style_Emerald_iOS');      {$ENDIF}
  {$IFDEF ANDROID}   TStyleManager.TrySetStyleFromResource('Style_Emerald_Android');  {$ENDIF}
end;

class procedure TStyleMgr.LoadVaperStyle;
begin
  {$IFDEF MSWINDOWS} TStyleManager.TrySetStyleFromResource('Style_Vapor_Windows');  {$ENDIF}
  {$IFDEF MACOS}     TStyleManager.TrySetStyleFromResource('Style_Vapor_Mac');      {$ENDIF}
  {$IFDEF IOS}       TStyleManager.TrySetStyleFromResource('Style_Vapor_iOS');      {$ENDIF}
  {$IFDEF ANDROID}   TStyleManager.TrySetStyleFromResource('Style_Vapor_Android');  {$ENDIF}
end;

class procedure TStyleMgr.LoadWedgewoodStyle;
begin
  {$IFDEF MSWINDOWS} TStyleManager.TrySetStyleFromResource('Style_Wedgewood_Windows');  {$ENDIF}
  {$IFDEF MACOS}     TStyleManager.TrySetStyleFromResource('Style_Wedgewood_Mac');      {$ENDIF}
  {$IFDEF IOS}       TStyleManager.TrySetStyleFromResource('Style_Wedgewood_iOS');      {$ENDIF}
  {$IFDEF ANDROID}   TStyleManager.TrySetStyleFromResource('Style_Wedgewood_Android');  {$ENDIF}
end;

initialization
  TStyleMgr.LoadCalypsoStyle;
end.
