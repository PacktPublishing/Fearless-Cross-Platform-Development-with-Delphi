program ManagedRecordsDemo;
{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TMyUnmanagedFlags = record
    FlagHeader: string;
    Flag1: Boolean;
    Flag2: Boolean;
    Flag3: Integer;
  end;

  TMyManagedFlags = record
    FlagHeader: string;
    Flag1: Boolean;
    Flag2: Boolean;
    Flag3: Integer;
    class operator Initialize (out Dest: TMyManagedFlags);
    class operator Finalize(var Dest: TMyManagedFlags);
  end;

class operator TMyManagedFlags.Initialize (out Dest: TMyManagedFlags);
begin
  Dest.FlagHeader := 'My Custom Managed Flag Record';
  Dest.Flag1 := True;
  Dest.Flag2 := False;
  Dest.Flag3 := 100;
  Writeln('Flags initialized');
end;

class operator TMyManagedFlags.Finalize(var Dest: TMyManagedFlags);
begin
  Writeln('Flags finalized');
end;

procedure ShowFlags;
const
  FALSE_TRUE_STRS: array[Boolean] of string = ('False', 'True');
var
  uflags: TMyUnmanagedFlags;
  mflags: TMyManagedFlags;
begin
  Writeln('Here are the unmanaged flags...');
  Writeln('  Header: ' + uflags.FlagHeader);
  Writeln('  Flag1 = ' + FALSE_TRUE_STRS[uflags.Flag1]);
  Writeln('  Flag2 = ' + FALSE_TRUE_STRS[uflags.Flag2]);
  Writeln('  Flag3 = ' + uflags.Flag3.ToString);

  Writeln('Here are the managed flags...');
  Writeln('  Header: ' + mflags.FlagHeader);
  Writeln('  Flag1 = ' + FALSE_TRUE_STRS[mflags.Flag1]);
  Writeln('  Flag2 = ' + FALSE_TRUE_STRS[mflags.Flag2]);
  Writeln('  Flag3 = ' + mflags.Flag3.ToString);
end;

begin
  Writeln('Flag demo starting');
  ShowFlags;
  Writeln('Flag demo done');

  Readln;
end.
