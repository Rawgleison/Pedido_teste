object frmCadastroUser: TfrmCadastroUser
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 293
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object butBuscarCliente: TSpeedButton
    Left = 139
    Top = 40
    Width = 23
    Height = 33
    DisabledImageIndex = 0
    ImageIndex = 1
    Images = dmImagens.imgList16
    HotImageIndex = 2
    Flat = True
    OnClick = butBuscarClienteClick
  end
  object butNovoCliente: TSpeedButton
    Left = 162
    Top = 41
    Width = 23
    Height = 33
    DisabledImageIndex = 6
    ImageIndex = 7
    Images = dmImagens.imgList16
    HotImageIndex = 8
    Flat = True
    OnClick = butNovoClienteClick
  end
  object lblStatus: TLabel
    Left = 280
    Top = 182
    Width = 94
    Height = 30
    Caption = 'lblStatus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 80
    Width = 58
    Height = 25
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 152
    Width = 142
    Height = 25
    Caption = 'Repita a Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 271
    Top = 80
    Width = 45
    Height = 25
    Caption = 'N'#237'vel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtCod: TLabeledEdit
    Left = 24
    Top = 40
    Width = 113
    Height = 33
    Alignment = taRightJustify
    BorderStyle = bsNone
    EditLabel.Width = 57
    EditLabel.Height = 23
    EditLabel.Caption = 'C'#243'digo'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -19
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edtCodKeyDown
  end
  object edtNome: TLabeledEdit
    Left = 191
    Top = 40
    Width = 242
    Height = 33
    BorderStyle = bsNone
    EditLabel.Width = 49
    EditLabel.Height = 23
    EditLabel.Caption = 'Nome'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -19
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 239
    Width = 451
    Height = 54
    Align = alBottom
    TabOrder = 5
    object butGravar: TBitBtn
      AlignWithMargins = True
      Left = 84
      Top = 7
      Width = 117
      Height = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Gravar'
      DisabledImageIndex = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      HotImageIndex = 8
      ImageIndex = 7
      Images = dmImagens.imgList24
      ParentFont = False
      TabOrder = 0
      OnClick = butGravarClick
    end
    object butCancel: TBitBtn
      AlignWithMargins = True
      Left = 330
      Top = 7
      Width = 117
      Height = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Cancelar'
      DisabledImageIndex = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      HotImageIndex = 5
      ImageIndex = 4
      Images = dmImagens.imgList24
      ParentFont = False
      TabOrder = 1
      OnClick = butCancelClick
    end
    object btnCliExcluir: TBitBtn
      AlignWithMargins = True
      Left = 207
      Top = 7
      Width = 117
      Height = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Excluir'
      DisabledImageIndex = 9
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      HotImageIndex = 11
      ImageIndex = 10
      Images = dmImagens.imgList24
      ParentFont = False
      TabOrder = 2
      OnClick = btnCliExcluirClick
    end
  end
  object edtSenha: TButtonedEdit
    Left = 24
    Top = 111
    Width = 241
    Height = 33
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    Images = dmImagens.imgList24
    ParentFont = False
    PasswordChar = '*'
    RightButton.ImageIndex = 16
    RightButton.Visible = True
    TabOrder = 2
    OnRightButtonClick = edtSenhaRightButtonClick
  end
  object edtSenha2: TButtonedEdit
    Left = 24
    Top = 183
    Width = 241
    Height = 33
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    Images = dmImagens.imgList24
    ParentFont = False
    PasswordChar = '*'
    RightButton.ImageIndex = 16
    TabOrder = 3
  end
  object cbbNivel: TComboBox
    Left = 271
    Top = 111
    Width = 162
    Height = 33
    AutoCloseUp = True
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = 'Padr'#227'o'
    Items.Strings = (
      'Padr'#227'o'
      'Administrador')
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 256
  end
end