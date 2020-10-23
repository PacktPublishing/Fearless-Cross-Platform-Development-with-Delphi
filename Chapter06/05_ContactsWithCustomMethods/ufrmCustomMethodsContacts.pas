unit ufrmCustomMethodsContacts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.GenData, Fmx.Bind.GenData,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Controls,
  FMX.EditBox, FMX.NumberBox, FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls,
  FMX.Layouts, Fmx.Bind.Navigator, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.Edit, Data.Bind.ObjectScope, Data.Bind.Grid,
  Fmx.Bind.Grid, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Fearless.Bind,
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
    property ContactBitmap: TBitmap read FContactBitmap write FContactBitmap;
    property ContactName: string read FContactName write FContactName;
    property Title: string read FTitle write FTitle;
    property HireDate: TDate read FHireDate write FHireDate;
    property Salary: Integer read FSalary write FSalary;
    property AvailNow: Boolean read FAvailNow write FAvailNow;
  end;

  TfrmCustomBoundMain = class(TForm)
    EditContactTitle1: TEdit;
    LabelContactTitle1: TLabel;
    NavigatorPrototypeBindSource1: TBindNavigator;
    DateEditDateTimeField1: TDateEdit;
    LabelDateTimeField1: TLabel;
    EditContactName1: TEdit;
    LabelContactName1: TLabel;
    ImageContactBitmap: TImage;
    CheckBoxBoolField1: TCheckBox;
    BindingsList1: TBindingsList;
    PrototypeBindSource1: TPrototypeBindSource;
    LinkPropertyToFieldTitle: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    grdContacts: TGrid;
    LinkGridToDataSourcePrototypeBindSource12: TLinkGridToDataSource;
    Rectangle1: TRectangle;
    lblContactName: TLabel;
    LinkPropertyToFieldContactName: TLinkPropertyToField;
    AdapterBindSource1: TAdapterBindSource;
    LabelSalary: TLabel;
    EditSalary2: TEdit;
    LinkControlToFieldSalary2: TLinkControlToField;
    lblYearsExperience: TLabel;
    LinkPropertyToFieldHireDate: TLinkPropertyToField;
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    FEmployeeList: TObjectList<TEmployee>;
  end;

var
  frmCustomBoundMain: TfrmCustomBoundMain;

implementation

{$R *.fmx}

uses
  System.StrUtils;

{ TfrmCustomBoundMain }

procedure TfrmCustomBoundMain.PrototypeBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  { hard-coded data for quick demonstration purposes }
  FEmployeeList := TObjectList<TEmployee>.Create;

  FEmployeeList.Add(TEmployee.Create('Adam Anderson', 'Manager',  EncodeDate(2012, 1, 1), 50000, True));
  FEmployeeList.Add(TEmployee.Create('George Grossman', 'Driver', EncodeDate(2017, 7, 11), 75000, False));
  FEmployeeList.Add(TEmployee.Create('Brenda Benton', 'Coder',  EncodeDate(2014, 11, 5), 68000, True));
  FEmployeeList.Add(TEmployee.Create('Jack Jackson', 'Janitor',  EncodeDate(2019, 5, 20), 35000, False));
  FEmployeeList.Add(TEmployee.Create('William Werner', 'Manager',  EncodeDate(2012, 2, 2), 82000, False));
  { end hard-coded data creation }

  ABindSourceAdapter := TListBindSourceAdapter<TEmployee>.Create(self, FEmployeeList, True);
end;

{ TEmployee }

constructor TEmployee.Create(const NewName, NewTitle: string;
  const NewHireDate: TDate; const NewSalary: Integer; const NewAvail: Boolean);
var
  NewBitmap: TBitmap;
  ResStream: TResourceStream;
begin
  ResStream := TResourceStream.Create(HINSTANCE, 'Bitmap_' + LeftStr(NewName, Pos(' ', NewName) - 1), RT_RCDATA);
  try
    NewBitmap := TBitmap.Create;
    NewBitmap.LoadFromStream(ResStream);
  finally
    ResStream.Free;
  end;

  FContactName   := NewName;
  FTitle         := NewTitle;
  FContactBitmap := NewBitmap;
  FHireDate      := NewHireDate;
  FSalary        := NewSalary;
  FAvailNow      := NewAvail;
end;

end.
