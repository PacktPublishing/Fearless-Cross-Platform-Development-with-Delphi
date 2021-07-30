object frmLongProcessMain: TfrmLongProcessMain
  Left = 0
  Top = 0
  Caption = 'Process Main'
  ClientHeight = 361
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    384
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 1
    OnClick = btnStopClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 342
    Width = 384
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 184
    ExplicitTop = 152
    ExplicitWidth = 0
  end
  object lbRandNums: TListBox
    Left = 8
    Top = 39
    Width = 368
    Height = 280
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = 3
    ItemHeight = 13
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 325
    Width = 384
    Height = 17
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = 40
    ExplicitTop = 319
    ExplicitWidth = 150
  end
  object tmrStatusUpdater: TTimer
    Enabled = False
    OnTimer = tmrStatusUpdaterTimer
    Left = 168
    Top = 152
  end
end
