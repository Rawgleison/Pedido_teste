unit Model.DAO.ViaCEP;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Json, System.JSON, Datasnap.Provider;

type
  TAddress = class
    cep: string;
    logradouro: string;
    complemento: string;
    bairro: string;
    localidade: string;
    uf: string;
    ibge: string;
    gia: string;
    ddd: string;
    siafi: string;
  end;
  
  TViaCEP = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    MemTableResp: TFDMemTable;
  public
    function GetAddress(CEP: String):TAddress;
  end;

var
  ViaCEP: TViaCEP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TViaCEP.GetAddress(CEP: String): TAddress;
begin
  RESTClient.BaseURL := 'https://viacep.com.br/ws/'+CEP+'/json';
  RESTRequest.Execute;
  if RESTResponse.Status.SuccessOK_200 then
    MemTableResp.Open;
end;

end.
