object wmMyParks: TwmMyParks
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      Producer = ppMainPage
    end
    item
      Name = 'waiAbout'
      PathInfo = '/about'
      Producer = ppAbout
    end
    item
      Name = 'waiParkList'
      PathInfo = '/parklist'
      Producer = dstpMyParks
    end>
  Height = 230
  Width = 415
  object ppAbout: TPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<body>'
      '<h1>About <#AppName></h1>'
      
        '<p>The <strong><#AppName></strong> app is a simple database of p' +
        'arks, pictures of parks, and coordinates.'
      
        'You build this database yourself and use as reference for places' +
        ' you'#39've visited.</p>'
      
        '<p>Built from the book, <em>Fearless Cross-Platform Development ' +
        'with Delphi</em> by Packt Publishing.</p>'
      '</body>'
      '</html>')
    OnHTMLTag = ppAboutHTMLTag
    Left = 104
    Top = 88
  end
  object ppMainPage: TPageProducer
    HTMLDoc.Strings = (
      '<html><head><title><#AppName></title></head>'
      '<body>'
      '<h1><#AppName></h2>'
      'Links:<br>'
      '<ul>'
      '<li><a href="parklist">List of Parks</a></li>'
      '<li><a href="about">About</a></li>'
      '</ul>'
      '</body>'
      '</html>')
    OnHTMLTag = ppAboutHTMLTag
    Left = 88
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 288
    Top = 160
  end
  object dstpMyParks: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'PARK_ID'
        Title.Align = haRight
        Title.Caption = 'ID'
      end
      item
        FieldName = 'PARK_NAME'
        Title.Align = haLeft
        Title.Caption = 'Name'
      end
      item
        FieldName = 'LONGITUDE'
        Title.Caption = 'Longitude'
      end
      item
        FieldName = 'LATITUDE'
        Title.Caption = 'Latitude'
      end>
    MaxRows = 50
    DataSet = dmParksDB.qryParkList
    TableAttributes.Align = haCenter
    TableAttributes.BgColor = 'Lime'
    TableAttributes.Border = 1
    TableAttributes.CellSpacing = 2
    TableAttributes.CellPadding = 10
    TableAttributes.Width = -1
    Left = 184
    Top = 64
  end
end
