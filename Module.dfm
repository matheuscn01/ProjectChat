object dmServer: TdmServer
  OldCreateOrder = True
  Height = 399
  Width = 903
  object RtcServerModule: TRtcServerModule
    Server = RtcServer
    ModuleFileName = '/QUERY'
    FunctionGroup = RtcFunctionGroup
    Left = 32
    Top = 72
  end
  object RtcFunctionGroup: TRtcFunctionGroup
    Left = 120
    Top = 16
  end
  object RtcEnviarMsg: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'EnviarMsg'
    OnExecute = RtcEnviarMsgExecute
    Left = 216
    Top = 16
  end
  object DbChat: TpFIBDatabase
    Connected = True
    DBName = 'C:\Delphi\Projetos\Chat\Servidor\CHAT.FDB'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=win1252')
    DefaultTransaction = TransRead
    DefaultUpdateTransaction = TransWrite
    SQLDialect = 1
    Timeout = 0
    LibraryName = 'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll'
    AliasName = 'DBChat'
    WaitForRestoreConnect = 0
    Left = 40
    Top = 248
  end
  object TransWrite: TpFIBTransaction
    Active = True
    DefaultDatabase = DbChat
    TimeoutAction = TARollback
    Left = 120
    Top = 208
  end
  object TransRead: TpFIBTransaction
    Active = True
    DefaultDatabase = DbChat
    TimeoutAction = TARollback
    Left = 120
    Top = 288
  end
  object sqlInsereMsg: TpFIBStoredProc
    Transaction = TransRead
    Database = DbChat
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INSERE_MSG (?PGRUPO, ?PMSG, ?PID_REMETENTE, ?P' +
        'ID_DESTINATARIO)')
    StoredProcName = 'INSERE_MSG'
    Left = 216
    Top = 208
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object RtcServer: TRtcHttpServer
    Left = 32
    Top = 16
  end
  object qryCarregaHistorico: TpFIBQuery
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      'SELECT'
      '    HISTORICO'
      'FROM'
      '    CONVERSAS'
      'where '
      
        '   (id_usuario1 = :pid_usuario1 or id_usuario1 = :pid_usuario2) ' +
        'and'
      '   (id_usuario2 = :pid_usuario1 or id_usuario2 = :pid_usuario2)'
      ' ')
    Left = 568
    Top = 208
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object RtcCarregaHistorico: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'CarregaHistorico'
    OnExecute = RtcCarregaHistoricoExecute
    Left = 312
    Top = 16
  end
  object RtcCarregarMensagens: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'CarregarMensagens'
    OnExecute = RtcCarregarMensagensExecute
    Left = 432
    Top = 16
  end
  object sqlCarregarMensagens: TpFIBStoredProc
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      
        'EXECUTE PROCEDURE CARREGA_MSG_PENDENTES (?PID_USUARIO, ?PID_CONV' +
        'ERSA)')
    StoredProcName = 'CARREGA_MSG_PENDENTES'
    Left = 216
    Top = 288
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object qrySelectIdConversa: TpFIBQuery
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      'SELECT'
      '    ID_CONVERSA'
      'FROM'
      '    CONVERSAS '
      'where '
      
        '   (id_usuario1 = :pid_usuario1 or id_usuario1 = :pid_usuario2) ' +
        'and'
      '   (id_usuario2 = :pid_usuario1 or id_usuario2 = :pid_usuario2)')
    Left = 568
    Top = 288
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object qryUsuarios: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '    ID_USUARIO'
      'FROM'
      '    USUARIOS'
      'where'
      '    id_usuario <> :pid_usuario')
    Transaction = TransRead
    Database = DbChat
    UpdateTransaction = TransWrite
    Left = 672
    Top = 208
    oDontAutoClose = True
  end
  object dsUsuarios: TDataSource
    DataSet = qryUsuarios
    Left = 760
    Top = 208
  end
  object RtcEnviarMsgGrupo: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'EnviarMsgGrupo'
    OnExecute = RtcEnviarMsgGrupoExecute
    Left = 216
    Top = 72
  end
  object sqlCarregarMsgGrupo: TpFIBStoredProc
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      'EXECUTE PROCEDURE CARREGA_MSG_GRUPO (?PID_USUARIO)')
    StoredProcName = 'CARREGA_MSG_GRUPO'
    Left = 320
    Top = 208
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object RtcCarregarMensagensGrupo: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'CarregarMensagensGrupo'
    OnExecute = RtcCarregarMensagensGrupoExecute
    Left = 432
    Top = 72
  end
  object RtcOnline: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'Online'
    OnExecute = RtcOnlineExecute
    Left = 312
    Top = 72
  end
  object RtcVerificaOnline: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'VerificaOnline'
    OnExecute = RtcVerificaOnlineExecute
    Left = 560
    Top = 16
  end
  object sqlVerificaOnline: TpFIBStoredProc
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      'EXECUTE PROCEDURE VERIFICA_ONLINE (?PID_DESTINATARIO)')
    StoredProcName = 'VERIFICA_ONLINE'
    Left = 320
    Top = 288
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object RtcOffline: TRtcFunction
    Group = RtcFunctionGroup
    FunctionName = 'Offline'
    OnExecute = RtcOfflineExecute
    Left = 560
    Top = 72
  end
  object qryOffline: TpFIBQuery
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      
        'update usuarios set online = false where id_usuario = :pid_usuar' +
        'io')
    Left = 656
    Top = 288
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object sqlLogin: TpFIBStoredProc
    Transaction = TransWrite
    Database = DbChat
    SQL.Strings = (
      'EXECUTE PROCEDURE LOGIN (?PLOGIN, ?PSENHA)')
    StoredProcName = 'LOGIN'
    Left = 448
    Top = 208
    qoAutoCommit = True
    qoStartTransaction = True
  end
end
