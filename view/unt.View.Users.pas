unit unt.View.Users;

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
  unt.Controller.User,
  unt.Model.DTO.User,
  unt.Helpers.Messages,
  Vcl.AppEvnts,
  unt.Model.DAO.ViaCep,
  Vcl.Mask,
  unt.Helpers.TCustomEdit;

type
  TStatusTela = (stINSERINDO, stEDITANDO, stAGUARDANDO);

  TfrmCadastroUser = class(TForm)
    edtCod: TLabeledEdit;
    edtNome: TLabeledEdit;
    Panel1: TPanel;
    butBuscarCliente: TSpeedButton;
    butGravar: TBitBtn;
    butCancel: TBitBtn;
    butNovoCliente: TSpeedButton;
    lblStatus: TLabel;
    ApplicationEvents1: TApplicationEvents;
    btnCliExcluir: TBitBtn;
    edtSenha: TButtonedEdit;
    Label1: TLabel;
    edtSenha2: TButtonedEdit;
    Label2: TLabel;
    cbbNivel: TComboBox;
    Label3: TLabel;
    procedure butBuscarClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure butNovoClienteClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure butGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure edtCodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCliExcluirClick(Sender: TObject);
    procedure edtSenhaRightButtonClick(Sender: TObject);
  private
    FUserCtrl: TUserController;
    Fuser    : TUserDTO;
    { Private declarations }
    procedure GetUser;
    procedure GravaUser;
    procedure ExcluirUser;
    procedure Clear;
    function GetStatus: TStatusTela;
    procedure SetStatus(const Value: TStatusTela);
    procedure BuscarUsuario;
    procedure ColorEdit;
  public
    { Public declarations }
    property Status: TStatusTela read GetStatus write SetStatus;
  end;

var
  frmCadastroUser: TfrmCadastroUser;

implementation

uses
  unt.View.Find.Generic;

{$R *.dfm}


procedure TfrmCadastroUser.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ColorEdit;
end;

procedure TfrmCadastroUser.btnCliExcluirClick(Sender: TObject);
begin
  if Message_Confirma('Deseja excluir o usuário ' + edtNome.Text + ' permanentemenete?') then
    ExcluirUser;
end;

procedure TfrmCadastroUser.BuscarUsuario;
begin
  frmFindGeneric.ControllerEntitie := TUserController.Create;
  if frmFindGeneric.ShowModal = mrOk then
  begin
    edtCod.Text := frmFindGeneric.ID.ToString;
    GetUser;
  end;
end;

procedure TfrmCadastroUser.butBuscarClienteClick(Sender: TObject);
begin
  BuscarUsuario;
end;

procedure TfrmCadastroUser.butNovoClienteClick(Sender: TObject);
begin
  Status := stINSERINDO;
end;

procedure TfrmCadastroUser.butCancelClick(Sender: TObject);
begin
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroUser.butGravarClick(Sender: TObject);
begin
  if edtCod.IsEmpty and edtSenha.IsEmpty then
  begin
    Message_ATENCAO('Se estiver inserindo um novo usuário, a senha deve ser informada.');
    edtSenha.SetFocus;
    Exit;
  end;

  if edtSenha.Text = edtSenha2.Text then
  begin
    GravaUser;
    Status := stAGUARDANDO;
  end
  else
  begin
    Message_ATENCAO('As senhas não conferem.');
    edtSenha2.SetFocus;
  end;
end;

procedure TfrmCadastroUser.Clear;
begin
  for var I := 0 to pred(Self.ControlCount) do
    if Self.Controls[I] is TCustomEdit then
      TEdit(Self.Controls[I]).Clear;
end;

procedure TfrmCadastroUser.ColorEdit;
begin
  for var I := 0 to pred(Self.ControlCount) do
    if (Self.Controls[I] is TCustomEdit) then
      if TEdit(Self.Controls[I]).Focused then
        TEdit(Self.Controls[I]).Color := $00D9FFFF
      else
        TEdit(Self.Controls[I]).Color := clWindow;
end;

procedure TfrmCadastroUser.edtCodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    if edtCod.GetTextLen = 0 then
      BuscarUsuario
    else
      GetUser;
  end;
end;

procedure TfrmCadastroUser.edtSenhaRightButtonClick(Sender: TObject);
const
  showPassword = 15;
  hidePassword = 16;
begin
  if edtSenha.RightButton.ImageIndex = showPassword then
  begin
    edtSenha.RightButton.ImageIndex := hidePassword;
    edtSenha.PasswordChar           := '*';
  end
  else
  begin
    edtSenha.RightButton.ImageIndex := showPassword;
    edtSenha.PasswordChar           := #0;
  end;
end;

procedure TfrmCadastroUser.ExcluirUser;
begin
  FUserCtrl.Delete(StrToInt(edtCod.Text));
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroUser.FormCreate(Sender: TObject);
begin
  FUserCtrl := TUserController.Create;
end;

procedure TfrmCadastroUser.FormDestroy(Sender: TObject);
begin
  FUserCtrl.Free;
end;

procedure TfrmCadastroUser.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TfrmCadastroUser.FormShow(Sender: TObject);
begin
  Status := stAGUARDANDO;
end;

procedure TfrmCadastroUser.GetUser;
begin
  if edtCod.GetTextLen = 0 then
    Exit;

  Fuser := FUserCtrl.GetById(edtCod.Text);
  if Fuser.ID = 0 then
  begin
    Message_ATENCAO('Usuário não localizado na base de dados.');
    Status := stAGUARDANDO;
    Exit;
  end;

  edtNome.Text       := Fuser.nome;
  cbbNivel.ItemIndex := Ord(Fuser.nivel);
  Status             := stEDITANDO;
end;

function TfrmCadastroUser.GetStatus: TStatusTela;
begin

end;

procedure TfrmCadastroUser.GravaUser;
begin
  Fuser.ID       := StrToIntDef(edtCod.Text, 0);
  Fuser.nome     := edtNome.Text;
  Fuser.password := edtSenha.Text;
  Fuser.nivel    := NivelAcesso(cbbNivel.ItemIndex);

  Fuser := FUserCtrl.InsertOrUpdate(Fuser);

  Message_AVISO('Cliente gravado com sucesso.'#13'Código: ' + Fuser.ID.ToString)
end;

procedure TfrmCadastroUser.SetStatus(const Value: TStatusTela);
begin
  edtCod.Enabled    := Value in [stAGUARDANDO];
  edtNome.Enabled   := Value in [stINSERINDO, stEDITANDO];
  edtSenha.Enabled  := Value in [stINSERINDO, stEDITANDO];
  edtSenha2.Enabled := Value in [stINSERINDO, stEDITANDO];

  butBuscarCliente.Enabled := Value in [stAGUARDANDO];
  butNovoCliente.Enabled   := Value in [stAGUARDANDO];
  butGravar.Enabled        := Value in [stINSERINDO, stEDITANDO];
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
        edtCod.SetFocus;
      end;
  end;
end;

end.
