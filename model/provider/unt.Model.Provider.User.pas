unit unt.Model.Provider.User;

interface

Uses
  System.SysUtils, System.Variants, System.Classes,
  Data.DB, unt.Model.DTO.User, unt.Model.Provider.Interfaces,
  BCrypt;

Type
  TUserProvider = class(TInterfacedObject, IUserPrvider)
  private
    { private declarations }
  public
    { public declarations }
    function InsertOrUpdate(pUser: TUserDTO): Integer;
    function GetAll: TDataSet;
    function GetById(vId: Integer): TUserDTO;
    function GetByNome(vNome: String): TUserDTO;
    function Update(pUser: TUserDTO): Integer;
    procedure Delete(pId: Integer);
  end;

implementation

uses
  unt.Model.DAO.MySql;

{ TUserProvider }

procedure TUserProvider.Delete(pId: Integer);
begin
  dmConnection.ExecSQL('delete from users where id = :id', [pId]);
end;

function TUserProvider.GetAll: TDataSet;
begin
  Result := dmConnection.GetDataSet('select * from users');
end;

function TUserProvider.GetById(vId: Integer): TUserDTO;
var
  ds: TDataSet;
begin
  ds := dmConnection.GetDataSet('select * from users where id = ' + vId.ToString);
  try
    Result.id       := ds.FieldByName('id').AsInteger;
    Result.nome     := ds.FieldByName('nome').AsString;
    Result.password := ds.FieldByName('password').AsString;
    Result.nivel    := NivelAcesso(ds.FieldByName('nivel').AsInteger);
  finally
    ds.Free;
  end;
end;

function TUserProvider.GetByNome(vNome: String): TUserDTO;
var
  ds: TDataSet;
begin
  ds := dmConnection.GetDataSet('select * from users where Upper(nome) = ' +
    vNome.ToUpper.QuotedString);
  try
    Result.id       := ds.FieldByName('id').AsInteger;
    Result.nome     := ds.FieldByName('nome').AsString;
    Result.password := ds.FieldByName('password').AsString;
    Result.nivel    := NivelAcesso(ds.FieldByName('nivel').AsInteger);
  finally
    ds.Free;
  end;
end;

function TUserProvider.InsertOrUpdate(pUser: TUserDTO): Integer;
var
  vSql    : String;
  vUserTmp: TUserDTO;
begin
  vUserTmp := GetByNome(pUser.nome);
  if (pUser.id = 0) and (vUserTmp.id > 0) then
    raise Exception.Create('Nome de usuário já existente na base de dados.');

  if pUser.password.Trim = '' then
    pUser.password := vUserTmp.password
  else
    pUser.password := TBCrypt.GenerateHash(pUser.password);

  vSql := 'insert into users ' +
    '(id, nome, Password, nivel)' +
    'values(:id, :nome, :password, :nivel)' +
    'on duplicate key update ' +
    'nome = :nome, ' +
    'password = :password, ' +
    'nivel = :nivel ';

  dmConnection.ExecSQL(vSql, [pUser.id, pUser.nome, pUser.password, Ord(pUser.nivel)]);
  if pUser.id > 0 then
    Result := pUser.id
  else
    Result := dmConnection.GetLastId;
end;

function TUserProvider.Update(pUser: TUserDTO): Integer;
var
  vSql: String;
begin
  if pUser.id < 1 then
    raise Exception.Create('Para editar o usuário o ID deve ser passado.');

  vSql := 'update users set ' +
    'nome = :nome, ' +
    'password = :password, ' +
    'nivel = :nivel ';

  Result := dmConnection.ExecSQL(vSql, [pUser.id, pUser.nome, pUser.password, Ord(pUser.nivel)]);
end;

end.
