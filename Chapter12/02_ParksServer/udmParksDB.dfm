object dmParksDB: TdmParksDB
  OldCreateOrder = False
  Height = 240
  Width = 337
  object FDParkConnection: TFDConnection
    Params.Strings = (
      'Server=192.168.1.15'
      'Port=3051'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=s:\databases\MyParks.ib'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 80
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
    Left = 120
    Top = 144
    ParamData = <
      item
        Name = 'LONG'
        DataType = ftSingle
        ParamType = ptInput
        Value = -122.796997070313s
      end
      item
        Name = 'LAT'
        DataType = ftSingle
        ParamType = ptInput
        Value = 45.5900001525879s
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
