unit unt.Model.DAO.ViaCep;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, Datasnap.Provider, unt.Helpers.JSON;

type
  TAddress = record
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
const QtdCaracCEP = 8;
var
  vJo: TJSONObject;
begin
  if CEP.Length <> QtdCaracCEP then
    raise Exception.Create('O CEP deve conter 8 números');

  RESTClient.BaseURL := 'https://viacep.com.br/ws/'+CEP+'/json';
  RESTRequest.Execute;
  if RESTResponse.StatusCode = 200 then
  begin
    vJo := RESTResponse.JSONValue as TJSONObject;
    try
      if not vJo.ContainsKey('erro') then
      begin
        Result.cep         := vJo.GetValue('cep'        ).Value;
        Result.logradouro  := vJo.GetValue('logradouro' ).Value;
        Result.complemento := vJo.GetValue('complemento').Value;
        Result.bairro      := vJo.GetValue('bairro'     ).Value;
        Result.localidade  := vJo.GetValue('localidade' ).Value;
        Result.uf          := vJo.GetValue('uf'         ).Value;
        Result.ibge        := vJo.GetValue('ibge'       ).Value;
        Result.gia         := vJo.GetValue('gia'        ).Value;
        Result.ddd         := vJo.GetValue('ddd'        ).Value;
        Result.siafi       := vJo.GetValue('siafi'      ).Value;
      end;
    finally
//      vJo.Free; por estar apenas apontando para o json do objeto RESTReponse
//    não é necessário controlar o uso de memória
    end;
  end;
end;

end.
