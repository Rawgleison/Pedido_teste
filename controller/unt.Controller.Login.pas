unit unt.Controller.Login;

interface

uses
  unt.Model.DTO.User, unt.Model.Provider.User, BCrypt;

type
  TLoginController = class
  private

    { private declarations }
  protected
    { protected declarations }
  public
    function CheckLogin(UserName, Password: String): TUserDTO;

  published
    { published declarations }
  end;

implementation

{ TLoginCOntroller }

function TLoginCOntroller.CheckLogin(UserName, Password: String): TUserDTO;
var
  vUserTmp: TUserDTO;
  vUserProvider: TUserProvider;
begin
  vUserProvider := TUserProvider.Create;
  try
  vUserTmp := vUserProvider.GetByNome(UserName);
  if TBCrypt.CompareHash(Password, vUserTmp.password) then
    Result := vUserTmp;
  finally
    vUserProvider.Free;
  end;
end;

end.
