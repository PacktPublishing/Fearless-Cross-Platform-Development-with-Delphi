unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzBckgnd, RzStatus;

type
  TfrmVCLApp = class(TForm)
    RzBackground1: TRzBackground;
    RzClockStatus1: TRzClockStatus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVCLApp: TfrmVCLApp;

implementation

{$R *.dfm}

end.
