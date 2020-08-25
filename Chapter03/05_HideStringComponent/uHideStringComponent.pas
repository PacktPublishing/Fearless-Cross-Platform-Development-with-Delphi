unit uHideStringComponent;

interface

uses
  System.Classes;

type
  THideString = class(TComponent)
  private
    FReverse: Boolean;
    FUseDigits: Boolean;
  public
    function Execute(const OrigString: string): string;
  published
    property Reverse: Boolean read FReverse write FReverse;
    property UseDigits: Boolean read FUseDigits write FUseDigits;
  end;

procedure Register;

implementation

uses
  uHideStringFunc;

function THideString.Execute(const OrigString: string): string;
begin
  Result := HideString(OrigString, FUseDigits, FReverse);
end;

procedure Register;
begin
  RegisterComponents('Samples', [THideString]);
end;

end.
