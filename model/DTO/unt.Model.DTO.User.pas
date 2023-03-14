unit unt.Model.DTO.User;

interface

Type
  NivelAcesso = (tpCOMUM, tpADMIN);

  TUserDTO = record
    id: Integer;
    nome: String;
    password: string;
    nivel: NivelAcesso;
  end;

implementation

end.
