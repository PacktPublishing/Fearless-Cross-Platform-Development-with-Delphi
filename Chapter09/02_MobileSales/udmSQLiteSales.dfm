object dmSQLiteSales: TdmSQLiteSales
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 240
  Width = 344
  object FDConnSQLite: TFDConnection
    Params.Strings = (
      
        'Database=V:\FearlessCrossPlatformDev\Chapter09\database\chinook.' +
        'db'
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
    Left = 240
    Top = 168
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
  object qryInvoiceCustomer: TFDQuery
    Active = True
    MasterSource = srcInvoices
    MasterFields = 'CustomerId'
    DetailFields = 'CustomerId'
    Connection = FDConnSQLite
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT * FROM customers'
      'WHERE CustomerId = :CustomerId')
    Left = 160
    Top = 88
    ParamData = <
      item
        Name = 'CUSTOMERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end>
    object qryInvoiceCustomerCustomerId: TFDAutoIncField
      FieldName = 'CustomerId'
      Origin = 'CustomerId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryInvoiceCustomerFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Required = True
      Size = 40
    end
    object qryInvoiceCustomerLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Required = True
    end
    object qryInvoiceCustomerCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'Company'
      Size = 80
    end
    object qryInvoiceCustomerAddress: TWideStringField
      FieldName = 'Address'
      Origin = 'Address'
      Size = 70
    end
    object qryInvoiceCustomerCity: TWideStringField
      FieldName = 'City'
      Origin = 'City'
      Size = 40
    end
    object qryInvoiceCustomerState: TWideStringField
      FieldName = 'State'
      Origin = 'State'
      Size = 40
    end
    object qryInvoiceCustomerCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'Country'
      Size = 40
    end
    object qryInvoiceCustomerPostalCode: TWideStringField
      FieldName = 'PostalCode'
      Origin = 'PostalCode'
      Size = 10
    end
    object qryInvoiceCustomerPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'Phone'
      Size = 24
    end
    object qryInvoiceCustomerFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'Fax'
      Size = 24
    end
    object qryInvoiceCustomerEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Required = True
      Size = 60
    end
    object qryInvoiceCustomerSupportRepId: TIntegerField
      FieldName = 'SupportRepId'
      Origin = 'SupportRepId'
    end
  end
  object srcInvoices: TDataSource
    DataSet = tblInvoices
    Left = 232
    Top = 48
  end
end
