unit uHideStringComponent;

interface

uses
  System.Classes;

type
  THideString = class(TComponent)
  public
    function Execute(const OrigString: string): string;
  end;

procedure Register;

implementation

uses
  uHideStringFunc;

function THideString.Execute(const OrigString: string): string;
begin
  Result := HideString(OrigString);
end;

procedure Register;
begin
  RegisterComponents('Samples', [THideString]);
end;

end.
