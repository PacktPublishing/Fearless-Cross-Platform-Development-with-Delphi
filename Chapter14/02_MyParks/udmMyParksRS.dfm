object MyParksResource1: TMyParksResource1
  OldCreateOrder = False
  Height = 266
  Width = 422
  object FDMyParksConn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Port=3050'
      'DriverID=IB')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object qryParkList: TFDQuery
    Connection = FDMyParksConn
    SQL.Strings = (
      'SELECT PARK_ID, PARK_NAME '
      'FROM Parks'
      'ORDER BY PARK_NAME')
    Left = 160
    Top = 32
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
  end
  object FDPhysIBDriverLink: TFDPhysIBDriverLink
    Left = 56
    Top = 72
  end
  object qryParkByID: TFDQuery
    Connection = FDMyParksConn
    SQL.Strings = (
      'SELECT * FROM Parks'
      'WHERE PARK_ID = :ID')
    Left = 160
    Top = 88
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 123
      end>
  end
end
