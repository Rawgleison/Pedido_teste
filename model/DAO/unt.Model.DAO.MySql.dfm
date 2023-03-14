object dmConnection: TdmConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 212
  Width = 174
  object FDConnection: TFDConnection
    Params.Strings = (
      'Password=root'
      'Server=localhost'
      'User_Name=root'
      'MonitorBy=Remote'
      'Database=database'
      'DriverID=MySQL')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    ConnectedStoredUsage = []
    LoginPrompt = False
    BeforeConnect = FDConnectionBeforeConnect
    Left = 72
    Top = 72
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 72
    Top = 24
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Left = 72
    Top = 128
  end
end
