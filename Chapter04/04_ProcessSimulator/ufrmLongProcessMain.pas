unit ufrmLongProcessMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmLongProcessMain = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    StatusBar: TStatusBar;
    lbRandNums: TListBox;
    tmrStatusUpdater: TTimer;
    ProgressBar: TProgressBar;
    procedure btnStartClick(Sender: TObject);
    procedure tmrStatusUpdaterTimer(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FCount: Integer;
    FMaxCount: Integer;
    type
      TProcessThread = class(TThread)
      private
        procedure ShowRandNum(RandNum: Double);
      public
        constructor Create;
        procedure Execute; override;
        procedure UpdateStatus(const Count, MaxCount: Integer);
      end;
    var
      FProcess: TProcessThread;
    procedure StartProcess;
    procedure StopProcess(Sender: TObject);
    procedure UpdateStatus;
  public
    property Count: Integer read FCount write FCount;
    property MaxCount: Integer read FMaxCount write FMaxCount;
    procedure ShowNumber(const ANum: Double);
  end;

var
  frmLongProcessMain: TfrmLongProcessMain;


implementation

{$R *.dfm}

procedure TfrmLongProcessMain.btnStartClick(Sender: TObject);
begin
  StartProcess;
end;

procedure TfrmLongProcessMain.btnStopClick(Sender: TObject);
begin
  FProcess.Terminate;
end;

procedure TfrmLongProcessMain.ShowNumber(const ANum: Double);
begin
  Inc(FCount);
  lbRandNums.Items.Add(FloatToStr(ANum));
  lbRandNums.ItemIndex := lbRandNums.Items.Count - 1;
end;

procedure TfrmLongProcessMain.StartProcess;
begin
  FProcess := TProcessThread.Create;
  FProcess.FreeOnTerminate := True;
  FProcess.OnTerminate := StopProcess;
  FProcess.Start;

  btnStart.Enabled := False;
  btnStop.Enabled := True;

  tmrStatusUpdater.Enabled := True;
end;

procedure TfrmLongProcessMain.StopProcess(Sender: TObject);
begin
  tmrStatusUpdater.Enabled := False;

  FProcess.Terminate;

  btnStop.Enabled := False;
  btnStart.Enabled := True;
  ProgressBar.Position := 0;
end;

procedure TfrmLongProcessMain.tmrStatusUpdaterTimer(Sender: TObject);
begin
  UpdateStatus;
end;

procedure TfrmLongProcessMain.UpdateStatus;
begin
  StatusBar.SimpleText := 'Random numbers generated: ' + IntToStr(FCount) + '/' + IntToStr(FMaxCount);

  ProgressBar.Position := FCount;
  ProgressBar.Max := FMaxCount;
end;

{ TfrmLongProcessMain.TProcessThread }

constructor TfrmLongProcessMain.TProcessThread.Create;
begin
  inherited Create(True);
end;

procedure TfrmLongProcessMain.TProcessThread.Execute;
const
  MAX_COUNT = 100;
var
  Count: Integer;
begin
  Count := 0;
  repeat
    Inc(Count);
    ShowRandNum(Random);
    Sleep(100 + Random(300));
    UpdateStatus(Count, MAX_COUNT);
  until (Count > MAX_COUNT) or Terminated;
end;

procedure TfrmLongProcessMain.TProcessThread.ShowRandNum(RandNum: Double);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      frmLongProcessMain.ShowNumber(RandNum);
    end);
end;

procedure TfrmLongProcessMain.TProcessThread.UpdateStatus(const Count, MaxCount: Integer);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      frmLongProcessMain.Count := Count;
      frmLongProcessMain.MaxCount := MaxCount;
    end);
end;

end.
