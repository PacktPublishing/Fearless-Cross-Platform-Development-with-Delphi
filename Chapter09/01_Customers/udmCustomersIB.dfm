object dmCustomersIB: TdmCustomersIB
  OldCreateOrder = False
  Height = 291
  Width = 422
  object FDConnIB: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\David Cornelius\dev\Fearless-Cross-Platform-De' +
        'velopment-with-Delphi\Chapter09\01_Customers\database\EMPLOYEE.G' +
        'DB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 80
  end
  object tblCustomers: TFDTable
    Connection = FDConnIB
    UpdateOptions.UpdateTableName = 'CUSTOMER'
    TableName = 'CUSTOMER'
    Left = 152
    Top = 56
  end
end
