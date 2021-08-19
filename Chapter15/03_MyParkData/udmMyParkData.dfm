object dmMyParksData: TdmMyParksData
  OldCreateOrder = False
  Height = 276
  Width = 395
  object FDParkCn: TFDConnection
    Params.Strings = (
      'Protocol=TCPIP'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = FDParkCnBeforeConnect
    Left = 104
    Top = 56
  end
  object FDPhysIBDriverLink: TFDPhysIBDriverLink
    Left = 64
    Top = 128
  end
  object qryMyParksData: TFDQuery
    Connection = FDParkCn
    SQL.Strings = (
      'SELECT * FROM PARKS'
      '{IF &SORT} ORDER BY &SORT {FI}')
    Left = 184
    Top = 72
    MacroData = <
      item
        Value = Null
        Name = 'SORT'
        DataType = mdIdentifier
      end>
  end
  object EMSDataSetResource: TEMSDataSetResource
    AllowedActions = [List, Get]
    DataSet = qryMyParksData
    KeyFields = 'PARK_ID'
    ValueFields = 'PARK_ID;PARK_NAME;LATITUDE;LONGITUDE'
    PageSize = 3
    Left = 232
    Top = 152
  end
end
