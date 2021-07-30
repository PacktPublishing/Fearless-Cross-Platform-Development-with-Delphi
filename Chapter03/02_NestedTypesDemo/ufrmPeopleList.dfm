object frmPeopleList: TfrmPeopleList
  Left = 0
  Top = 0
  Caption = 'People List'
  ClientHeight = 340
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    515
    340)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 307
    Top = 16
    Width = 38
    Height = 16
    Alignment = taRightJustify
    Caption = 'Name:'
  end
  object Label2: TLabel
    Left = 269
    Top = 38
    Width = 76
    Height = 16
    Alignment = taRightJustify
    Caption = 'Date of Birth:'
  end
  object lblPersonName: TLabel
    Left = 351
    Top = 16
    Width = 4
    Height = 16
  end
  object lblPersonDOB: TLabel
    Left = 351
    Top = 38
    Width = 4
    Height = 16
  end
  object lbPeople: TListBox
    Left = 8
    Top = 8
    Width = 241
    Height = 324
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    OnClick = lbPeopleClick
  end
  object grpNewPerson: TGroupBox
    Left = 271
    Top = 95
    Width = 218
    Height = 237
    Caption = 'New Person'
    TabOrder = 1
    object Label3: TLabel
      Left = 19
      Top = 134
      Width = 76
      Height = 16
      Caption = 'Date of Birth:'
    end
    object edtNewPersonFirstName: TLabeledEdit
      Left = 19
      Top = 56
      Width = 172
      Height = 24
      EditLabel.Width = 96
      EditLabel.Height = 16
      EditLabel.Caption = 'New First Name:'
      MaxLength = 40
      TabOrder = 0
    end
    object edtNewPersonLastName: TLabeledEdit
      Left = 19
      Top = 104
      Width = 172
      Height = 24
      EditLabel.Width = 94
      EditLabel.Height = 16
      EditLabel.Caption = 'New Last Name:'
      MaxLength = 40
      TabOrder = 1
    end
    object edtNewDOB: TDateTimePicker
      Left = 19
      Top = 156
      Width = 116
      Height = 24
      Date = 44045.000000000000000000
      Format = 'yyyy-MM-dd'
      Time = 0.815059305554314100
      TabOrder = 2
    end
    object btnAdd: TButton
      Left = 19
      Top = 192
      Width = 75
      Height = 25
      Caption = '&Add'
      TabOrder = 3
      OnClick = btnAddClick
    end
  end
end
