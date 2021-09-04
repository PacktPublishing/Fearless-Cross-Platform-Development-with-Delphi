unit ufrmAppPaths;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView;

type
  TfrmAppPaths = class(TForm)
    lvPaths: TListView;
    tblPaths: TFDMemTable;
    tblPathsPathName: TStringField;
    tblPathsPathValue: TStringField;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    pnlBottom: TPanel;
    btnInfo: TButton;
    lblTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    procedure CheckYesButton(Sender: TObject; const AResult: TModalResult);
    procedure GotoGitHub;
  end;

var
  frmAppPaths: TfrmAppPaths;

implementation

{$R *.fmx}
{$R *.Macintosh.fmx MACOS}

uses
  uOpenURL,
  FMX.DialogService.Async, System.IOUtils;

procedure TfrmAppPaths.btnInfoClick(Sender: TObject);
begin
  TDialogServiceAsync.MessageDialog('AppPaths - Display the value of several path funtions in Delphi''s TPath class using just ONE code base and compiling to FOUR platforms (Windows, Mac, Android, and iOS).' + sLineBreak + sLineBreak +
                                    'A tutorial app in the book, Fearless Cross-Platform Development with Delphi, by David Cornelius, published by Packt Publishing.  Icon by Icons8, https://icons8.com' + sLineBreak + sLineBreak +
                                    'Would you like to visit the GitHub project site?',
                                    TMsgDlgType.mtInformation,
                                    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbClose],
                                    TMsgDlgBtn.mbClose, 0, CheckYesButton);
end;

procedure TfrmAppPaths.FormCreate(Sender: TObject);
begin
  tblPaths.EmptyDataSet;
  tblPaths.AppendRecord(['Application Name', ParamStr(0)]);
  tblPaths.AppendRecord(['Current directory', GetCurrentDir]);
  tblPaths.AppendRecord(['Temp', TPath.GetTempPath]);
  tblPaths.AppendRecord(['Home', TPath.GetHomePath]);
  tblPaths.AppendRecord(['Documents', TPath.GetDocumentsPath]);
  tblPaths.AppendRecord(['Library', TPath.GetLibraryPath]);
  tblPaths.AppendRecord(['Cache', TPath.GetCachePath]);
  {$IFNDEF IOS}
  tblPaths.AppendRecord(['Shared', TPath.GetSharedDocumentsPath]);
  tblPaths.AppendRecord(['Public', TPath.GetPublicPath]);
  tblPaths.AppendRecord(['Pictures', TPath.GetPicturesPath]);
  tblPaths.AppendRecord(['Shared Pictures', TPath.GetSharedPicturesPath]);
  tblPaths.AppendRecord(['Camera', TPath.GetCameraPath]);
  tblPaths.AppendRecord(['Shared Camera', TPath.GetSharedCameraPath]);
  tblPaths.AppendRecord(['Music', TPath.GetMusicPath]);
  tblPaths.AppendRecord(['Shared Music', TPath.GetSharedMusicPath]);
  tblPaths.AppendRecord(['Movies', TPath.GetMoviesPath]);
  tblPaths.AppendRecord(['SharedMovies', TPath.GetSharedMoviesPath]);
  tblPaths.AppendRecord(['Alarms', TPath.GetAlarmsPath]);
  tblPaths.AppendRecord(['Shared Alarms', TPath.GetSharedAlarmsPath]);
  tblPaths.AppendRecord(['Downloads', TPath.GetSharedAlarmsPath]);
  tblPaths.AppendRecord(['Shared Downloads', TPath.GetSharedDownloadsPath]);
  tblPaths.AppendRecord(['Ringtones', TPath.GetRingtonesPath]);
  tblPaths.AppendRecord(['Shared Ringtones', TPath.GetSharedRingtonesPath]);
  {$ENDIF}
end;

procedure TfrmAppPaths.CheckYesButton(Sender: TObject; const AResult: TModalResult);
begin
  if AResult = mrYes then
    GotoGitHub;
end;

procedure TfrmAppPaths.GotoGitHub;
begin
  tUrlOpen.Open('https://github.com/PacktPublishing/Fearless-Cross-Platform-Development-with-Delphi/tree/master/Chapter15/01_AppPaths');
end;

end.
