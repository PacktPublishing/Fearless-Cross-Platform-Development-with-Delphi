unit ufrmMobileSalesMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox, FMX.Grid,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Edit, FMX.Objects, FMX.DateTimeCtrls;

type
  TfrmMobileSalesSQLite = class(TForm)
    tabCtrlMobileSales: TTabControl;
    tabCustomers: TTabItem;
    tabCtrlSales: TTabControl;
    tabSalesList: TTabItem;
    tbCustomers: TToolBar;
    lblTitle1: TLabel;
    btnNext: TSpeedButton;
    tabSalesDetails: TTabItem;
    ToolBar2: TToolBar;
    lblTitle2: TLabel;
    btnBack: TSpeedButton;
    tabSales: TTabItem;
    ToolBar3: TToolBar;
    lblTitle3: TLabel;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    BindingsList: TBindingsList;
    BindSourceCustomers: TBindSourceDB;
    StyleBookEmerald: TStyleBook;
    BindSourceSales: TBindSourceDB;
    DateEditInvoiceDate: TDateEdit;
    LabelInvoiceDate: TLabel;
    LinkControlToFieldInvoiceDate: TLinkControlToField;
    BindSourceInvoiceCustomer: TBindSourceDB;
    EditFirstName: TEdit;
    LabelFirstName: TLabel;
    LinkControlToFieldFirstName: TLinkControlToField;
    EditLastName: TEdit;
    LabelLastName: TLabel;
    LinkControlToFieldLastName: TLinkControlToField;
    EditPhone: TEdit;
    LabelPhone: TLabel;
    LinkControlToFieldPhone: TLinkControlToField;
    EditCompany: TEdit;
    LabelCompany: TLabel;
    LinkControlToFieldCompany: TLinkControlToField;
    EditEmail: TEdit;
    LabelEmail: TLabel;
    LinkControlToFieldEmail: TLinkControlToField;
    EditAddress: TEdit;
    LabelAddress: TLabel;
    LinkControlToFieldAddress: TLinkControlToField;
    EditCity: TEdit;
    LabelCity: TLabel;
    LinkControlToFieldCity: TLinkControlToField;
    EditState: TEdit;
    LabelState: TLabel;
    LinkControlToFieldState: TLinkControlToField;
    EditPostalCode: TEdit;
    LabelPostalCode: TLabel;
    LinkControlToFieldPostalCode: TLinkControlToField;
    EditCountry: TEdit;
    LabelCountry: TLabel;
    LinkControlToFieldCountry: TLinkControlToField;
    EditInvoiceId: TEdit;
    LabelInvoiceId: TLabel;
    LinkControlToFieldInvoiceId2: TLinkControlToField;
    StringGridBindSourceCustomers: TStringGrid;
    LinkGridToDataSourceBindSourceCustomers2: TLinkGridToDataSource;
    lblTransState: TLabel;
    edtFirstName: TEdit;
    Label1: TLabel;
    edtLastName: TEdit;
    Label2: TLabel;
    LinkControlToFieldFirstName2: TLinkControlToField;
    LinkControlToFieldLastName2: TLinkControlToField;
    StringGridBindSourceSales: TStringGrid;
    LinkGridToDataSourceBindSourceSales: TLinkGridToDataSource;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  end;

var
  frmMobileSalesSQLite: TfrmMobileSalesSQLite;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone4in.fmx IOS}
{$R *.iPad.fmx IOS}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.Macintosh.fmx MACOS}
{$R *.iPhone47in.fmx IOS}
{$R *.SmXhdpiPh.fmx ANDROID}

uses
  udmSQLiteSales;

procedure TfrmMobileSalesSQLite.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabCtrlMobileSales.ActiveTab := tabSales;
  tabCtrlSales.ActiveTab := tabSalesList;
end;

procedure TfrmMobileSalesSQLite.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if tabCtrlMobileSales.ActiveTab <> tabCustomers then
    begin
      tabCtrlMobileSales.Previous;
      Key := 0;
    end;
  end;
end;

procedure TfrmMobileSalesSQLite.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if tabCtrlMobileSales.ActiveTab <> tabCustomers then
          tabCtrlMobileSales.ActiveTab := tabCustomers;
        Handled := True;
      end;

    sgiRight:
      begin
        if tabCtrlMobileSales.ActiveTab <> tabSales then
          tabCtrlMobileSales.ActiveTab := tabCustomers;
        Handled := True;
      end;
  end;
end;

end.

