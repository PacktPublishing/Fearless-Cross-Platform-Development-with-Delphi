unit ufrmCentralStyleFormsMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, System.Actions, FMX.ActnList,
  FMX.StdActns;

type
  TfrmMultiFormsMain = class(TForm)
    lbStyles: TListBox;
    btnShowBlueForm: TButton;
    aclFormButtons: TActionList;
    actShowFormOne: TAction;
    actShowFormTwo: TAction;
    actShowFormThree: TAction;
    Button2: TButton;
    Button3: TButton;
    btnClose: TButton;
    actFileExit: TFileExit;
    procedure actShowFormOneExecute(Sender: TObject);
    procedure actShowFormThreeExecute(Sender: TObject);
    procedure actShowFormTwoExecute(Sender: TObject);
    procedure lbStylesChange(Sender: TObject);
  end;

var
  frmMultiFormsMain: TfrmMultiFormsMain;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.Macintosh.fmx MACOS}
{$R *.Windows.fmx MSWINDOWS}
{$R *.iPad.fmx IOS}

uses
  uStyleMgr,
  ufrmCentralStyleFormOne, ufrmCentralStyleFormTwo, ufrmCentralStyleFormThree;

procedure TfrmMultiFormsMain.actShowFormOneExecute(Sender: TObject);
begin
  frmCentralStyleFormOne.Show;
end;

procedure TfrmMultiFormsMain.actShowFormTwoExecute(Sender: TObject);
begin
  frmCentralStyleFormTwo.Show;
end;

procedure TfrmMultiFormsMain.actShowFormThreeExecute(Sender: TObject);
begin
  frmCentralStyleFormThree.Show;
end;

procedure TfrmMultiFormsMain.lbStylesChange(Sender: TObject);
begin
  if lbStyles.ItemIndex > -1 then
    case lbStyles.ItemIndex of
      0: TStyleMgr.LoadCalypsoStyle;
      1: TStyleMgr.LoadVaperStyle;
      2: TStyleMgr.LoadWedgewoodStyle;
      3: TStyleMgr.LoadEmeraldStyle;
    end;
end;

end.
