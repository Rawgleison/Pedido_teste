object ViaCEP: TViaCEP
  OldCreateOrder = False
  Height = 177
  Width = 125
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
end
