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
    object TabConversa: TTabSheet
      Caption = 'Privado'
      OnShow = TabConversaShow
      object Label4: TLabel
        Left = 8
        Top = 213
        Width = 42
        Height = 19
        Caption = 'Dest.:'
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image1: TImage
        Left = 55
        Top = 18
        Width = 16
        Height = 13
      end
      object mConversa: TMemo
        Left = 8
        Top = 37
        Width = 523
        Height = 163
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
        TabOrder = 3
        OnClick = btnEnviarClick
      end
      object mMensagem: TMemo
        Left = 85
        Top = 213
        Width = 365
        Height = 60
        TabOrder = 1
        OnKeyPress = mMensagemKeyPress
      end
      object btnHistorico: TButton
        Left = 456
        Top = 213
        Width = 75
        Height = 28
        Caption = 'Hist'#243'rico'
        TabOrder = 2
        OnClick = btnHistoricoClick
      end
      object cbDestinatarios: TComboBox
        Left = 3
        Top = 238
        Width = 76
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        OnChange = cbDestinatariosChange
      end
    end
    object tabGrupo: TTabSheet
      Caption = 'Grupo'
      ImageIndex = 1
      OnShow = tabGrupoShow
      object Label5: TLabel
        Left = 8
        Top = 13
        Width = 39
        Height = 18
        Caption = 'Grupo'
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
        TabOrder = 0
        WordWrap = True
        OnClick = btnEnviarGrupoClick
      end
      object mConversaGrupo: TMemo
        Left = 8
        Top = 37
        Width = 523
        Height = 163
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object mMensagemGrupo: TMemo
        Left = 8
        Top = 213
        Width = 442
        Height = 60
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
    object btnConectar: TButton
      Left = 448
      Top = 6
      Width = 87
      Height = 27
      Caption = 'Desconectar'
      TabOrder = 0
      OnClick = btnConectarClick
    end
  end
  object TimerCarregarMensagem: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerCarregarMensagemTimer
    Left = 128
    Top = 112
  end
  object TimerCarregarMensagemGrupo: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerCarregarMensagemGrupoTimer
    Left = 288
    Top = 112
  end
end
