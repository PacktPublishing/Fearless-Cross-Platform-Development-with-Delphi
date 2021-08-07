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
  FMX.Memo, FMX.Maps, FMX.EditBox, FMX.NumberBox, REST.Backend.ServiceTypes, System.JSON,
  REST.Backend.EMSServices, Data.Bind.ObjectScope, REST.Client, REST.Backend.EndPoint, REST.Backend.EMSProvider,
  REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  FireDAC.DApt, REST.Backend.EMSFireDAC, FMX.Grid.Style, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Grid,
  FireDAC.Stan.StorageBin;

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
    btnTakePic: TButton;
    btnLoadPic: TButton;
    TakePhotoFromLibraryAction: TTakePhotoFromLibraryAction;
    actTakeParkPic: TAction;
    actLoadParkPic: TAction;
    btnShare: TButton;
    actShareParkInfo: TAction;
    btnSchedule: TButton;
    actScheduleParkVisits: TAction;
    imlMyParks: TImageList;
    imgParkPic: TImage;
    TakePhotoFromCameraAction: TTakePhotoFromCameraAction;
    LinkControlToField3: TLinkControlToField;
    tabctrlParkEdit: TTabControl;
    FlowLayoutParkEdit: TFlowLayout;
    CheckBoxHasPlaygound: TCheckBox;
    LinkControlToField7: TLinkControlToField;
    edtParkNameEdit: TEdit;
    LinkControlToField1: TLinkControlToField;
    actSaveParkLocation: TAction;
    LocationSensor: TLocationSensor;
    btnSaveParkLocation: TButton;
    actMapPark: TAction;
    Button1: TButton;
    tabParkMap: TTabItem;
    Panel1: TPanel;
    Button2: TButton;
    lblParkMapName: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    cmbMapType: TComboBox;
    MapViewParks: TMapView;
    ShowShareSheetAction: TShowShareSheetAction;
    btnSharePic: TButton;
    tabctrlLocalRemoteParks: TTabControl;
    tabLocalParks: TTabItem;
    tabRemote: TTabItem;
    actGetRADServerParksRESTClient: TAction;
    pnlRADRefresh: TPanel;
    btnRefreshRADServer: TButton;
    radParksAZ: TRadioButton;
    radParksZA: TRadioButton;
    RESTReqRADParks: TRESTRequest;
    RESTRespRADParks: TRESTResponse;
    RESTClientRADParks: TRESTClient;
    lvRADParks: TListView;
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
    procedure actSaveParkLocationExecute(Sender: TObject);
    procedure LocationSensorLocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure actMapParkExecute(Sender: TObject);
    procedure cmbMapTypeChange(Sender: TObject);
    procedure ShowShareSheetActionBeforeExecute(Sender: TObject);
    procedure actGetRADServerParksRESTClientExecute(Sender: TObject);
    procedure lvRADParksItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    FParkLongitude: Double;
    FParkLatitude : Double;
    procedure AddRADParkToLocal;
    function  PromptAddPark: Boolean;
    procedure ShowRADServerParks;
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
{$R *.iPad.fmx IOS}

uses
  System.Threading,
  FMX.Platform, FMX.MediaLibrary, FMX.DialogService.Async,
  udmParkData;

procedure TfrmMyParksMain.FormCreate(Sender: TObject);
begin
  tabCtrlParks.TabPosition := TTabPosition.None;
  tabCtrlParks.ActiveTab := tabParkList;

  actTakeParkPic.Enabled      := TPlatformServices.Current.SupportsPlatformService(IFMXCameraService);
  actSaveParkLocation.Enabled := TPlatformServices.Current.SupportsPlatformService(IFMXMapService);
  actMapPark.Enabled          := TPlatformServices.Current.SupportsPlatformService(IFMXMapService);

  {$IFDEF ANDROID}
  cmbMapType.Items.Add('Terrain');
  {$ENDIF}
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

procedure TfrmMyParksMain.actGetRADServerParksRESTClientExecute(Sender: TObject);
begin
  RESTReqRADParks.Params.Clear;

  // add AppID header
  RESTReqRADParks.Params.AddItem('X-Embarcadero-Application-Id', 'MyParks1234', TRESTRequestParameterKind.pkHTTPHEADER);

  // add sorting
  if radParksAZ.IsChecked then
    RESTReqRADParks.Params.AddItem('sfPARK_NAME', 'A', TRESTRequestParameterKind.pkQUERY)
  else
    RESTReqRADParks.Params.AddItem('sfPARK_NAME', 'D', TRESTRequestParameterKind.pkQUERY);

  RESTReqRADParks.Execute;

  ShowRADServerParks;
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

procedure TfrmMyParksMain.actMapParkExecute(Sender: TObject);
begin
  if dmParkData.tblParksLocX.IsNull or dmParkData.tblParksLocY.IsNull then
    TDialogServiceAsync.ShowMessage('There are no coordinates saved for this park.')
  else begin
    var SavedLocation: TMapCoordinate;
    SavedLocation.Latitude := dmParkData.tblParksLocX.AsFloat;
    SavedLocation.Longitude := dmParkData.tblParksLocY.AsFloat;
    MapViewParks.Location := SavedLocation;

    var ParkMarker: TMapMarkerDescriptor;
    ParkMarker := TMapMarkerDescriptor.Create(SavedLocation, dmParkData.tblParksParkName.AsString);
    ParkMarker.Draggable := True;
    ParkMarker.Visible := True;
    MapViewParks.AddMarker(ParkMarker);

    NextParkTabAction.Execute;
  end;
end;

procedure TfrmMyParksMain.actSaveParkLocationExecute(Sender: TObject);
begin
  dmParkData.tblParks.Edit;
  dmParkData.tblParksLocX.AsFloat := FParkLatitude;
  dmParkData.tblParksLocY.AsFloat := FParkLongitude;
  dmParkData.tblParks.Post;

  TDialogServiceAsync.ShowMessage(Format('The park''s location (%0.3f, %0.3f) has been saved.',
                                         [FParkLatitude, FParkLongitude]));
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

procedure TfrmMyParksMain.AddRADParkToLocal;
begin
  { TODO : add selected park to local database }
end;

procedure TfrmMyParksMain.cmbMapTypeChange(Sender: TObject);
begin
  case cmbMapType.ItemIndex of
    0: MapViewParks.MapType := TMapType.Normal;
    1: MapViewParks.MapType := TMapType.Satellite;
    2: MapViewParks.MapType := TMapType.Hybrid;
    3: MapViewParks.MapType := TMapType.Terrain;
  end;
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
const
  PermissionAccessFineLocation = 'android.permission.ACCESS_FINE_LOCATION';
begin
  NextParkTabAction.Execute;

  PermissionsService.RequestPermissions([PermissionAccessFineLocation],
    procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
        LocationSensor.Active := True
      else
        TDialogServiceAsync.ShowMessage('Park location data will not be available.');
    end);
end;

procedure TfrmMyParksMain.lvParksPullRefresh(Sender: TObject);
begin
  dmParkData.tblParks.Close;
  dmParkData.tblParks.Open;
end;

procedure TfrmMyParksMain.lvRADParksItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if PromptAddPark then
    AddRADParkToLocal;
end;

function TfrmMyParksMain.PromptAddPark: Boolean;
begin
  { TODO : prompt user to add to local park }

  Result := False;
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

procedure TfrmMyParksMain.LocationSensorLocationChanged(Sender: TObject;
               const OldLocation, NewLocation: TLocationCoord2D);
begin
  FParkLongitude := NewLocation.Longitude;
  FParkLatitude  := NewLocation.Latitude;
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

procedure TfrmMyParksMain.ShowRADServerParks;
var
  RADParksArray: TJSONArray;
  lvParkItem: TListViewItem;
begin
  if RESTRespRADParks.Status.SuccessOK_200 then begin
    lvRADParks.Items.Clear;

    RADParksArray := RESTRespRADParks.JSONValue.Clone as TJSONArray;
    try
      if RADParksArray.Count > 0 then begin
        for var i := 0 to RADParksArray.Count - 1 do begin
          lvParkItem := lvRADParks.Items.Add;
          lvParkItem.Text := RADParksArray.Items[i].GetValue<string>('PARK_NAME');
        end;
      end else begin
        lvParkItem := lvRADParks.Items.Add;
        lvParkItem.Text := 'No parks found.';
      end;
    finally
      RADParksArray.Free;
    end;
  end else
    TDialogServiceAsync.ShowMessage('Could not get the parks from the server: ' + RESTRespRADParks.StatusText);
end;

procedure TfrmMyParksMain.ShowShareSheetActionBeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction.Bitmap := imgParkPic.Bitmap;

  ShowShareSheetAction.TextMessage := Format('%s (%0.5f, %0.5f)',
                       [dmParkData.tblParksParkName.AsString,
                        dmParkData.tblParksLocX.AsFloat,
                        dmParkData.tblParksLocX.AsFloat]);
end;

procedure TfrmMyParksMain.TakePhotoFromCameraActionDidFinishTaking(Image: TBitmap);
begin
  imgParkPic.Bitmap.Assign(Image);
  SaveImageToDatabase;
end;

end.
