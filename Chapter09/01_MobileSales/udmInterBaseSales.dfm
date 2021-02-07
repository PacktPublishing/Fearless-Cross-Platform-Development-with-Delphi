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
    Active = True
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
end
