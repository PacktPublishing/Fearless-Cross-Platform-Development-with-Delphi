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
  FMX.ListView;

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
    grdCustomers: TGrid;
    BindingsList: TBindingsList;
    BindSourceCustomers: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lvCustomerDetails: TListView;
    LinkFillControlToField1: TLinkFillControlToField;
    StyleBookEmerald: TStyleBook;
    BindSourceSales: TBindSourceDB;
    grdSales: TGrid;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  end;

var
  frmMobileSalesSQLite: TfrmMobileSalesSQLite;

implementation

{$R *.fmx}

uses
  udmSQLiteSales;

procedure TfrmMobileSalesSQLite.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  tabCtrlMobileSales.ActiveTab := tabSales;
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

