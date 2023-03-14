unit unt.Model.DTO.Cliente;

interface

Type
  TipoPessoa = (tpFISICA, tpJURIDICA);

  TClienteDTO = record
    id: Integer;
    nome: String;
    tipo: TipoPessoa;
    cnpj_cpf: string;
    cep: string;
    logradouro: string;
    complemento: string;
    numero: string;
    bairro: string;
    cidade: String;
    uf: String;
  end;

implementation

end.
