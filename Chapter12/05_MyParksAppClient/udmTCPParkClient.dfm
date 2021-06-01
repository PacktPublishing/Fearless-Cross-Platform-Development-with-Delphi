object dmTCPParkClient: TdmTCPParkClient
  OldCreateOrder = False
  Height = 150
  Width = 215
  object IdTCPMyParksClient: TIdTCPClient
    OnStatus = IdTCPMyParksClientStatus
    OnDisconnected = IdTCPMyParksClientDisconnected
    OnConnected = IdTCPMyParksClientConnected
    ConnectTimeout = 0
    Port = 0
    ReadTimeout = -1
    Left = 80
    Top = 48
  end
end
