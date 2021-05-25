object MyParksIBService: TMyParksIBService
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'MyParks InterBase Lookup Service'
  AfterInstall = ServiceAfterInstall
  AfterUninstall = ServiceAfterUninstall
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
