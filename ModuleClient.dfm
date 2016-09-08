object dmClient: TdmClient
  OldCreateOrder = False
  Height = 327
  Width = 907
  object RtcClientModule: TRtcClientModule
    Client = RtcClient
    ModuleHost = '192.168.0.58'
    ModuleFileName = '/QUERY'
    Left = 128
    Top = 24
  end
  object RtcClient: TRtcHttpClient
    ServerAddr = '192.168.0.58'
    ServerPort = '81'
    OnConnectFail = RtcClientConnectFail
    Left = 40
    Top = 24
  end
  object RtcResCarregarMsg: TRtcResult
    OnReturn = RtcResCarregarMsgReturn
    Left = 728
    Top = 24
  end
  object RtcResEnviarMsg: TRtcResult
    OnReturn = RtcResEnviarMsgReturn
    Left = 232
    Top = 24
  end
  object RtcResCarregaHistorico: TRtcResult
    OnReturn = RtcResCarregaHistoricoReturn
    Left = 600
    Top = 24
  end
  object RtcResCarregarMsgGrupo: TRtcResult
    OnReturn = RtcResCarregarMsgGrupoReturn
    Left = 472
    Top = 24
  end
  object RtcResEnviarMsgGrupo: TRtcResult
    OnReturn = RtcResEnviarMsgGrupoReturn
    Left = 344
    Top = 24
  end
  object RtcResOnline: TRtcResult
    OnReturn = RtcResOnlineReturn
    Left = 232
    Top = 96
  end
  object RtcClientModuleAux: TRtcClientModule
    Client = RtcClient
    ModuleHost = '192.168.0.58'
    ModuleFileName = '/QUERY'
    Left = 128
    Top = 96
  end
  object RtcResVerificaOline: TRtcResult
    OnReturn = RtcResVerificaOlineReturn
    Left = 344
    Top = 96
  end
  object RtcResOffline: TRtcResult
    OnReturn = RtcResOfflineReturn
    Left = 472
    Top = 96
  end
end
