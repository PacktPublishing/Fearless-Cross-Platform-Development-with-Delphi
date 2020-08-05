object frmRttiMain: TfrmRttiMain
  Left = 0
  Top = 0
  Caption = 'RTTI Explorer'
  ClientHeight = 467
  ClientWidth = 562
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 470
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClick = ComponentClick
  DesignSize = (
    562
    467)
  PixelsPerInch = 96
  TextHeight = 13
  object lbRttiInfo: TListBox
    Left = 0
    Top = 33
    Width = 313
    Height = 434
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnClick = ComponentClick
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 33
    Align = alTop
    Caption = 'Click on various controls to view RTTI details.'
    TabOrder = 1
    OnClick = ComponentClick
    ExplicitWidth = 482
  end
  object grpSample: TGroupBox
    Left = 328
    Top = 39
    Width = 226
    Height = 130
    Anchors = [akTop, akRight]
    Caption = 'Sample Group Box'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    OnClick = ComponentClick
    ExplicitLeft = 240
    object lblEditLabel: TLabel
      Left = 24
      Top = 24
      Width = 124
      Height = 13
      Caption = 'Label for the TEdit control'
      FocusControl = edtEditSample
      OnClick = ComponentClick
    end
    object edtEditSample: TEdit
      Left = 24
      Top = 43
      Width = 169
      Height = 21
      MaxLength = 50
      TabOrder = 0
      TextHint = 'TEdit'
      OnClick = ComponentClick
    end
    object edtLabeledEditSample: TLabeledEdit
      Left = 24
      Top = 96
      Width = 169
      Height = 21
      EditLabel.Width = 140
      EditLabel.Height = 13
      EditLabel.Caption = 'Labeled Edit has its own label'
      MaxLength = 100
      TabOrder = 1
      OnClick = ComponentClick
    end
  end
  object radColors: TRadioGroup
    Left = 328
    Top = 175
    Width = 226
    Height = 98
    Anchors = [akTop, akRight]
    Caption = 'Colors'
    Color = clBtnFace
    Columns = 2
    Items.Strings = (
      'White'
      'Silver'
      'Red'
      'Green'
      'Blue'
      'Black')
    ParentColor = False
    TabOrder = 3
    OnClick = ComponentClick
    ExplicitLeft = 240
  end
  object tbSample: TTrackBar
    Left = 319
    Top = 279
    Width = 235
    Height = 45
    Anchors = [akTop, akRight]
    TabOrder = 4
    OnChange = ComponentClick
  end
  object cbCheckSample: TCheckBox
    Left = 328
    Top = 360
    Width = 75
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Enable OK'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = cbCheckSampleClick
    ExplicitLeft = 240
  end
  object btnOK: TButton
    Left = 328
    Top = 383
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    TabOrder = 6
    OnClick = ComponentClick
    ExplicitLeft = 240
  end
end
