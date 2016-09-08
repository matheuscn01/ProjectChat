object FLogin: TFLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 174
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 32
    Width = 79
    Height = 33
    Caption = 'Usuario:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 79
    Width = 64
    Height = 33
    Caption = 'Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
  end
  object labCadastro: TLabel
    Left = 32
    Top = 132
    Width = 136
    Height = 23
    Caption = 'Cadastre uma conta'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -13
    Font.Name = 'Segoe Print'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
    OnClick = labCadastroClick
    OnMouseEnter = labCadastroMouseEnter
    OnMouseLeave = labCadastroMouseLeave
  end
  object labErro: TLabel
    Left = 255
    Top = 111
    Width = 82
    Height = 44
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object edtLogin: TEdit
    Left = 117
    Top = 37
    Width = 116
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
  object edtSenha: TEdit
    Left = 102
    Top = 84
    Width = 131
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
  end
  object btnEntrar: TButton
    Left = 174
    Top = 133
    Width = 59
    Height = 25
    Caption = 'Entrar'
    TabOrder = 2
    OnClick = btnEntrarClick
  end
end
