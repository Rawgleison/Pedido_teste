unit unt.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, unt.Model.Imagens,
  unt.Controller.Login, unt.Helpers.Messages, Vcl.AppEvnts, unt.Helpers.TCustomEdit, unt.View.Pedido;

type
  TViewLogin = class(TForm)
    edtLogin: TLabeledEdit;
    edtSenha: TButtonedEdit;
    Label1: TLabel;
    pnlFoot: TPanel;
    butCancelar: TBitBtn;
    butEntrar: TBitBtn;
    ApplicationEvents1: TApplicationEvents;
    Label2: TLabel;
    procedure edtSenhaRightButtonClick(Sender: TObject);
    procedure butEntrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
  private
   FLoginController : TLoginController;
    procedure ColorEdit;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewLogin: TViewLogin;

implementation

uses
  unt.Model.DTO.User;

{$R *.dfm}


procedure TViewLogin.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ColorEdit;
end;

procedure TViewLogin.butEntrarClick(Sender: TObject);
var
  vUserTemp: TUserDTO;
begin
  vUserTemp := FLoginController.CheckLogin(edtLogin.Text, edtSenha.Text);

  if vUserTemp.nome.ToUpper <> edtLogin.TextStr.ToUpper then
  begin
    Message_ATENCAO('Login ou senha incorreto.');
    Exit;
  end else
  begin
    frmPedido.FUserLogado := vUserTemp;
    ModalResult := mrYes;
  end;
end;

procedure TViewLogin.edtSenhaRightButtonClick(Sender: TObject);
const
  showPassword = 15;
  hidePassword = 16;
begin
  if edtSenha.RightButton.ImageIndex = showPassword then
  begin
    edtSenha.RightButton.ImageIndex := hidePassword;
    edtSenha.PasswordChar := '*';
  end
  else
  begin
    edtSenha.RightButton.ImageIndex := showPassword;
    edtSenha.PasswordChar := #0;
  end;
end;

procedure TViewLogin.FormCreate(Sender: TObject);
begin
  FLoginController := TLoginController.Create;
end;

procedure TViewLogin.FormDestroy(Sender: TObject);
begin
  FLoginController.Free;
end;

procedure TViewLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TViewLogin.ColorEdit;
begin
  for var I := 0 to pred(Self.ControlCount) do
    if (Self.Controls[I] is TCustomEdit) then
      if TEdit(Self.Controls[I]).Focused then
        TEdit(Self.Controls[I]).Color := $00D9FFFF
      else
        TEdit(Self.Controls[I]).Color := clWindow;
end;

end.
