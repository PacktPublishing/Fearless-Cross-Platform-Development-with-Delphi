object dmInterbaseSales: TdmInterbaseSales
  OldCreateOrder = False
  Height = 244
  Width = 345
  object FDConnectionIB: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Public\Documents\Embarcadero\Studio\21.0\Sampl' +
        'es\Data\EMPLOYEE.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object tblSales: TFDTable
    Active = True
    IndexFieldNames = 'PO_NUMBER'
    Connection = FDConnectionIB
    UpdateOptions.UpdateTableName = 'SALES'
    TableName = 'SALES'
    Left = 184
    Top = 32
  end
end
