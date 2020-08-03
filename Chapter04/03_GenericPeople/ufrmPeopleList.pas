unit ufrmPeopleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, System.Generics.Defaults;

type
  TfrmPeopleList = class(TForm)
    lbPeople: TListBox;
    grpNewPerson: TGroupBox;
    edtNewPersonFirstName: TLabeledEdit;
    edtNewPersonLastName: TLabeledEdit;
    Label3: TLabel;
    edtNewDOB: TDateTimePicker;
    btnAdd: TButton;
    cmbPersonSort: TComboBox;
    Label1: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbPersonSortChange(Sender: TObject);
  private
    type
      TPerson = class
      private
        FFirstName: string;
        FLastName: string;
        FDateOfBirth: TDate;
      public
        constructor Create(const NewFN, NewLN: string; const NewDOB: TDate);
        function Age: Integer;
        property FirstName: string read FFirstName write FFirstName;
        property LastName: string read FLastName write FLastName;
        property DateOfBirth: TDate read FDateOfBirth write FDateOfBirth;
      end;
      TLastNameComparer = class(TComparer<TPerson>)
        function Compare(const Left, Right: TPerson): Integer; override;
      end;
      TFirstNameComparer = class(TComparer<TPerson>)
        function Compare(const Left, Right: TPerson): Integer; override;
      end;
      TBirthDateNameComparer = class(TComparer<TPerson>)
        function Compare(const Left, Right: TPerson): Integer; override;
      end;
    var
      FPeopleList: TList<TPerson>;
    procedure AddPersonToList(ANewPerson: TPerson);
    procedure ListSortedPeople(const Comparer: IComparer<TPerson>);
    procedure ListPeople;
  end;

var
  frmPeopleList: TfrmPeopleList;

implementation

{$R *.dfm}

uses
  System.DateUtils;

{ TfrmPeopleList.TLastNameComparer }

function TfrmPeopleList.TLastNameComparer.Compare(const Left, Right: TPerson): Integer;
begin
  Result := CompareText(Left.LastName, Right.LastName);
end;

{ TfrmPeopleList.TFirstNameComparer }

function TfrmPeopleList.TFirstNameComparer.Compare(const Left, Right: TPerson): Integer;
begin
  Result := CompareText(Left.FirstName, Right.FirstName);
end;

{ TfrmPeopleList.TBirthDateNameComparer }

function TfrmPeopleList.TBirthDateNameComparer.Compare(const Left, Right: TPerson): Integer;
begin
  Result := CompareDate(Left.DateOfBirth, Right.DateOfBirth);
end;

{ TfrmPeopleList.TPerson }

procedure TfrmPeopleList.FormCreate(Sender: TObject);
begin
  FPeopleList := TList<TPerson>.Create;

  // starter data
  FPeopleList.Add(TPerson.Create('Bob', 'Brothers', EncodeDate(1945, 7, 15)));
  FPeopleList.Add(TPerson.Create('Sally', 'Sampson', EncodeDate(1977, 3, 20)));
  FPeopleList.Add(TPerson.Create('Fred', 'Thimsfrabble', EncodeDate(1990, 8, 3)));
  FPeopleList.Add(TPerson.Create('Zeek', 'Anderson', EncodeDate(1960, 11, 19)));
  FPeopleList.Add(TPerson.Create('Alfred', 'Wilson', EncodeDate(1985, 9, 5)));

  ListPeople;
end;

procedure TfrmPeopleList.FormDestroy(Sender: TObject);
begin
  FPeopleList.Free;
end;

function TfrmPeopleList.TPerson.Age: Integer;
begin
  Result := YearsBetween(Date, FDateOfBirth);
end;

constructor TfrmPeopleList.TPerson.Create(const NewFN, NewLN: string; const NewDOB: TDate);
begin
  FFirstName := NewFN;
  FLastName  := NewLN;
  FDateOfBirth := NewDOB;
end;

procedure TfrmPeopleList.AddPersonToList(ANewPerson: TPerson);
begin
  FPeopleList.Add(ANewPerson);
end;

procedure TfrmPeopleList.ListSortedPeople(const Comparer: IComparer<TPerson>);
var
  APerson: TPerson;
  SortedList: TList<TPerson>;
begin
  SortedList := TList<TPerson>.Create(Comparer);

  lbPeople.Items.Clear;
  for APerson in FPeopleList do
    SortedList.Add(APerson);

  SortedList.Sort;
  for APerson in SortedList do
    lbPeople.Items.Add(Format('%s %s, Age: %d',
               [APerson.FirstName, APerson.LastName, APerson.Age]));
end;

procedure TfrmPeopleList.ListPeople;
begin
  case cmbPersonSort.ItemIndex of
    0: ListSortedPeople(TFirstNameComparer.Create);
    1: ListSortedPeople(TLastNameComparer.Create);
    2: ListSortedPeople(TBirthDateNameComparer.Create);
  end;
end;

procedure TfrmPeopleList.btnAddClick(Sender: TObject);
var
  NewPerson: TPerson;
begin
  if (Length(edtNewPersonFirstName.Text) > 0) and
     (Length(edtNewPersonLastName.Text) > 0) then begin
    NewPerson := TPerson.Create(edtNewPersonFirstName.Text,
                                edtNewPersonLastName.Text,
                                edtNewDOB.Date);
    AddPersonToList(NewPerson);
    ListPeople;

    edtNewPersonFirstName.Text := EmptyStr;
    edtNewPersonLastName.Text  := EmptyStr;
  end else
    ShowMessage('Please fill in both names.');
end;

procedure TfrmPeopleList.cmbPersonSortChange(Sender: TObject);
begin
  ListPeople;
end;

end.
