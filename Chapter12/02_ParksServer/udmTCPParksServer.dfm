object dmTCPParksServer: TdmTCPParksServer
  OldCreateOrder = False
  Height = 198
  Width = 255
  object IdTCPMyParksServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 8081
    OnConnect = IdTCPMyParksServerConnect
    OnDisconnect = IdTCPMyParksServerDisconnect
    OnException = IdTCPMyParksServerException
    OnExecute = IdTCPMyParksServerExecute
    Left = 88
    Top = 56
  end
end
