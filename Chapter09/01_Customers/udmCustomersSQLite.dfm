object dmCustomersSQLite: TdmCustomersSQLite
  OldCreateOrder = False
  Height = 290
  Width = 404
  object FDConnSQLite: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\David Cornelius\dev\Fearless-Cross-Platform-De' +
        'velopment-with-Delphi\Chapter09\01_Customers\database\chinook.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 112
    Top = 104
  end
  object tblCustomers: TFDTable
    Active = True
    IndexFieldNames = 'CustomerId'
    Connection = FDConnSQLite
    UpdateOptions.UpdateTableName = 'customers'
    TableName = 'customers'
    Left = 224
    Top = 152
  end
end
