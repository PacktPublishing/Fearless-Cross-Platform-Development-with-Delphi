unit ufrmDBHires;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Controls, FMX.Grid.Style, Fmx.Bind.Grid,
  Data.Bind.Grid, FMX.ScrollBox, FMX.Grid, FMX.Objects, FMX.EditBox,
  FMX.NumberBox, FMX.DateTimeCtrls, FMX.Layouts, Fmx.Bind.Navigator,
  Data.Bind.Components, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TfrmDBContacts = class(TForm)
    BindingsList1: TBindingsList;
    FDConnectionEMPLOYEE: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    BindSourceEMPLOYEE: TBindSourceDB;
    FDTableEMPLOYEE: TFDTable;
    EditFIRST_NAME: TEdit;
    LabelFIRST_NAME: TLabel;
    LinkControlToFieldFIRST_NAME: TLinkControlToField;
    NavigatorBindSourceEMPLOYEE: TBindNavigator;
    EditLAST_NAME: TEdit;
    LabelLAST_NAME: TLabel;
    LinkControlToFieldLAST_NAME: TLinkControlToField;
    DateEditHIRE_DATE: TDateEdit;
    LabelHIRE_DATE: TLabel;
    LinkControlToFieldHIRE_DATE: TLinkControlToField;
    EditJOB_CODE: TEdit;
    LabelJOB_CODE: TLabel;
    LinkControlToFieldJOB_CODE: TLinkControlToField;
    boxNameBG: TRectangle;
    GridBindSourceEMPLOYEE: TGrid;
    LinkGridToDataSourceBindSourceEMPLOYEE: TLinkGridToDataSource;
    lblFullName: TLabel;
    LinkPropertyToFieldFULL_NAME: TLinkPropertyToField;
    EditSALARY: TEdit;
    LabelSALARY: TLabel;
    LinkControlToFieldSALARY2: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBContacts: TfrmDBContacts;

implementation

{$R *.fmx}

end.
