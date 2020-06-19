program DelphiVersionsConsole;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uConditionalList in 'uConditionalList.pas';

procedure ShowCompilerDefine(const CompDefined: string);
begin
  Writeln(CompDefined);
end;

begin
  Writeln(IntroText);
  Writeln;

  GetConditionalDefines(ShowCompilerDefine);
  SetupReferenceLinks;

  Writeln;
  Writeln('References...');
  Writeln('About Conditional Compilation: ' + sLineBreak + '  ' + IntroLink1);
  Writeln('Classifications of Compiler Directives: ' + sLineBreak + '  ' + IntroLink2);
  Writeln('Compiler Directives for this version of Delphi ' + sLineBreak + '  ' + DirectivesLink);
  Writeln('Compiler Version Directives for all versions of Delphi: ' + sLineBreak + '  ' + VersionsLink);

  Readln;
end.
