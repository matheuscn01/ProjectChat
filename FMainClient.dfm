object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 354
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 562
    Height = 311
    ActivePage = TabConversa
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 313
    object TabConversa: TTabSheet
      Caption = 'Privado'
      OnShow = TabConversaShow
      ExplicitHeight = 285
      object Label4: TLabel
        Left = 8
        Top = 213
        Width = 42
        Height = 19
        Caption = 'Dest.:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object labinfo: TLabel
        Left = 8
        Top = 13
        Width = 41
        Height = 18
        Caption = 'Offline'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Image1: TImage
        Left = 55
        Top = 17
        Width = 16
        Height = 13
        Visible = False
      end
      object mConversa: TMemo
        Left = 8
        Top = 37
        Width = 523
        Height = 163
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBackground
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnEnviar: TButton
        Left = 456
        Top = 247
        Width = 75
        Height = 26
        Caption = 'Enviar'
        Enabled = False
        TabOrder = 4
        OnClick = btnEnviarClick
      end
      object mMensagem: TMemo
        Left = 85
        Top = 213
        Width = 365
        Height = 60
        Enabled = False
        TabOrder = 2
        OnKeyPress = mMensagemKeyPress
      end
      object edtDestinatario: TEdit
        Left = 55
        Top = 213
        Width = 24
        Height = 21
        Enabled = False
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 1
        Text = '6'
        OnChange = edtDestinatarioChange
      end
      object btnHistorico: TButton
        Left = 456
        Top = 213
        Width = 75
        Height = 28
        Caption = 'Hist'#243'rico'
        Enabled = False
        TabOrder = 3
        OnClick = btnHistoricoClick
      end
    end
    object tabGrupo: TTabSheet
      Caption = 'Grupo'
      ImageIndex = 1
      OnShow = tabGrupoShow
      ExplicitHeight = 285
      object Label5: TLabel
        Left = 8
        Top = 13
        Width = 39
        Height = 18
        Caption = 'Grupo'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnEnviarGrupo: TButton
        Left = 456
        Top = 213
        Width = 75
        Height = 60
        Caption = 'Enviar'#13' Para o Grupo'
        Enabled = False
        TabOrder = 0
        WordWrap = True
        OnClick = btnEnviarGrupoClick
      end
      object mConversaGrupo: TMemo
        Left = 8
        Top = 37
        Width = 523
        Height = 163
        Enabled = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object mMensagemGrupo: TMemo
        Left = 8
        Top = 213
        Width = 442
        Height = 60
        Enabled = False
        TabOrder = 2
        OnKeyPress = mMensagemGrupoKeyPress
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 562
    Height = 43
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 313
    object Label1: TLabel
      Left = 347
      Top = 6
      Width = 43
      Height = 19
      Caption = 'Porta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 156
      Top = 6
      Width = 71
      Height = 19
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtPort: TEdit
      Left = 396
      Top = 6
      Width = 29
      Height = 19
      TabOrder = 0
      Text = '81'
    end
    object edtEndereco: TEdit
      Left = 233
      Top = 6
      Width = 88
      Height = 21
      TabOrder = 1
      Text = '192.168.0.58'
    end
    object btnConectar: TButton
      Left = 448
      Top = 6
      Width = 87
      Height = 27
      Caption = 'Conectar'
      TabOrder = 2
      OnClick = btnConectarClick
    end
  end
  object TimerCarregarMensagem: TTimer
    Interval = 500
    OnTimer = TimerCarregarMensagemTimer
    Left = 128
    Top = 112
  end
  object TimerCarregarMensagemGrupo: TTimer
    Interval = 500
    OnTimer = TimerCarregarMensagemGrupoTimer
    Left = 288
    Top = 112
  end
end
