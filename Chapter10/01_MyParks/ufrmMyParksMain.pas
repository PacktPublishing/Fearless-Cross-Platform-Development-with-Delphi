unit ufrmMyParksMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ListBox, System.Actions, FMX.ActnList, FMX.StdActns, System.Permissions,
  FMX.MediaLibrary.Actions, FMX.AddressBook.Types, FMX.AddressBook,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.ListView,
  FMX.Edit, System.ImageList, FMX.ImgList, FMX.Objects, FMX.Media,
  System.Sensors, System.Sensors.Components, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

type
  TfrmMyParksMain = class(TForm)
    HeaderToolBar: TToolBar;
    lblMain: TLabel;
    GestureManagerParks: TGestureManager;
    aclMyParks: TActionList;
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
    btnParkEditBack: TButton;
    actDeletePark: TAction;
    pnlParkNameEdit: TPanel;
    LabelParkName: TLabel;
    NextParkTabAction: TNextTabAction;
    ParkEditDoneTabAction: TPreviousTabAction;
    tbBottom: TToolBar;
    btnDeletePark: TButton;
    tabParkVisits: TTabItem;
    btnTakePic: TButton;
    btnLoadPic: TButton;
    TakePhotoFromLibraryAction: TTakePhotoFromLibraryAction;
    actTakeParkPic: TAction;
    actLoadParkPic: TAction;
    btnNotes: TButton;
    btnShare: TButton;
    actShareParkInfo: TAction;
    btnSchedule: TButton;
    actScheduleParkVisits: TAction;
    imlMyParks: TImageList;
    imgParkPic: TImage;
    TakePhotoFromCameraAction: TTakePhotoFromCameraAction;
    LinkControlToField3: TLinkControlToField;
    mmoParkNotes: TMemo;
    LinkControlToField5: TLinkControlToField;
    tabctrlParkEdit: TTabControl;
    FlowLayoutParkEdit: TFlowLayout;
    CheckBoxHasRestrooms: TCheckBox;
    CheckBoxHasPlaygound: TCheckBox;
    tabParkEditMain: TTabItem;
    tabParkEditNotes: TTabItem;
    NextParkEditTabAction: TNextTabAction;
    ParkNotesDoneTabAction: TPreviousTabAction;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    pnlParkNotes: TPanel;
    btnParkNotesBack: TButton;
    lblParkNotesName: TLabel;
    edtParkNameEdit: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    btnLocation: TButton;
    actParkLocation: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure lvParksItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure actAddParkExecute(Sender: TObject);
    procedure lvParksPullRefresh(Sender: TObject);
    procedure actDeleteParkExecute(Sender: TObject);
    procedure actTakeParkPicExecute(Sender: TObject);
    procedure actLoadParkPicExecute(Sender: TObject);
    procedure actShareParkInfoExecute(Sender: TObject);
    procedure actScheduleParkVisitsExecute(Sender: TObject);
    procedure TakePhotoFromCameraActionDidFinishTaking(Image: TBitmap);
    procedure NextParkTabActionUpdate(Sender: TObject);
    procedure actParkLocationExecute(Sender: TObject);
  private
    procedure LoadImageFromDatabase;
    procedure SaveImageToDatabase;
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
  FMX.Platform, FMX.MediaLibrary, FMX.DialogService.Async,
  udmParkData;

procedure TfrmMyParksMain.FormCreate(Sender: TObject);
begin
  tabCtrlParks.ActiveTab := tabParkList;

  actTakeParkPic.Enabled := TPlatformServices.Current.SupportsPlatformService(IFMXCameraService);
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

procedure TfrmMyParksMain.actLoadParkPicExecute(Sender: TObject);
begin
  PermissionsService.RequestPermissions(['android.permission.READ_EXTERNAL_STORAGE'],
    procedure (const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
        TakePhotoFromLibraryAction.Execute
      else
        TDialogServiceAsync.ShowMessage('Cannot take load pictures because access to storage was denied.');
    end);
end;

procedure TfrmMyParksMain.actParkLocationExecute(Sender: TObject);
begin
  // location
end;

procedure TfrmMyParksMain.actScheduleParkVisitsExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('calendar pic');
end;

procedure TfrmMyParksMain.actShareParkInfoExecute(Sender: TObject);
begin
  TDialogServiceAsync.ShowMessage('share park info');
end;

procedure TfrmMyParksMain.actTakeParkPicExecute(Sender: TObject);
begin
  PermissionsService.RequestPermissions(['android.permission.CAMERA', 'android.permission.WRITE_EXTERNAL_STORAGE'],
    procedure (const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 2) and
         (AGrantResults[0] = TPermissionStatus.Granted) and (AGrantResults[1] = TPermissionStatus.Granted) then
        TakePhotoFromCameraAction.Execute
      else
        TDialogServiceAsync.ShowMessage('Cannot take park pictures because the camera and storage were denied access.');
    end);
end;

procedure TfrmMyParksMain.FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
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

procedure TfrmMyParksMain.NextParkTabActionUpdate(Sender: TObject);
begin
  tabctrlParkEdit.ActiveTab := tabParkEditMain;
end;

procedure TfrmMyParksMain.LoadImageFromDatabase;
var
  PicStream: TMemoryStream;
begin
  PicStream := TMemoryStream.Create;
  try
    dmParkData.tblParksMainPic.SaveToStream(PicStream);
    PicStream.Position := 0;
    imgParkPic.Bitmap.LoadFromStream(PicStream);
  finally
    PicStream.Free;
  end;
end;

procedure TfrmMyParksMain.SaveImageToDatabase;
var
  PicStream: TMemoryStream;
begin
  PicStream := TMemoryStream.Create;
  try
    imgParkPic.Bitmap.SaveToStream(PicStream);
    PicStream.Position := 0;

    dmParkData.tblParks.Edit;
    dmParkData.tblParksMainPic.LoadFromStream(PicStream);
    dmParkData.tblParks.Post;
  finally
    PicStream.Free;
  end;
end;

procedure TfrmMyParksMain.TakePhotoFromCameraActionDidFinishTaking(Image: TBitmap);
begin
  imgParkPic.Bitmap.Assign(Image);
  SaveImageToDatabase;
end;

end.
