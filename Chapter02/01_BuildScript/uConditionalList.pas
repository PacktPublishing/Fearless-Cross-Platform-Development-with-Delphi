unit uConditionalList;

interface

type
  TGetConditionalDefine = procedure(const CompDefined: string);

procedure GetConditionalDefines(GetCondDefProc: TGetConditionalDefine);
procedure SetupReferenceLinks;

const
  IntroText = 'Delphi has compiler directives that are defined in each version of Delphi that ' +
              'you can use in your code to determine, at compile-time, what version of Delphi ' +
              'is being used. Additionally, there are other compiler-defined symbols that ' +
              'indicate what operating system or CPU architecture it is running on. This ' +
              'program, when compiled in various versions of Delphi show many of these symbols. '  +
              'Try compiling under different versions or platforms to see the differences.';

  // this should always point to the most recent list of compiler version directives
  VersionsLink = 'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Compiler_Versions';

  // if all else failes, show this link
  OldDocLink = 'http://docs.embarcadero.com/products/rad_studio';
var
  // these should return links to the documentation for the current version of Delphi
  IntroLink1: string = '';
  IntroLink2: string = '';
  DirectivesLink: string = '';


implementation

procedure SetupReferenceLinks;
const
  D2010_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/2010/en/Conditional_Compilation';
  D2010_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/2010/en/Compiler_directives_for_libraries_or_shared_objects_(Delphi)';
  D2010_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/2010/en/Delphi_Compiler_Directives_(List)_Index';

  DXE_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE/en/Conditional_compilation_(Delphi)';
  DXE_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE/en/Delphi_compiler_directives';
  DXE_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE/en/Delphi_Compiler_Directives_(List)_Index';

  DXE2_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE2/en/Conditional_compilation_(Delphi)';
  DXE2_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE2/en/Delphi_compiler_directives';
  DXE2_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE2/en/Delphi_Compiler_Directives_(List)_Index';

  DXE3_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE3/en/Conditional_compilation_(Delphi)';
  DXE3_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE3/en/Delphi_compiler_directives';
  DXE3_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE3/en/Delphi_Compiler_Directives_(List)_Index';

  DXE4_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE4/en/Conditional_compilation_(Delphi)';
  DXE4_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE4/en/Delphi_compiler_directives';
  DXE4_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE4/en/Delphi_Compiler_Directives_(List)_Index';

  DXE5_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE5/en/Conditional_compilation_(Delphi)';
  DXE5_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE5/en/Delphi_compiler_directives';
  DXE5_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE5/en/Delphi_Compiler_Directives_(List)_Index';

  DXE6_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE6/en/Conditional_compilation_(Delphi)';
  DXE6_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE6/en/Delphi_compiler_directives';
  DXE6_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE6/en/Delphi_Compiler_Directives_(List)_Index';

  DXE7_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE7/en/Conditional_compilation_(Delphi)';
  DXE7_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE7/en/Delphi_compiler_directives';
  DXE7_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE7/en/Delphi_Compiler_Directives_(List)_Index';

  DXE8_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/XE8/en/Conditional_compilation_(Delphi)';
  DXE8_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/XE8/en/Delphi_compiler_directives';
  DXE8_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/XE8/en/Delphi_Compiler_Directives_(List)_Index';

  D100_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/Seattle/en/Conditional_compilation_(Delphi)';
  D100_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/Seattle/en/Delphi_compiler_directives';
  D100_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/Seattle/en/Delphi_Compiler_Directives_(List)_Index';

  D101_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/Berlin/en/Conditional_compilation_(Delphi)';
  D101_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/Berlin/en/Delphi_compiler_directives';
  D101_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/Berlin/en/Delphi_Compiler_Directives_(List)_Index';

  D102_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Conditional_compilation_(Delphi)';
  D102_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_compiler_directives';
  D102_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_Compiler_Directives_(List)_Index';

  D103_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/Rio/en/Conditional_compilation_(Delphi)';
  D103_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/Rio/en/Delphi_compiler_directives';
  D103_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/Rio/en/Delphi_Compiler_Directives_(List)_Index';

  D104_IntroLink1 = 'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Conditional_compilation_(Delphi)';
  D104_IntroLink2 = 'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Delphi_compiler_directives';
  D104_DirectivesList = 'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Delphi_Compiler_Directives_(List)_Index';
begin
  {$IFDEF VER210}   IntroLink1 := D2010_IntroLink1; IntroLink2 := D2010_IntroLink2; DirectivesLink := D2010_DirectivesList; {$ENDIF}
  {$IFDEF VER220}   IntroLink1 := DXE_IntroLink1; IntroLink2 := DXE_IntroLink2;  DirectivesLink := DXE_DirectivesList; {$ENDIF}
  {$IFDEF VER230}   IntroLink1 := DXE2_IntroLink1; IntroLink2 := DXE2_IntroLink2; DirectivesLink := DXE2_DirectivesList; {$ENDIF}
  {$IFDEF VER240}   IntroLink1 := DXE3_IntroLink1; IntroLink2 := DXE3_IntroLink2; DirectivesLink := DXE3_DirectivesList; {$ENDIF}
  {$IFDEF VER250}   IntroLink1 := DXE4_IntroLink1; IntroLink2 := DXE4_IntroLink2; DirectivesLink := DXE4_DirectivesList; {$ENDIF}
  {$IFDEF VER260}   IntroLink1 := DXE5_IntroLink1; IntroLink2 := DXE5_IntroLink2; DirectivesLink := DXE5_DirectivesList; {$ENDIF}
  {$IFDEF VER270}   IntroLink1 := DXE6_IntroLink1; IntroLink2 := DXE6_IntroLink2; DirectivesLink := DXE6_DirectivesList; {$ENDIF}
  {$IFDEF VER280}   IntroLink1 := DXE7_IntroLink1; IntroLink2 := DXE7_IntroLink2; DirectivesLink := DXE7_DirectivesList; {$ENDIF}
  {$IFDEF VER290}   IntroLink1 := DXE8_IntroLink1; IntroLink2 := DXE8_IntroLink2; DirectivesLink := DXE8_DirectivesList; {$ENDIF}
  {$IFDEF VER300}   IntroLink1 := D100_IntroLink1; IntroLink2 := D100_IntroLink2; DirectivesLink := D100_DirectivesList; {$ENDIF}
  {$IFDEF VER310}   IntroLink1 := D101_IntroLink1; IntroLink2 := D101_IntroLink2; DirectivesLink := D101_DirectivesList; {$ENDIF}
  {$IFDEF VER320}   IntroLink1 := D102_IntroLink1; IntroLink2 := D102_IntroLink2; DirectivesLink := D102_DirectivesList; {$ENDIF}
  {$IFDEF VER330}   IntroLink1 := D103_IntroLink1; IntroLink2 := D103_IntroLink2; DirectivesLink := D103_DirectivesList; {$ENDIF}
  {$IFDEF VER340}   IntroLink1 := D104_IntroLink1; IntroLink2 := D104_IntroLink2; DirectivesLink := D104_DirectivesList; {$ENDIF}
end;

procedure GetConditionalDefines(GetCondDefProc: TGetConditionalDefine);
begin
  // platform
  {$IFDEF LINUX}      GetCondDefProc('LINUX');                {$ENDIF}
  {$IFDEF LINUX32}    GetCondDefProc('LINUX32');              {$ENDIF}
  {$IFDEF LINUX64}    GetCondDefProc('LINUX64');              {$ENDIF}
  {$IFDEF MSWINDOWS}  GetCondDefProc('MSWINDOWS');            {$ENDIF}
  {$IFDEF WIN32}      GetCondDefProc('WIN32');                {$ENDIF}
  {$IFDEF WIN64}      GetCondDefProc('WIN64');                {$ENDIF}
  {$IFDEF IOS}        GetCondDefProc('IOS');                  {$ENDIF}
  {$IFDEF IOS32}      GetCondDefProc('IOS32');                {$ENDIF}
  {$IFDEF IOS64}      GetCondDefProc('IOS64');                {$ENDIF}
  {$IFDEF NATIVECODE} GetCondDefProc('NATIVECODE');           {$ENDIF}
  {$IFDEF MACOS}      GetCondDefProc('MACOS');                {$ENDIF}
  {$IFDEF MACOS32}    GetCondDefProc('MACOS32');              {$ENDIF}
  {$IFDEF MACOS64}    GetCondDefProc('MACOS64');              {$ENDIF}
  {$IFDEF POSIX}      GetCondDefProc('POSIX');                {$ENDIF}
  {$IFDEF POSIX32}    GetCondDefProc('POSIX32');              {$ENDIF}
  {$IFDEF POSIX64}    GetCondDefProc('POSIX64');              {$ENDIF}
  {$IFDEF ANDROID}    GetCondDefProc('ANDROID');              {$ENDIF}
  {$IFDEF ANDROID32}  GetCondDefProc('ANDROID32');            {$ENDIF}
  {$IFDEF ANDROID64}  GetCondDefProc('ANDROID64');            {$ENDIF}

  // cpu
  {$IFDEF CPU386}     GetCondDefProc('CPU386');               {$ENDIF}
  {$IFDEF CPUARM}     GetCondDefProc('CPUARM');               {$ENDIF}
  {$IFDEF CPUARM64}   GetCondDefProc('CPUARM64');             {$ENDIF}
  {$IFDEF CPUX86}     GetCondDefProc('CPUX86');               {$ENDIF}
  {$IFDEF CPUX64}     GetCondDefProc('CPUX64');               {$ENDIF}
  {$IFDEF CPU32BITS}  GetCondDefProc('CPU32BITS');            {$ENDIF}
  {$IFDEF CPU64BITS}  GetCondDefProc('CPU64BITS');            {$ENDIF}

  // application type
  {$IFDEF CONSOLE}    GetCondDefProc('CONSOLE');              {$ENDIF}

  // default build configurations
  {$IFDEF RELEASE}    GetCondDefProc('RELEASE');              {$ENDIF}
  {$IFDEF DEBUG}      GetCondDefProc('DEBUG');                {$ENDIF}

  // available options
  {$IFDEF ALIGN_STACK}             GetCondDefProc('ALIGN_STACK');            {$ENDIF}
  {$IFDEF ASSEMBLER}               GetCondDefProc('ASSEMBLER');              {$ENDIF}
  {$IFDEF AUTOREFCOUNT}            GetCondDefProc('AUTOREFCOUNT');           {$ENDIF}
  {$IFDEF EXTERNALLINKER}          GetCondDefProc('EXTERNALLINKER');         {$ENDIF}
  {$IFDEF UNICODE}                 GetCondDefProc('UNICODE');                {$ENDIF}
  {$IFDEF CONDITIONALEXPRESSIONS}  GetCondDefProc('CONDITIONALEXPRESSIONS'); {$ENDIF}
  {$IFDEF ELF}                     GetCondDefProc('ELF');                    {$ENDIF}
  {$IFDEF NEXTGEN}                 GetCondDefProc('NEXTGEN');                {$ENDIF}
  {$IFDEF PC_MAPPED_EXCEPTIONS}    GetCondDefProc('PC_MAPPED_EXCEPTIONS');   {$ENDIF}
  {$IFDEF PIC}                     GetCondDefProc('PIC');                    {$ENDIF}
  {$IFDEF UNDERSCOREIMPORTNAME}    GetCondDefProc('UNDERSCOREIMPORTNAME');   {$ENDIF}
  {$IFDEF WEAKREF}                 GetCondDefProc('WEAKREF');                {$ENDIF}
  {$IFDEF WEAKINSTREF	}            GetCondDefProc('WEAKINSTREF	');          {$ENDIF}
  {$IFDEF WEAKINTFREF}             GetCondDefProc('WEAKINTFREF');            {$ENDIF}

  // delphi versions
  {$IFDEF VER80}    GetCondDefProc('VER80: Delphi 1');     {$ENDIF}
  {$IFDEF VER90}    GetCondDefProc('VER90: Delphi 2');     {$ENDIF}
  {$IFDEF VER100}   GetCondDefProc('VER100: Delphi 3');    {$ENDIF}
  {$IFDEF VER120}   GetCondDefProc('VER120: Delphi 4');    {$ENDIF}
  {$IFDEF VER130}   GetCondDefProc('VER130: Delphi 5');    {$ENDIF}
  {$IFDEF VER140}   GetCondDefProc('VER140: Delphi 6, package version 60');    {$ENDIF}
  {$IFDEF VER150}   GetCondDefProc('VER150: Delphi 7, package version 70');    {$ENDIF}
  {$IFDEF VER160}   GetCondDefProc('VER160: Delphi 8, package version 80');    {$ENDIF}
  {$IFDEF VER170}   GetCondDefProc('VER170: Delphi 2005 (ver 9), package version 90'); {$ENDIF}
  {$IFDEF VER180}   GetCondDefProc('VER180: Delphi 2006 (ver 10), package version 100'); {$ENDIF}
  {$IFDEF VER185}   GetCondDefProc('VER185: Delphi 2007 (ver 11), package version 110'); {$ENDIF}
  {$IFDEF VER200}   GetCondDefProc('VER200: Delphi 2009 (ver 12), package version 120'); {$ENDIF}
  {$IFDEF VER210}   GetCondDefProc('VER210: Delphi 2010 (ver 14), package version 140'); {$ENDIF}
  {$IFDEF VER220}   GetCondDefProc('VER220: Delphi XE (ver 15), package version 150');   {$ENDIF}
  {$IFDEF VER230}   GetCondDefProc('VER230: Delphi XE2 (ver 16), package version 160, 161');  {$ENDIF}
  {$IFDEF VER240}   GetCondDefProc('VER240: Delphi XE3 (ver 17), package version 170');  {$ENDIF}
  {$IFDEF VER250}   GetCondDefProc('VER250: Delphi XE4 (ver 18), package version 180');  {$ENDIF}
  {$IFDEF VER260}   GetCondDefProc('VER260: Delphi XE5 (ver 19), package version 190');  {$ENDIF}
  {$IFDEF VER270}   GetCondDefProc('VER270: Delphi XE6 (ver 20), package version 200');  {$ENDIF}
  {$IFDEF VER280}   GetCondDefProc('VER280: Delphi XE7 (ver 21), package version 210');  {$ENDIF}
  {$IFDEF VER290}   GetCondDefProc('VER290: Delphi XE8 (ver 22), package version 220');  {$ENDIF}
  {$IFDEF VER300}   GetCondDefProc('VER300: Delphi 10 Seattle (ver 23), package version 230');  {$ENDIF}
  {$IFDEF VER310}   GetCondDefProc('VER310: Delphi 10.1 Berlin (ver 24), package version 240');  {$ENDIF}
  {$IFDEF VER320}   GetCondDefProc('VER320: Delphi 10.2 Tokyo (ver 25), package version 250');  {$ENDIF}
  {$IFDEF VER330}   GetCondDefProc('VER330: Delphi 10.3 Rio (ver 26), package version 260');  {$ENDIF}
  {$IFDEF VER340}   GetCondDefProc('VER340: Delphi 10.4 Sydney (ver 27), package version 270');  {$ENDIF}
end;

end.
