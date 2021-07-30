unit ufrmRttiExplorerMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation,
  System.Rtti, System.TypInfo;

type
  TfrmRttiMainFM = class(TForm)
    pnlTop: TPanel;
    lblPanelCaption: TLabel;
    lbRttiInfo: TListBox;
    grpSample: TGroupBox;
    lblEditLabel: TLabel;
    Edit1: TEdit;
    grpColors: TGroupBox;
    radWhite: TRadioButton;
    radSilver: TRadioButton;
    radRed: TRadioButton;
    radGreen: TRadioButton;
    radBlue: TRadioButton;
    radBlack: TRadioButton;
    lblSecondLabel: TLabel;
    edtEdit2: TEdit;
    tbSample: TTrackBar;
    cbCheckSample: TCheckBox;
    btnOK: TButton;
    procedure cbCheckSampleChange(Sender: TObject);
    procedure ComponentClick(Sender: TObject);
  private
    function GetPropertyValueAsString(Sender: TObject; LProperty: TRttiProperty): string;
  end;

var
  frmRttiMainFM: TfrmRttiMainFM;

implementation

{$R *.fmx}

{ TForm1 }

procedure TfrmRttiMainFM.cbCheckSampleChange(Sender: TObject);
begin
  btnOK.Enabled := cbCheckSample.IsChecked;
  ComponentClick(Sender);
end;

function TfrmRttiMainFM.GetPropertyValueAsString(Sender: TObject; LProperty: TRttiProperty): string;
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

procedure TfrmRttiMainFM.ComponentClick(Sender: TObject);
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
