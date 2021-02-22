object dmParkData: TdmParkData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 254
  Width = 321
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 96
  end
  object FDConn: TFDConnection
    Params.Strings = (
      
        'Database=V:\Fearless-Cross-Platform-Development-with-Delphi\Chap' +
        'ter10\01_MyParks\MyParks.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object tblParks: TFDTable
    IndexFieldNames = 'ID'
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
    object tblParksHasRestrooms: TBooleanField
      FieldName = 'HasRestrooms'
      Origin = 'HasRestrooms'
    end
    object tblParksNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'Notes'
      BlobType = ftWideMemo
    end
  end
end
