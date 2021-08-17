object dmParksDB: TdmParksDB
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 240
  Width = 337
  object FDParkConnection: TFDConnection
    Params.Strings = (
      'Server=127.0.0.1'
      'Port=3050'
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=C:\Users\David Cornelius\dev\Fearless-Cross-Platform-De' +
        'velopment-with-Delphi\data\MYPARKS.IB'
      'Protocol=TCPIP'
      'DriverID=IB')
    ResourceOptions.AssignedValues = [rvStoreItems]
    LoginPrompt = False
    Left = 128
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
  object qryParkList: TFDQuery
    Connection = FDParkConnection
    SQL.Strings = (
      'SELECT PARK_ID, PARK_NAME, LONGITUDE, LATITUDE '
      'FROM Parks '
      'ORDER BY PARK_NAME')
    Left = 216
    Top = 112
    object qryParkListPARK_ID: TIntegerField
      FieldName = 'PARK_ID'
      Origin = 'PARK_ID'
    end
    object qryParkListPARK_NAME: TStringField
      FieldName = 'PARK_NAME'
      Origin = 'PARK_NAME'
      Required = True
      Size = 50
    end
    object qryParkListLONGITUDE: TFMTBCDField
      FieldName = 'LONGITUDE'
      Origin = 'LONGITUDE'
      Precision = 9
      Size = 6
    end
    object qryParkListLATITUDE: TFMTBCDField
      FieldName = 'LATITUDE'
      Origin = 'LATITUDE'
      Precision = 9
      Size = 6
    end
  end
end
