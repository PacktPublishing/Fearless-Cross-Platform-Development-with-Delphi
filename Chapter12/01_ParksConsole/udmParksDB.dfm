object dmParksDB: TdmParksDB
  OldCreateOrder = False
  Height = 240
  Width = 337
  object FDParkConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = FDParkConnectionBeforeConnect
    Left = 144
    Top = 72
  end
  object qryParkLookup: TFDQuery
    Connection = FDParkConnection
    SQL.Strings = (
      'select PARK_ID, PARK_NAME, LONGITUDE, LATITUDE'
      'from Parks'
      
        '  where :long between (LONGITUDE - 0.002) and (LONGITUDE + 0.002' +
        ')'
      '    and :lat  between (LATITUDE  - 0.002) and (LATITUDE + 0.002)'
      '')
    Left = 144
    Top = 128
    ParamData = <
      item
        Name = 'LONG'
        DataType = ftSingle
        ParamType = ptInput
        Value = -122.796997070312500000
      end
      item
        Name = 'LAT'
        DataType = ftSingle
        ParamType = ptInput
        Value = 45.590000152587890000
      end>
    object qryParkLookupPARK_ID: TIntegerField
      FieldName = 'PARK_ID'
      Origin = 'PARK_ID'
    end
    object qryParkLookupPARK_NAME: TStringField
      FieldName = 'PARK_NAME'
      Origin = 'PARK_NAME'
      Required = True
      Size = 50
    end
    object qryParkLookupLONGITUDE: TFMTBCDField
      FieldName = 'LONGITUDE'
      Origin = 'LONGITUDE'
      Precision = 9
      Size = 6
    end
    object qryParkLookupLATITUDE: TFMTBCDField
      FieldName = 'LATITUDE'
      Origin = 'LATITUDE'
      Precision = 9
      Size = 6
    end
  end
  object FDPhysIBDriverLink: TFDPhysIBDriverLink
    Left = 56
    Top = 40
  end
end
