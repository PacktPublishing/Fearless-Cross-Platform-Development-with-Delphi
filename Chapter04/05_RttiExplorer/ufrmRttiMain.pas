unit ufrmRttiMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Rtti, System.TypInfo;

type
  TfrmRttiMain = class(TForm)
    lbRttiInfo: TListBox;
    pnlTop: TPanel;
    grpSample: TGroupBox;
    edtEditSample: TEdit;
    lblEditLabel: TLabel;
    edtLabeledEditSample: TLabeledEdit;
    radColors: TRadioGroup;
    tbSample: TTrackBar;
    cbCheckSample: TCheckBox;
    btnOK: TButton;
    procedure ComponentClick(Sender: TObject);
    procedure cbCheckSampleClick(Sender: TObject);
  private
    function GetPropertyValueAsString(Sender: TObject; LProperty: TRttiProperty): string;
  end;

var
  frmRttiMain: TfrmRttiMain;

implementation

{$R *.dfm}

{ TfrmRttiMain }

procedure TfrmRttiMain.cbCheckSampleClick(Sender: TObject);
begin
  btnOK.Enabled := cbCheckSample.Checked;
  ComponentClick(Sender);
end;

function TfrmRttiMain.GetPropertyValueAsString(Sender: TObject; LProperty: TRttiProperty): string;
var
  LValue: TValue;
begin
  LValue := LProperty.GetValue(Sender);
  case LProperty.PropertyType.TypeKind of
    tkString, tkLString, tkUString:
      Result := LProperty.GetValue(Sender).AsString;
    tkInt64, tkInteger:
      Result := IntToStr(LProperty.GetValue(Sender).AsInteger);
    tkFloat:
      Result := FloatToStr(LProperty.GetValue(Sender).AsExtended);
    tkEnumeration:
      Result := GetEnumName(LProperty.PropertyType.Handle, LValue.AsOrdinal);
  else
    Result := 'Unsupported type: ' + LProperty.PropertyType.Name;
  end;
end;

procedure TfrmRttiMain.ComponentClick(Sender: TObject);
var
  LContext: TRttiContext;
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LStrValue: string;
  LPropEntry: string;
begin
  lbRttiInfo.Items.Clear;

  LContext := TRttiContext.Create;
  try
    LRttiType := LContext.GetType(Sender.ClassType);
    lbRttiInfo.Items.Add('== ' + LRttiType.Name + ' ==');

    for LProperty in LRttiType.GetProperties do
      if LProperty.PropertyType.TypeKind in ([tkUString, tkString, tkLString, tkInteger, tkInt64, tkEnumeration, tkFloat]) then begin
        LStrValue := GetPropertyValueAsString(Sender, LProperty);

        LPropEntry := LProperty.Name + ': ' + LProperty.PropertyType.Name + ' = ' + LStrValue;
        if lbRttiInfo.Items.IndexOf(LPropEntry) = -1 then
          lbRttiInfo.Items.Add(LPropEntry);
      end;
  finally
    LContext.Free;
  end;
end;

end.
