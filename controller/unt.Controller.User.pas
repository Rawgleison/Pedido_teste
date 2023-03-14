unit unt.Controller.User;

interface

Uses
  System.SysUtils, System.Variants, System.Classes,
  unt.Model.Provider.User, Data.DB, unt.Model.DTO.User,
  unt.Controller.Interfaces;

Type
  TUserController = class(TInterfacedObject, IUserController, IControllerEntitie)
  private
    FUserProvider: TUserProvider;
  public
    function InsertOrUpdate(pUser: TUserDTO): TUserDTO;
    function GetAll: TDataSet;
    function GetById(vId: Integer): TUserDTO; overload;
    function GetById(vId: String): TUserDTO; overload;
    function Update(pUser: TUserDTO): TUserDTO;
    procedure Delete(pId: Integer);
    procedure ChecarRegras(pUser: TUserDTO);
  end;

implementation

{ TUserController }

procedure TUserController.ChecarRegras(pUser: TUserDTO);
begin
  if pUser.nome.Length = 0 then
    raise Exception.Create('O nome deve ser informado.');

  if (pUser.id = 0) and (pUser.password.Length = 0) then
    raise Exception.Create('A Senha deve ser informada.');
end;

procedure TUserController.Delete(pId: Integer);
begin
  FUserProvider.Delete(pId);
end;

function TUserController.GetAll: TDataSet;
begin
  Result := FUserProvider.GetAll;
end;

function TUserController.GetById(vId: String): TUserDTO;
begin
  Result := GetById(vId.ToInteger);
end;

function TUserController.GetById(vId: Integer): TUserDTO;
begin
  Result := FUserProvider.GetById(vId);
end;

function TUserController.InsertOrUpdate(pUser: TUserDTO): TUserDTO;
begin
  ChecarRegras(pUser);

  pUser.id := FUserProvider.InsertOrUpdate(pUser);

  Result := pUser;
end;

function TUserController.Update(pUser: TUserDTO): TUserDTO;
begin
  FUserProvider.Update(pUser);
  Result := FUserProvider.GetById(pUser.id);
end;

end.
