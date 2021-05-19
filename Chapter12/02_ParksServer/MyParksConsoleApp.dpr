program MyParksConsoleApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  udmParksDB in 'udmParksDB.pas' {dmParksDB: TDataModule};

var
  long, lat: Double;
  ParkRec: TdmParksDB.TParkDataRec;
begin
  try
    Writeln('--MyParks Lookup Test--');
    Write('Enter the longitude: ');
    Readln(long);
    Write('Enter the latitude: ');
    Readln(lat);

    ParkRec := dmParksDB.LookupParkByLocation(long, lat);
    if ParkRec.ParkID > -1 then
      Writeln(Format('Park %d: "%s" (%0.3f, %0.3f)', [ParkRec.ParkID,
                ParkRec.ParkName, ParkRec.Longitude, ParkRec.Latitude]))
    else
      Writeln(Format('Coordinates (%0.3f, %0.3f) not found.', [long, lat]));

    Write('Press Enter...');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
