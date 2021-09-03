object dmInterbaseSales: TdmInterbaseSales
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 244
  Width = 345
  object FDConnectionIB: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = FDConnectionIBBeforeConnect
    Left = 64
    Top = 40
  end
  object tblSales: TFDTable
    IndexFieldNames = 'PO_NUMBER'
    Connection = FDConnectionIB
    UpdateOptions.UpdateTableName = 'SALES'
    TableName = 'SALES'
    Left = 184
    Top = 32
    object tblSalesPO_NUMBER: TStringField
      FieldName = 'PO_NUMBER'
      Origin = 'PO_NUMBER'
      Required = True
      FixedChar = True
      Size = 8
    end
    object tblSalesCUST_NO: TIntegerField
      FieldName = 'CUST_NO'
      Origin = 'CUST_NO'
      Required = True
    end
    object tblSalesSALES_REP: TSmallintField
      FieldName = 'SALES_REP'
      Origin = 'SALES_REP'
    end
    object tblSalesORDER_STATUS: TStringField
      FieldName = 'ORDER_STATUS'
      Origin = 'ORDER_STATUS'
      Required = True
      Size = 7
    end
    object tblSalesORDER_DATE: TSQLTimeStampField
      FieldName = 'ORDER_DATE'
      Origin = 'ORDER_DATE'
      Required = True
    end
    object tblSalesSHIP_DATE: TSQLTimeStampField
      FieldName = 'SHIP_DATE'
      Origin = 'SHIP_DATE'
    end
    object tblSalesDATE_NEEDED: TSQLTimeStampField
      FieldName = 'DATE_NEEDED'
      Origin = 'DATE_NEEDED'
    end
    object tblSalesPAID: TStringField
      FieldName = 'PAID'
      Origin = 'PAID'
      FixedChar = True
      Size = 1
    end
    object tblSalesQTY_ORDERED: TIntegerField
      FieldName = 'QTY_ORDERED'
      Origin = 'QTY_ORDERED'
      Required = True
    end
    object tblSalesTOTAL_VALUE: TCurrencyField
      FieldName = 'TOTAL_VALUE'
      Origin = 'TOTAL_VALUE'
      Required = True
    end
    object tblSalesDISCOUNT: TSingleField
      FieldName = 'DISCOUNT'
      Origin = 'DISCOUNT'
      Required = True
    end
    object tblSalesITEM_TYPE: TStringField
      FieldName = 'ITEM_TYPE'
      Origin = 'ITEM_TYPE'
      Required = True
      Size = 12
    end
    object tblSalesAGED: TFMTBCDField
      FieldName = 'AGED'
      Origin = 'AGED'
      Precision = 18
      Size = 9
    end
  end
  object qrySaleCustomers: TFDQuery
    MasterSource = srcSales
    MasterFields = 'CUST_NO'
    DetailFields = 'CUST_NO'
    Connection = FDConnectionIB
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT c.*'
      'FROM CUSTOMER c'
      'WHERE CUST_NO = :CUST_NO')
    Left = 184
    Top = 104
    ParamData = <
      item
        Name = 'CUST_NO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1004
      end>
  end
  object srcSales: TDataSource
    DataSet = tblSales
    Left = 232
    Top = 48
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 64
    Top = 96
  end
  object tblCustomers: TFDTable
    IndexFieldNames = 'CUST_NO'
    Connection = FDConnectionIB
    UpdateOptions.UpdateTableName = 'CUSTOMER'
    TableName = 'CUSTOMER'
    Left = 184
    Top = 176
    object tblCustomersCUST_NO: TIntegerField
      FieldName = 'CUST_NO'
      Origin = 'CUST_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblCustomersCUSTOMER: TStringField
      FieldName = 'CUSTOMER'
      Origin = 'CUSTOMER'
      Required = True
      Size = 25
    end
    object tblCustomersCONTACT_FIRST: TStringField
      FieldName = 'CONTACT_FIRST'
      Origin = 'CONTACT_FIRST'
      Size = 15
    end
    object tblCustomersCONTACT_LAST: TStringField
      FieldName = 'CONTACT_LAST'
      Origin = 'CONTACT_LAST'
    end
    object tblCustomersPHONE_NO: TStringField
      FieldName = 'PHONE_NO'
      Origin = 'PHONE_NO'
    end
    object tblCustomersADDRESS_LINE1: TStringField
      FieldName = 'ADDRESS_LINE1'
      Origin = 'ADDRESS_LINE1'
      Size = 30
    end
    object tblCustomersADDRESS_LINE2: TStringField
      FieldName = 'ADDRESS_LINE2'
      Origin = 'ADDRESS_LINE2'
      Size = 30
    end
    object tblCustomersCITY: TStringField
      FieldName = 'CITY'
      Origin = 'CITY'
      Size = 25
    end
    object tblCustomersSTATE_PROVINCE: TStringField
      FieldName = 'STATE_PROVINCE'
      Origin = 'STATE_PROVINCE'
      Size = 15
    end
    object tblCustomersCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Origin = 'COUNTRY'
      Size = 15
    end
    object tblCustomersPOSTAL_CODE: TStringField
      FieldName = 'POSTAL_CODE'
      Origin = 'POSTAL_CODE'
      Size = 12
    end
    object tblCustomersON_HOLD: TStringField
      FieldName = 'ON_HOLD'
      Origin = 'ON_HOLD'
      FixedChar = True
      Size = 1
    end
  end
end
