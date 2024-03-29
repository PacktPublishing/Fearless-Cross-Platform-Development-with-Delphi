object dmParkData: TdmParkData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 200
  Width = 252
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 96
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object tblParks: TFDTable
    OnCalcFields = tblParksCalcFields
    IndexFieldNames = 'ParkName'
    Connection = FDConn
    UpdateOptions.UpdateTableName = 'Parks'
    TableName = 'Parks'
    Left = 136
    Top = 48
    object tblParksID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tblParksParkName: TWideStringField
      FieldName = 'ParkName'
      Origin = 'ParkName'
      Required = True
      Size = 50
    end
    object tblParksLocX: TFloatField
      FieldName = 'LocX'
      Origin = 'LocX'
    end
    object tblParksLocY: TFloatField
      FieldName = 'LocY'
      Origin = 'LocY'
    end
    object tblParksMainPic: TBlobField
      FieldName = 'MainPic'
      Origin = 'MainPic'
    end
    object tblParksHasPlaygound: TBooleanField
      FieldName = 'HasPlaygound'
      Origin = 'HasPlaygound'
    end
    object tblParksCoordinates: TStringField
      FieldKind = fkCalculated
      FieldName = 'Coordinates'
      Size = 30
      Calculated = True
    end
  end
end
