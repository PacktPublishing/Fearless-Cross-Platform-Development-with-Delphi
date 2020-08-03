unit ufrmPeopleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmPeopleList = class(TForm)
    lbPeople: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    lblPersonName: TLabel;
    lblPersonDOB: TLabel;
    grpNewPerson: TGroupBox;
    edtNewPersonFirstName: TLabeledEdit;
    edtNewPersonLastName: TLabeledEdit;
    Label3: TLabel;
    edtNewDOB: TDateTimePicker;
    btnAdd: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure lbPeopleClick(Sender: TObject);
  private
    type
      TPerson = class
      private
        FFirstName: string;
        FLastName: string;
        FDateOfBirth: TDate;
      public
        constructor Create(const NewFirstName, NewLastName: string; const NewDOB: TDate);
        function Age: Integer;
        property FirstName: string read FFirstName write FFirstName;
        property LastName: string read FLastName write FLastName;
        property DateOfBirth: TDate read FDateOfBirth write FDateOfBirth;
      end;
    procedure AddPersonToList(ANewPerson: TPerson);
  end;

var
  frmPeopleList: TfrmPeopleList;

implementation

{$R *.dfm}

uses
  System.DateUtils;

{ TfrmPeopleList.TPerson }

function TfrmPeopleList.TPerson.Age: Integer;
begin
  Result := YearOf(Date) - YearOf(FDateOfBirth);
end;

constructor TfrmPeopleList.TPerson.Create(
            const NewFirstName, NewLastName: string; const NewDOB: TDate);
begin
  FFirstName := NewFirstName;
  FLastName  := NewLastName;
  FDateOfBirth := NewDOB;
end;

procedure TfrmPeopleList.AddPersonToList(ANewPerson: TPerson);
begin
  lbPeople.Items.AddObject(
        Format('%s %s, Age: %d',
               [ANewPerson.FirstName, ANewPerson.LastName, ANewPerson.Age]),
        ANewPerson);
  lbPeople.ItemIndex := lbPeople.Items.Count - 1;
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

    edtNewPersonFirstName.Text := EmptyStr;
    edtNewPersonLastName.Text  := EmptyStr;
  end else
    ShowMessage('Please fill in both names.');
end;

procedure TfrmPeopleList.lbPeopleClick(Sender: TObject);
var
  ClickedPerson: TPerson;
begin
  if lbPeople.ItemIndex > -1 then begin
    ClickedPerson := lbPeople.Items.Objects[lbPeople.ItemIndex] as TPerson;
    lblPersonName.Caption := ClickedPerson.FirstName + ' ' + ClickedPerson.LastName;
    lblPersonDOB.Caption  := FormatDateTime('yyyy-mm-dd', ClickedPerson.DateOfBirth);
  end;
end;

end.
