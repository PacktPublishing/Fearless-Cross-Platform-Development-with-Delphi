unit HeaderFooterFormwithNavigation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.Colors, FMX.ComboEdit,
  FMX.SpinBox, FMX.EditBox, FMX.NumberBox, FMX.DateTimeCtrls;

type
  THeaderFooterwithNavigation = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    btnBack: TSpeedButton;
    ToolBarLabel: TLabel;
    btnNext: TSpeedButton;
    TabControl1: TTabControl;
    tabName: TTabItem;
    tabNumber: TTabItem;
    BottomToolBar: TToolBar;
    lblCopiedName: TLabel;
    edtMyName: TEdit;
    lblNamePrompt: TLabel;
    ATrackBar: TTrackBar;
    lblTrackbarValue: TLabel;
    BindingsList1: TBindingsList;
    LinkControlToPropertyText: TLinkControlToProperty;
    LinkControlToPropertyText2: TLinkControlToProperty;
    tabColors: TTabItem;
    ArcDial: TArcDial;
    spinMargins: TSpinBox;
    cmbColor: TComboColorBox;
    rectBackground: TRectangle;
    lblMargins: TLabel;
    LinkControlToPropertyMarginsBottom: TLinkControlToProperty;
    LinkControlToPropertyMarginsLeft: TLinkControlToProperty;
    LinkControlToPropertyMarginsRight: TLinkControlToProperty;
    LinkControlToPropertyMarginsTop: TLinkControlToProperty;
    LinkControlToPropertyFillColor: TLinkControlToProperty;
    lblColor: TLabel;
    lblRotate: TLabel;
    LinkControlToPropertyRotationAngle: TLinkControlToProperty;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HeaderFooterwithNavigation: THeaderFooterwithNavigation;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure THeaderFooterwithNavigation.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      TCustomAction(Sender).Text := TabControl1.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure THeaderFooterwithNavigation.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
end;

procedure THeaderFooterwithNavigation.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (TabControl1.TabIndex <> 0) then
  begin
    TabControl1.First;
    Key := 0;
  end;
end;

end.
