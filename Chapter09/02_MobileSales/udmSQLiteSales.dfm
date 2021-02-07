object dmSQLiteSales: TdmSQLiteSales
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 240
  Width = 344
  object FDConnSQLite: TFDConnection
    Params.Strings = (
      
        'Database=V:\Fearless-Cross-Platform-Development-with-Delphi\Chap' +
        'ter09\database\chinook.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 56
  end
  object tblCustomers: TFDTable
    IndexFieldNames = 'CustomerId'
    Connection = FDConnSQLite
    UpdateOptions.UpdateTableName = 'customers'
    TableName = 'customers'
    Left = 160
    Top = 104
  end
  object qrySales: TFDQuery
    Connection = FDConnSQLite
    SQL.Strings = (
      
        'select i.InvoiceId, i.CustomerId, c.LastName, c.FirstName, i.Inv' +
        'oiceDate, i.BillingCountry, i.Total'
      'from invoices i, customers c'
      'where c.CustomerId = i.CustomerId'
      'order by i.InvoiceDate desc')
    Left = 160
    Top = 160
  end
  object tblInvoices: TFDTable
    Active = True
    IndexFieldNames = 'InvoiceId'
    Connection = FDConnSQLite
    UpdateOptions.UpdateTableName = 'invoices'
    TableName = 'invoices'
    Left = 160
    Top = 32
    object tblInvoicesInvoiceId: TFDAutoIncField
      FieldName = 'InvoiceId'
      Origin = 'InvoiceId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tblInvoicesCustomerId: TIntegerField
      FieldName = 'CustomerId'
      Origin = 'CustomerId'
      Required = True
    end
    object tblInvoicesInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
      Origin = 'InvoiceDate'
      Required = True
    end
    object tblInvoicesBillingAddress: TWideStringField
      FieldName = 'BillingAddress'
      Origin = 'BillingAddress'
      Size = 70
    end
    object tblInvoicesBillingCity: TWideStringField
      FieldName = 'BillingCity'
      Origin = 'BillingCity'
      Size = 40
    end
    object tblInvoicesBillingState: TWideStringField
      FieldName = 'BillingState'
      Origin = 'BillingState'
      Size = 40
    end
    object tblInvoicesBillingCountry: TWideStringField
      FieldName = 'BillingCountry'
      Origin = 'BillingCountry'
      Size = 40
    end
    object tblInvoicesBillingPostalCode: TWideStringField
      FieldName = 'BillingPostalCode'
      Origin = 'BillingPostalCode'
      Size = 10
    end
    object tblInvoicesTotal: TBCDField
      FieldName = 'Total'
      Origin = 'Total'
      Required = True
      Precision = 10
      Size = 2
    end
  end
  object FDQuery1: TFDQuery
    Connection = FDConnSQLite
    Left = 224
    Top = 48
  end
end
