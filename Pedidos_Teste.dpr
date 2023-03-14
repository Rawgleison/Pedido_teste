program Pedidos_Teste;

uses
  Vcl.Forms,
  Vcl.Controls,
  unt.View.Users in 'view\unt.View.Users.pas' {frmCadastroUser},
  unt.View.Pedido in 'view\unt.View.Pedido.pas' {frmPedido},
  unt.View.Produto in 'view\unt.View.Produto.pas' {frmCadastroProduto},
  unt.View.Find.Generic in 'view\find\unt.View.Find.Generic.pas' {frmFindGeneric},
  unt.Model.Config.MySql in 'model\unt.Model.Config.MySql.pas',
  unt.Model.Imagens in 'model\unt.Model.Imagens.pas' {dmImagens: TDataModule},
  unt.Model.Provider.Cliente in 'model\provider\unt.Model.Provider.Cliente.pas',
  unt.Model.Provider.Interfaces in 'model\provider\unt.Model.Provider.Interfaces.pas',
  unt.Model.Provider.Pedidos.Itens in 'model\provider\unt.Model.Provider.Pedidos.Itens.pas',
  unt.Model.Provider.Pedidos in 'model\provider\unt.Model.Provider.Pedidos.pas',
  unt.Model.Provider.Produtos in 'model\provider\unt.Model.Provider.Produtos.pas',
  unt.Model.DTO.Cliente in 'model\DTO\unt.Model.DTO.Cliente.pas',
  unt.Model.DTO.Pedidos.Itens in 'model\DTO\unt.Model.DTO.Pedidos.Itens.pas',
  unt.Model.DTO.Pedidos in 'model\DTO\unt.Model.DTO.Pedidos.pas',
  unt.Model.DTO.Produtos in 'model\DTO\unt.Model.DTO.Produtos.pas',
  unt.Model.DAO.IniFile in 'model\DAO\unt.Model.DAO.IniFile.pas',
  unt.Model.DAO.MySql in 'model\DAO\unt.Model.DAO.MySql.pas' {dmConnection: TDataModule},
  unt.Controller.Cliente in 'controller\unt.Controller.Cliente.pas',
  unt.Controller.Interfaces in 'controller\unt.Controller.Interfaces.pas',
  unt.controller.pedido in 'controller\unt.controller.pedido.pas',
  unt.Controller.Produto in 'controller\unt.Controller.Produto.pas',
  unt.Conytroller.Viewer.Produto in 'controller\Viewer\unt.Conytroller.Viewer.Produto.pas',
  unt.Helpers.Messages in 'controller\helpers\unt.Helpers.Messages.pas',
  unt.Model.DAO.ViaCep in 'model\DAO\unt.Model.DAO.ViaCep.pas' {ViaCEP: TDataModule},
  unt.Helpers.JSON in 'controller\helpers\unt.Helpers.JSON.pas',
  unt.View.Login in 'view\unt.View.Login.pas' {ViewLogin},
  BCrypt.Consts in 'controller\helpers\bcrypt\BCrypt.Consts.pas',
  BCrypt.Core in 'controller\helpers\bcrypt\BCrypt.Core.pas',
  BCrypt.Intf in 'controller\helpers\bcrypt\BCrypt.Intf.pas',
  BCrypt in 'controller\helpers\bcrypt\BCrypt.pas',
  BCrypt.Types in 'controller\helpers\bcrypt\BCrypt.Types.pas',
  unt.View.Clientes in 'view\unt.View.Clientes.pas' {frmCadastroCliente},
  unt.Model.DTO.User in 'model\DTO\unt.Model.DTO.User.pas',
  unt.Controller.User in 'controller\unt.Controller.User.pas',
  unt.Model.Provider.User in 'model\provider\unt.Model.Provider.User.pas',
  unt.Helpers.TCustomEdit in 'controller\helpers\unt.Helpers.TCustomEdit.pas',
  unt.Controller.Login in 'controller\unt.Controller.Login.pas';

{$R *.res}
var
  mrResult: TModalResult;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmImagens, dmImagens);
  Application.CreateForm(TdmConnection, dmConnection);
  Application.CreateForm(TfrmPedido, frmPedido);

  ViewLogin := TViewLogin.Create(nil);
  try
    mrResult := ViewLogin.ShowModal;
  finally
    ViewLogin.Destroy;
  end;

  if mrResult = mrYes then
  begin
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
    Application.CreateForm(TfrmCadastroProduto, frmCadastroProduto);
    Application.CreateForm(TfrmCadastroUser, frmCadastroUser);
    Application.CreateForm(TfrmFindGeneric, frmFindGeneric);
    Application.CreateForm(TViaCEP, ViaCEP);
    Application.Run;
  end else
    Application.Terminate;
end.
