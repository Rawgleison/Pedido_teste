unit unt.Model.Provider.Cliente;

interface

Uses
  System.SysUtils, System.Variants, System.Classes,
  Data.DB, unt.Model.DTO.Cliente, unt.Model.Provider.Interfaces;

Type
  TClienteProvider = class(TInterfacedObject, IClientePrvider)
  private
    { private declarations }
  public
    { public declarations }
    function InsertOrUpdate(pCliente: TClienteDTO): Integer;
    function GetAll: TDataSet;
    function GetById(vId: Integer): TClienteDTO;
    function Update(pCliente: TClienteDTO): Integer;
    procedure Delete(pId: Integer);
  end;

implementation

uses
  unt.Model.DAO.MySql;

{ TClienteProvider }

procedure TClienteProvider.Delete(pId: Integer);
begin
  dmConnection.ExecSQL('delete from clientes where id = :id', [pId]);
end;

function TClienteProvider.GetAll: TDataSet;
begin
  Result := dmConnection.GetDataSet('select * from clientes');
end;

function TClienteProvider.GetById(vId: Integer): TClienteDTO;
var
  ds: TDataSet;
begin
  ds := dmConnection.GetDataSet('select * from clientes where id = ' + vId.ToString);
  try
    Result.id          := ds.FieldByName('id').AsInteger;
    Result.nome        := ds.FieldByName('nome').AsString;
    Result.tipo        := TipoPessoa(ds.FieldByName('tipo').AsInteger);
    Result.cnpj_cpf    := ds.FieldByName('cnpj_cpf').AsString;
    Result.cep         := ds.FieldByName('cep').AsString;
    Result.logradouro  := ds.FieldByName('logradouro').AsString;
    Result.complemento := ds.FieldByName('complemento').AsString;
    Result.numero      := ds.FieldByName('number').AsString;
    Result.bairro      := ds.FieldByName('bairro').AsString;
    Result.cidade      := ds.FieldByName('cidade').AsString;
    Result.uf          := ds.FieldByName('uf').AsString;
  finally
    ds.Free;
  end;
end;

function TClienteProvider.InsertOrUpdate(pCliente: TClienteDTO): Integer;
var
  vSql: String;
begin
  vSql := 'insert into clientes ' +
    '(id, nome, Tipo, CNPJ_CPF, CEP, logradouro, complemento, number, bairro, cidade, uf)' +
    'values(:id, :nome, :tipo, :cnpj_cpf, :cep, :logradouro, ' +
    ':complemento, :number, :bairro, :cidade, :uf) ' +
    'on duplicate key update ' +
    'nome = :nome, ' +
    'tipo = :tipo, ' +
    'cnpj_cpf = :cnpj_cpf, ' +
    'cep = :cep, ' +
    'logradouro = :logradouro, ' +
    'complemento = :complemento, ' +
    'number = :number, ' +
    'bairro = :bairro, ' +
    'cidade = :cidade,' +
    'uf = :uf';
  dmConnection.ExecSQL(vSql, [pCliente.id, pCliente.nome, Ord(pCliente.tipo), pCliente.cnpj_cpf,
    pCliente.cep, pCliente.logradouro, pCliente.complemento, pCliente.numero, pCliente.bairro,
    pCliente.cidade, pCliente.uf]);
  if pCliente.id > 0 then
    Result := pCliente.id
  else
    Result := dmConnection.GetLastId;
end;

function TClienteProvider.Update(pCliente: TClienteDTO): Integer;
var
  vSql: String;
begin
  if pCliente.id < 1 then
    raise Exception.Create('Para editar o cliente o ID deve ser passado.');

  vSql := 'update clientes set ' +
    'nome = :nome, ' +
    'tipo = :tipo, ' +
    'cnpj_cpf = :cnpj_cpf, ' +
    'cep = :cep, ' +
    'logradouro = :logradouro, ' +
    'complemento = :complemento, ' +
    'number = :number, ' +
    'bairro = :bairro, ' +
    'cidade = :cidade, ' +
    'uf = :uf ' +
    'where id = :id';
  Result := dmConnection.ExecSQL(vSql, [pCliente.id, pCliente.nome, Ord(pCliente.tipo),
    pCliente.cnpj_cpf,
    pCliente.cep, pCliente.logradouro, pCliente.complemento, pCliente.numero, pCliente.bairro,
    pCliente.cidade, pCliente.uf]);
end;

end.
