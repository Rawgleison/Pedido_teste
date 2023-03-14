object ViaCEP: TViaCEP
  OldCreateOrder = False
  Height = 283
  Width = 159
  object RESTClient: TRESTClient
    BaseURL = 'https://viacep.com.br/ws/16201371/json'
    Params = <>
    Left = 48
    Top = 16
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    Left = 48
    Top = 64
  end
  object RESTResponse: TRESTResponse
    Left = 48
    Top = 112
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    Dataset = MemTableResp
    FieldDefs = <>
    Response = RESTResponse
    TypesMode = Rich
    Left = 48
    Top = 168
  end
  object MemTableResp: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    Left = 48
    Top = 216
  end
end
