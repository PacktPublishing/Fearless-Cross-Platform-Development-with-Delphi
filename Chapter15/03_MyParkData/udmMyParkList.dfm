object dmMyParksList: TdmMyParksList
  OldCreateOrder = False
  Height = 276
  Width = 395
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Port=050'
      'SEPassword=myparks R s3cur3!'
      'DriverID=IB')
    LoginPrompt = False
    Left = 104
    Top = 56
  end
  object FDPhysIBDriverLink: TFDPhysIBDriverLink
    Left = 64
    Top = 128
  end
  object qryMyParksData: TFDQuery
    Connection = FDConnection
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
