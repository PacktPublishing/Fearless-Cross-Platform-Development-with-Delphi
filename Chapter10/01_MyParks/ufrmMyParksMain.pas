unit ufrmMyParksMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ListBox, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.AddressBook.Types, FMX.AddressBook,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView,
  FMX.Edit, System.ImageList, FMX.ImgList;

type
  TfrmMyParksMain = class(TForm)
    HeaderToolBar: TToolBar;
    lblMain: TLabel;
    GestureManagerParks: TGestureManager;
    aclMyParks: TActionList;
    TakePhotoFromCameraAction: TTakePhotoFromCameraAction;
    StyleBookEmeraldCrystal: TStyleBook;
    pnlParksButtons: TPanel;
    btnParksAdd: TButton;
    lvParks: TListView;
    BindingsListParks: TBindingsList;
    BindSourceParks: TBindSourceDB;
    LinkListControlToFieldParkName: TLinkListControlToField;
    tabCtrlParks: TTabControl;
    tabParkList: TTabItem;
    tabParkEdit: TTabItem;
    actAddPark: TAction;
    FlowLayoutParkEdit: TFlowLayout;
    CheckBoxHasRestrooms: TCheckBox;
    btnParkEditBack: TButton;
    LinkControlToField4: TLinkControlToField;
    actDeletePark: TAction;
    CheckBoxHasPlaygound: TCheckBox;
    pnlParkNameEdit: TPanel;
    EditParkName: TEdit;
    LabelParkName: TLabel;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    NextParkTabAction: TNextTabAction;
    ParkEditDoneTabAction: TPreviousTabAction;
    tbBottom: TToolBar;
    btnDeletePark: TButton;
    tabParkCalendar: TTabItem;
    btnTakePic: TButton;
    btnLoadPic: TButton;
    TakePhotoFromLibraryAction: TTakePhotoFromLibraryAction;
    actTakeParkPic: TAction;
    actLoadParkPic: TAction;
    btnNotes: TButton;
    actEditParkNotes: TAction;
    btnShare: TButton;
    actShareParkInfo: TAction;
    btnSchedule: TButton;
    actScheduleParkVisits: TAction;
    imlMyParks: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure lvParksItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure actAddParkExecute(Sender: TObject);
    procedure lvParksPullRefresh(Sender: TObject);
    procedure actDeleteParkExecute(Sender: TObject);
    procedure actTakeParkPicExecute(Sender: TObject);
    procedure actLoadParkPicExecute(Sender: TObject);
    procedure actShareParkInfoExecute(Sender: TObject);
    procedure actEditParkNotesExecute(Sender: TObject);
    procedure actScheduleParkVisitsExecute(Sender: TObject);
  end;

var
  frmMyParksMain: TfrmMyParksMain;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone47in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

uses
  FMX.Platform, FMX.PhoneDialer, FMX.Maps, FMX.MediaLibrary, FMX.DialogService.Async,
  System.Permissions, udmParkData;

procedure TfrmMyParksMain.FormCreate(Sender: TObject);
begin
  tabCtrlParks.ActiveTab := tabParkList;
end;

procedure TfrmMyParksMain.actAddParkExecute(Sender: TObject);
begin
  dmParkData.tblParks.Insert;
  NextParkTabAction.Execute;
end;

procedure TfrmMyParksMain.actDeleteParkExecute(Sender: TObject);
begin
  TdialogServiceAsync.MessageDialog('Are you sure you want to delete this park?', TMsgDlgType.mtWarning,
             [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
    procedure (const AResult: TModalResult)
    begin
      if AResult = mrYes then begin
        dmParkData.tblParks.Delete;
        ParkEditDoneTabAction.Execute;
      end;
    end);
end;

procedure TfrmMyParksMain.actEditParkNotesExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('edit park notes');
end;

procedure TfrmMyParksMain.actLoadParkPicExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('load pic');
end;

procedure TfrmMyParksMain.actScheduleParkVisitsExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('schedule park visits and see history');
end;

procedure TfrmMyParksMain.actShareParkInfoExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('share park info');
end;

procedure TfrmMyParksMain.actTakeParkPicExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('take pic');
end;

procedure TfrmMyParksMain.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if tabCtrlParks.ActiveTab <> tabCtrlParks.Tabs[tabCtrlParks.TabCount-1] then
        tabCtrlParks.ActiveTab := tabCtrlParks.Tabs[tabCtrlParks.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if tabCtrlParks.ActiveTab <> tabCtrlParks.Tabs[0] then
        tabCtrlParks.ActiveTab := tabCtrlParks.Tabs[tabCtrlParks.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

procedure TfrmMyParksMain.lvParksItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  NextParkTabAction.Execute;
end;

procedure TfrmMyParksMain.lvParksPullRefresh(Sender: TObject);
begin
  dmParkData.tblParks.Close;
  dmParkData.tblParks.Open;
end;

end.
