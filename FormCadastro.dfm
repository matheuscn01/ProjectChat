object FCadastro: TFCadastro
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 205
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 28
    Caption = 'Usuario:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 63
    Width = 53
    Height = 28
    Caption = 'Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 111
    Width = 147
    Height = 28
    Alignment = taCenter
    Caption = 'Confirmar Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object labErro: TLabel
    Left = 207
    Top = 66
    Width = 90
    Height = 54
    Alignment = taCenter
    Caption = '*Senhas n'#227'o coincidem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object edtCadastroUsuario: TEdit
    Left = 93
    Top = 17
    Width = 108
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 0
  end
  object edtCadastroSenha: TEdit
    Left = 78
    Top = 64
    Width = 123
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 16
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnExit = edtCadastroSenhaExit
  end
  object btnCadastrar: TButton
    Left = 16
    Top = 162
    Width = 129
    Height = 27
    Caption = 'Cadastrar'
    TabOrder = 3
  end
  object edtConfirmacaooSenha: TEdit
    Left = 169
    Top = 110
    Width = 144
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 16
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 2
    OnExit = edtConfirmacaooSenhaExit
  end
  object btnCancelar: TButton
    Left = 184
    Top = 162
    Width = 129
    Height = 27
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
end
