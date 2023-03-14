unit unt.View.Clientes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  unt.Model.Imagens,
  unt.Controller.Cliente,
  unt.Model.DTO.Cliente,
  unt.Helpers.Messages,
  Vcl.AppEvnts,
  unt.Model.DAO.ViaCep,
  Vcl.Mask;

type
  TStatusTela = (stINSERINDO, stEDITANDO, stAGUARDANDO);

  TfrmCadastroCliente = class(TForm)
    edtCliente: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtUf: TLabeledEdit;
    Panel1: TPanel;
    butBuscarCliente: TSpeedButton;
    butGravar: TBitBtn;
    butCancel: TBitBtn;
    butNovoCliente: TSpeedButton;
    lblStatus: TLabel;
    ApplicationEvents1: TApplicationEvents;
    edtLogradouro: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    cbbTipoPessoa: TComboBox;
    Label1: TLabel;
    butFindAddress: TSpeedButton;
    medtCEP: TMaskEdit;
    Label2: TLabel;
    edtBairro: TLabeledEdit;
    Label3: TLabel;
    medtCPF_CNPJ: TMaskEdit;
    btnCliExcluir: TBitBtn;
    procedure butBuscarClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure butNovoClienteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure butGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure butFindAddressClick(Sender: TObject);
    procedure cbbTipoPessoaChange(Sender: TObject);
    procedure medtCEPExit(Sender: TObject);
    procedure btnCliExcluirClick(Sender: TObject);
  private
    FClienteCtrl: TClienteController;
    Fcliente    : TClienteDTO;
    { Private declarations }
    procedure GetCliente;
    procedure GravaCliente;
    procedure ExcluirCliente;
    procedure Clear;
    function GetStatus: TStatusTela;
    procedure SetStatus(const Value: TStatusTela);
    procedure BuscarCliente;
    procedure GetAddressFromCep;
    procedure ColorEdit;
    procedure SetTipoPessoa;
  public
    { Public declarations }
    property Status: TStatusTela read GetStatus write SetStatus;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  unt.View.Find.Generic;

{$R *.dfm}


procedure TfrmCadastroCliente.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ColorEdit;
end;

procedure TfrmCadastroCliente.butFindAddressClick(Sender: TObject);
begin
  GetAddressFromCep;
end;

procedure TfrmCadastroCliente.btnCliExcluirClick(Sender: TObject);
begin
  if Message_Confirma('Deseja excluir o cliente '+edtNome.Text+' permanentemenete?') then
    ExcluirCliente;
end;

procedure TfrmCadastroCliente.BuscarCliente;
begin
  frmFindGeneric.ControllerEntitie := TClienteController.Create;
  if frmFindGeneric.ShowModal = mrOk then
  begin
    edtCliente.Text := frmFindGeneric.ID.ToString;
    GetCliente;
  end;
end;

procedure TfrmCadastroCliente.butBuscarClienteClick(Sender: TObject);
begin
  BuscarCliente;
end;

procedure TfrmCadastroCliente.butNovoClienteClick(Sender: TObject);
begin
  Status := stINSERINDO;
end;

procedure TfrmCadastroCliente.cbbTipoPessoaChange(Sender: TObject);
begin
  SetTipoPessoa;
end;

procedure TfrmCadastroCliente.butCancelClick(Sender: TObject);
begin
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroCliente.butGravarClick(Sender: TObject);
begin
  GravaCliente;
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroCliente.Clear;
begin
  for var I := 0 to pred(Self.ControlCount) do
    if Self.Controls[I] is TCustomEdit then
      TEdit(Self.Controls[I]).Clear;

  cbbTipoPessoa.ItemIndex := 0;
  SetTipoPessoa;
end;

procedure TfrmCadastroCliente.ColorEdit;
begin
  for var I := 0 to pred(Self.ControlCount) do
    if (Self.Controls[I] is TCustomEdit) then
      if TEdit(Self.Controls[I]).Focused then
        TEdit(Self.Controls[I]).Color := $00D9FFFF
      else
        TEdit(Self.Controls[I]).Color := clWindow;
end;

procedure TfrmCadastroCliente.edtClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    if edtCliente.GetTextLen = 0 then
      BuscarCliente
    else
      GetCliente;
  end;

  if key = VK_F2 then
    Status := stINSERINDO;
end;

procedure TfrmCadastroCliente.ExcluirCliente;
begin
  FClienteCtrl.Delete(StrToInt(edtCliente.Text));
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  FClienteCtrl := TClienteController.Create;
end;

procedure TfrmCadastroCliente.FormDestroy(Sender: TObject);
begin
  FClienteCtrl.Free;
end;

procedure TfrmCadastroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroCliente.GetAddressFromCep;
var
  vAddress: TAddress;
begin
  vAddress           := ViaCep.GetAddress(medtCEP.Text);
  edtLogradouro.Text := vAddress.logradouro;
  edtBairro.Text     := vAddress.bairro;
  edtCidade.Text     := vAddress.localidade;
  edtUf.Text         := vAddress.uf;
end;

procedure TfrmCadastroCliente.GetCliente;
begin
  if edtCliente.GetTextLen = 0 then
    Exit;

  Fcliente                := FClienteCtrl.GetById(edtCliente.Text);
  if FCliente.id = 0 then
  begin
    Message_ATENCAO('Cliente não localizado na base de dados.');
    Status := stAGUARDANDO;
    Exit;
  end;

  edtNome.Text            := Fcliente.nome;
  cbbTipoPessoa.ItemIndex := Ord(Fcliente.tipo);
  medtCPF_CNPJ.Text       := Fcliente.cnpj_cpf;
  medtCEP.Text            := Fcliente.cep;
  edtLogradouro.Text      := Fcliente.logradouro;
  edtNumero.Text          := Fcliente.numero;
  edtComplemento.Text     := Fcliente.complemento;
  edtBairro.Text          := Fcliente.bairro;
  edtCidade.Text          := Fcliente.cidade;
  edtUf.Text              := Fcliente.uf;
  Status                  := stEDITANDO;
  SetTipoPessoa;
end;

function TfrmCadastroCliente.GetStatus: TStatusTela;
begin

end;

procedure TfrmCadastroCliente.GravaCliente;
begin
  Fcliente.ID          := StrToIntDef(edtCliente.Text, 0);
  Fcliente.nome        := edtNome.Text;
  Fcliente.tipo        := TipoPessoa(cbbTipoPessoa.ItemIndex);
  Fcliente.cnpj_cpf    := medtCPF_CNPJ.Text;
  Fcliente.cep         := medtCEP.Text;
  Fcliente.logradouro  := edtLogradouro.Text;
  Fcliente.complemento := edtComplemento.Text;
  Fcliente.numero      := edtNumero.Text;
  Fcliente.bairro      := edtBairro.Text;
  Fcliente.cidade      := edtCidade.Text;
  Fcliente.uf          := edtUf.Text;

  Fcliente := FClienteCtrl.InsertOrUpdate(Fcliente);

  Message_AVISO('Cliente gravado com sucesso.'#13'Código: ' + Fcliente.ID.ToString)
end;

procedure TfrmCadastroCliente.medtCEPExit(Sender: TObject);
begin
  if (Length(medtCEP.Text) = 8) and (Trim(edtLogradouro.Text) = '') then
    GetAddressFromCep;
end;

procedure TfrmCadastroCliente.SetStatus(const Value: TStatusTela);
begin
  edtCliente.Enabled     := Value in [stAGUARDANDO];
  edtNome.Enabled        := Value in [stINSERINDO, stEDITANDO];
  edtLogradouro.Enabled  := Value in [stINSERINDO, stEDITANDO];
  edtNumero.Enabled      := Value in [stINSERINDO, stEDITANDO];
  edtComplemento.Enabled := Value in [stINSERINDO, stEDITANDO];
  edtBairro.Enabled      := Value in [stINSERINDO, stEDITANDO];
  cbbTipoPessoa.Enabled  := Value in [stINSERINDO, stEDITANDO];
  medtCEP.Enabled        := Value in [stINSERINDO, stEDITANDO];
  medtCPF_CNPJ.Enabled   := Value in [stINSERINDO, stEDITANDO];
  edtCidade.Enabled      := Value in [stINSERINDO, stEDITANDO];
  edtUf.Enabled          := Value in [stINSERINDO, stEDITANDO];

  butBuscarCliente.Enabled := Value in [stAGUARDANDO];
  butNovoCliente.Enabled   := Value in [stAGUARDANDO];
  butGravar.Enabled        := Value in [stINSERINDO, stEDITANDO];
  butFindAddress.Enabled   := Value in [stINSERINDO, stEDITANDO];
  // butCancel.Enabled        := Value in [stINSERINDO, stEDITANDO];

  Application.ProcessMessages;
  case Value of
    stINSERINDO:
      begin
        lblStatus.Font.Color := clGreen;
        lblStatus.Caption    := 'Inserindo';
        edtNome.SetFocus;
      end;
    stEDITANDO:
      begin
        lblStatus.Font.Color := clYellow;
        lblStatus.Caption    := 'Editando';
        edtNome.SetFocus;
      end;
    stAGUARDANDO:
      begin
        lblStatus.Font.Color := clBlack;
        lblStatus.Caption    := '';
        Clear;
        edtCliente.SetFocus;
      end;
  end;
end;

procedure TfrmCadastroCliente.SetTipoPessoa;
begin
  case cbbTipoPessoa.ItemIndex of
    0:
      medtCPF_CNPJ.EditMask := '000\.000\.000\-00;0;_';
    1:
      medtCPF_CNPJ.EditMask := '00\.000\.000\\0000\-00;0;_';
  end;
end;

end.
