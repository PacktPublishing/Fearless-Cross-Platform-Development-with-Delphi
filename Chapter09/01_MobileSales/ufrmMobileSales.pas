unit ufrmMobileSales;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, System.Rtti, FMX.Grid.Style,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, FMX.ScrollBox,
  FMX.Grid, Data.Bind.DBScope, FMX.Edit, FMX.DateTimeCtrls;

type
  TfrmMobileSalesIB = class(TForm)
    tabCtrlMobileSalesIB: TTabControl;
    tabSales: TTabItem;
    tabCtrlSales: TTabControl;
    tabSalesList: TTabItem;
    ToolBar1: TToolBar;
    lblSales: TLabel;
    btnNext: TSpeedButton;
    tabSaleDetails: TTabItem;
    ToolBar2: TToolBar;
    lblTitle2: TLabel;
    btnBack: TSpeedButton;
    tabCustomers: TTabItem;
    ToolBar3: TToolBar;
    lblCustomers: TLabel;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    grdSales: TStringGrid;
    BindingsList: TBindingsList;
    StyleBookWedgewoodLight: TStyleBook;
    BindSourceSaleCustomer: TBindSourceDB;
    EditORDER_STATUS: TEdit;
    LabelORDER_STATUS: TLabel;
    DateEditSHIP_DATE: TDateEdit;
    LabelSHIP_DATE: TLabel;
    CheckBoxPAID: TCheckBox;
    LabelPAID: TLabel;
    BindSourceSales: TBindSourceDB;
    LinkGridToDataSourceBindSourceSales: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    EditPO_NUMBER: TEdit;
    LabelPO_NUMBER: TLabel;
    LinkControlToFieldPO_NUMBER2: TLinkControlToField;
    EditCUSTOMER: TEdit;
    LabelCUSTOMER: TLabel;
    LinkControlToFieldCUSTOMER: TLinkControlToField;
    EditCONTACT_FIRST: TEdit;
    LabelCONTACT_FIRST: TLabel;
    LinkControlToFieldCONTACT_FIRST: TLinkControlToField;
    EditCONTACT_LAST: TEdit;
    LabelCONTACT_LAST: TLabel;
    LinkControlToFieldCONTACT_LAST: TLinkControlToField;
    EditPHONE_NO: TEdit;
    LabelPHONE_NO: TLabel;
    LinkControlToFieldPHONE_NO: TLinkControlToField;
    EditADDRESS_LINE1: TEdit;
    LabelADDRESS_LINE1: TLabel;
    LinkControlToFieldADDRESS_LINE1: TLinkControlToField;
    EditADDRESS_LINE2: TEdit;
    LinkControlToFieldADDRESS_LINE2: TLinkControlToField;
    EditCITY: TEdit;
    LabelCITY: TLabel;
    LinkControlToFieldCITY: TLinkControlToField;
    EditSTATE_PROVINCE: TEdit;
    LabelSTATE_PROVINCE: TLabel;
    LinkControlToFieldSTATE_PROVINCE: TLinkControlToField;
    EditPOSTAL_CODE: TEdit;
    LabelPOSTAL_CODE: TLabel;
    LinkControlToFieldPOSTAL_CODE: TLinkControlToField;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMobileSalesIB: TfrmMobileSalesIB;

implementation

{$R *.fmx}

uses udmInterBaseSales;

procedure TfrmMobileSalesIB.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabCtrlMobileSalesIB.ActiveTab := tabSales;
end;

procedure TfrmMobileSalesIB.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if (tabCtrlMobileSalesIB.ActiveTab = tabSales) and (tabCtrlSales.ActiveTab = tabSaleDetails) then
    begin
      tabCtrlSales.Previous;
      Key := 0;
    end;
  end;
end;

procedure TfrmMobileSalesIB.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if tabCtrlMobileSalesIB.ActiveTab <> tabCtrlMobileSalesIB.Tabs[tabCtrlMobileSalesIB.TabCount - 1] then
          tabCtrlMobileSalesIB.ActiveTab := tabCtrlMobileSalesIB.Tabs[tabCtrlSales.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if tabCtrlMobileSalesIB.ActiveTab <> tabCtrlMobileSalesIB.Tabs[0] then
          tabCtrlMobileSalesIB.ActiveTab := tabCtrlMobileSalesIB.Tabs[tabCtrlMobileSalesIB.TabIndex - 1];
        Handled := True;
      end;
  end;
end;

end.

