unit ufrmPrototypedHires;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.GenData, Fmx.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Controls,
  FMX.EditBox, FMX.NumberBox, FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls,
  FMX.Layouts, Fmx.Bind.Navigator, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.ObjectScope, Data.Bind.Grid,
  Fmx.Bind.Grid, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid,
  Generics.Collections;

type
  TEmployee = class
  private
    FContactBitmap: TBitmap;
    FContactName: string;
    FTitle: string;
    FHireDate: TDate;
    FSalary: Integer;
    FAvailNow: Boolean;
  public
    constructor Create(const NewName: string;
                       const NewTitle: string;
                       const NewHireDate: TDate;
                       const NewSalary: Integer;
                       const NewAvail: Boolean);
  published
    property ContactBitmap: TBitmap read FContactBitmap write FContactBitmap;
    property ContactName: string read FContactName write FContactName;
    property Title: string read FTitle write FTitle;
    property HireDate: TDate read FHireDate write FHireDate;
    property Salary: Integer read FSalary write FSalary;
    property AvailNow: Boolean read FAvailNow write FAvailNow;
  end;

  TForm1 = class(TForm)
    EditContactTitle1: TEdit;
    LabelContactTitle1: TLabel;
    NavigatorPrototypeBindSource1: TBindNavigator;
    DateEditDateTimeField1: TDateEdit;
    LabelDateTimeField1: TLabel;
    EditContactName1: TEdit;
    LabelContactName1: TLabel;
    ImageContactBitmap1: TImage;
    CheckBoxBoolField1: TCheckBox;
    NumberBoxIntField1: TNumberBox;
    LabelIntField1: TLabel;
    BindingsList1: TBindingsList;
    PrototypeBindSource1: TPrototypeBindSource;
    LinkPropertyToFieldTitle: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    GridPrototypeBindSource1: TGrid;
    LinkGridToDataSourcePrototypeBindSource12: TLinkGridToDataSource;
    Rectangle1: TRectangle;
    lblContactName: TLabel;
    LinkPropertyToFieldContactName: TLinkPropertyToField;
    AdapterBindSource1: TAdapterBindSource;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
  private
    FEmployeeList: TObjectList<TEmployee>;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TEmployee }

constructor TEmployee.Create(const NewName: string; const NewTitle: string;
                       const NewHireDate: TDate; const NewSalary: Integer;
                       const NewAvail: Boolean);
begin
  FContactName := NewName;
  FTitle       := NewTitle;
  FHireDate    := NewHireDate;
  FSalary      := NewSalary;
  FAvailNow    := NewAvail;
end;

{ TForm1 }

constructor TForm1.Create(AOwner: TComponent);
begin
  FEmployeeList := TObjectList<TEmployee>.Create;

  FEmployeeList.Add(TEmployee.Create('Adam', 'Manager', EncodeDate(2012, 1, 1), 50000, True));
  FEmployeeList.Add(TEmployee.Create('George', 'Driver', EncodeDate(2017, 7, 11), 75000, False));
  FEmployeeList.Add(TEmployee.Create('Brenda', 'Coder', EncodeDate(2014, 11, 5), 68000, True));
  FEmployeeList.Add(TEmployee.Create('Jack', 'Janitor', EncodeDate(2019, 5, 20), 35000, False));

  inherited;
end;

procedure TForm1.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TListBindSourceAdapter<TEmployee>.Create(self, FEmployeeList, True);
end;

end.
