unit Fearless.Bind;

interface

implementation

uses
  System.SysUtils,
  System.Bindings.Methods, System.Bindings.EvalProtocol,
  System.Bindings.Consts, System.TypInfo,
  System.TimeSpan;

function MakeNowMethod: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
    begin
      Result := TValueWrapper.Create(Now);
    end);
end;

function MakeYearsSinceMethod: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
    var
      InputValue: IValue;
      InputDate: TDate;
      YearsSince: Double;
    begin
      // Ensure only one argument is received.
      if Length(Args) <> 1 then
        raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));

      // Ensure that the received argument is an TDate.
      InputValue := Args[0];
      if not (InputValue.GetType.Kind in [tkFloat]) then
        raise EEvaluatorError.Create('Argument to YearsSince must be TDate');

      // Calculate the output
      InputDate := InputValue.GetValue.AsExtended;
      YearsSince := TTimeSpan.Subtract(Now, InputDate).TotalDays / 365.25;

      // Return the output integer.
      Result := TValueWrapper.Create(YearsSince);
    end);
end;


const
  sNowMethod = 'Now';
  sNowDescription = 'Returns the current date/time';
  sYearsSinceMethod = 'YearsSince';
  sYearsSinceDescription = 'Returns the number of years since the given date';

procedure RegisterMethods;
begin
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(MakeNowMethod,
      sNowMethod, sNowMethod,
      EmptyStr, True, sNowDescription, nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeYearsSinceMethod,
      sYearsSinceMethod, sYearsSinceMethod,
      EmptyStr, True, sYearsSinceDescription, nil));
end;

procedure UnregisterMethods;
begin
  TBindingMethodsFactory.UnRegisterMethod(sNowMethod);
  TBindingMethodsFactory.UnRegisterMethod(sYearsSinceMethod);
end;

initialization
  RegisterMethods;
finalization
  UnregisterMethods;
end.

