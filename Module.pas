unit Module;

interface

uses
  SysUtils, Classes, rtcInfo, rtcConn, rtcDataSrv, rtcHttpSrv, rtcFunction,
  rtcSrvModule, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  rtcDataCli, rtcCliModule, rtcMsgSrv, rtcThrPool, DBClient,
  pFIBClientDataSet, rtcDBCli, rtcDB, DB, FIBDataSet, pFIBDataSet;

type
  TdmServer = class(TDataModule)
    RtcServerModule: TRtcServerModule;
    RtcFunctionGroup: TRtcFunctionGroup;
    RtcEnviarMsg: TRtcFunction;
    DbChat: TpFIBDatabase;
    TransWrite: TpFIBTransaction;
    TransRead: TpFIBTransaction;
    sqlInsereMsg: TpFIBStoredProc;
    RtcServer: TRtcHttpServer;
    qryCarregaHistorico: TpFIBQuery;
    RtcCarregaHistorico: TRtcFunction;
    RtcCarregarMensagens: TRtcFunction;
    sqlCarregarMensagens: TpFIBStoredProc;
    qrySelectIdConversa: TpFIBQuery;
    qryUsuarios: TpFIBDataSet;
    dsUsuarios: TDataSource;
    RtcEnviarMsgGrupo: TRtcFunction;
    sqlCarregarMsgGrupo: TpFIBStoredProc;
    RtcCarregarMensagensGrupo: TRtcFunction;
    RtcOnline: TRtcFunction;
    RtcVerificaOnline: TRtcFunction;
    sqlVerificaOnline: TpFIBStoredProc;
    RtcOffline: TRtcFunction;
    qryOffline: TpFIBQuery;
    sqlLogin: TpFIBStoredProc;
    procedure RtcEnviarMsgExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcCarregaHistoricoExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcCarregarMensagensExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcEnviarMsgGrupoExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcCarregarMensagensGrupoExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcOnlineExecute(Sender: TRtcConnection; Param: TRtcFunctionInfo;
      Result: TRtcValue);
    procedure RtcVerificaOnlineExecute(Sender: TRtcConnection;
      Param: TRtcFunctionInfo; Result: TRtcValue);
    procedure RtcOfflineExecute(Sender: TRtcConnection; Param: TRtcFunctionInfo;
      Result: TRtcValue);
  private
    cdsBlob: TRtcDataSet;
  public
    { Public declarations }
  end;

var
  dmServer: TdmServer;

implementation

uses
  Dialogs;

{$R *.dfm}

procedure TdmServer.RtcCarregaHistoricoExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
  begin
  with qryCarregaHistorico do
  begin
    Prepare;
    ParamByName('pid_usuario1').Value := Param.asString['ID_USUARIO1'];
    ParamByName('pid_usuario2').Value := Param.asString['ID_USUARIO2'];
    qryCarregaHistorico.ExecQuery;
    if (FieldByName('historico').IsNull) then
      Result.asText := 'Não há históricos'
    else
      Result.asText := FieldByName('historico').Value;
  end;
end;

procedure TdmServer.RtcCarregarMensagensExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
var
  destinatario, usuario, idConversa: string;
begin
  usuario := Param.asString['ID_USUARIO'];
  destinatario := Param.asString['ID_DESTINATARIO'];

  With qrySelectIdConversa do
  begin
    prepare;
    ParamByName('PID_USUARIO1').Value := usuario;
    ParamByName('PID_USUARIO2').Value := destinatario;
    ExecQuery;
    if not (FieldByName('ID_CONVERSA').IsNull) then
    begin
      idConversa := FieldByName('ID_CONVERSA').Value;
      With sqlCarregarMensagens do
      begin
        Prepare;
        ParamByName('PID_USUARIO').Value := StrToInt(usuario);
        ParamByName('PID_CONVERSA').Value := StrToInt(idConversa);
        ExecProc;
        if not (ParamByName('PMENSAGEM').IsNull) then
          Result.asString := (ParamByName('PMENSAGEM').Value + ' [' + ParamByName('PDATA').Value + ']');
      end;
    end;
  end;
end;

procedure TdmServer.RtcCarregarMensagensGrupoExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
var
  usuario: string;
begin
  usuario := Param.asString['ID_USUARIO'];

  With sqlCarregarMsgGrupo do
  begin
    Prepare;
    ParamByName('PID_USUARIO').Value := StrToInt(usuario);
    ExecProc;
    if not (ParamByName('PMENSAGEM').IsNull) then
      Result.asString := (ParamByName('PMENSAGEM').Value) + ' [' + ParamByName('PDATA').Value + ']';
  end;
end;

procedure TdmServer.RtcEnviarMsgExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
var
  msg, id_remetente: string;
  id_destinatario : integer;
begin
  msg := Param.asString['MENSAGEM'];
  id_remetente := Param.asString['ID_REMETENTE'];
  id_destinatario := Param.asInteger['ID_DESTINATARIO'];

  With sqlInsereMsg do
  begin
    ParamByName('PMSG').Value:= msg;
    ParamByName('PID_REMETENTE').Value := id_remetente;
    ParamByName('PID_DESTINATARIO').Value := id_destinatario;
    ParamByName('PGRUPO').Value := 0;
    ExecProc;
    Result.asText := ParamByName('PMENSAGEM').Value + ' [' + DateToStr(Date) + ' ' + TimeToStr(Time) +']';
  end;

end;

procedure TdmServer.RtcEnviarMsgGrupoExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
var
  msg, id_remetente: string;
  id_destinatario : integer;
begin
  msg := Param.asString['MENSAGEM'];
  id_remetente := Param.asString['ID_REMETENTE'];

  qryUsuarios.Close;
  qryUsuarios.ParamByName('PID_USUARIO').Value := StrToInt(id_remetente);
  qryUsuarios.Open;
  qryUsuarios.First;
  while not qryUsuarios.Eof do
  begin
    With sqlInsereMsg do
    begin
      prepare;
      ParamByName('PGRUPO').Value := 1;
      ParamByName('PMSG').Value := msg;
      ParamByName('PID_REMETENTE').Value := id_remetente;
      ParamByName('PID_DESTINATARIO').Value := qryUsuarios.FieldByName('ID_USUARIO').Value;
      ExecProc;
    end;
    QryUsuarios.Next
  end;
  Result.asString := sqlInsereMsg.ParamByName('PMENSAGEM').Value + ' [' + DateToStr(Date) + ' ' + TimeToStr(Time) +']';
end;

procedure TdmServer.RtcOfflineExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
begin
  With qryOffline do
  begin
    Close;
    ParamByName('PID_USUARIO').Value := StrToInt(Param.asString['ID_USUARIO']);
    ExecQuery;
  end;
end;

procedure TdmServer.RtcOnlineExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
begin
  With sqlLogin do
  Begin
    Prepare;
    ParamByName('PLOGIN').Value := Param.asString['LOGIN'];
    ParamByName('PSENHA').Value := Param.asString['SENHA'];
    ExecProc;
    if (ParamByName('PSTATUS').Value = 'Logou') then
      Result.asString := IntToStr(ParamByName('PID_USUARIO').Value)
    else
      Result.asString := ParamByName('PSTATUS').Value;
  End;
end;

procedure TdmServer.RtcVerificaOnlineExecute(Sender: TRtcConnection;
  Param: TRtcFunctionInfo; Result: TRtcValue);
begin
  With sqlVerificaOnline do
  begin
    Prepare;
    ParamByName('PID_DESTINATARIO').Value := StrToInt(Param.asString['ID_DESTINATARIO']);
    ExecProc;
    Result.asInteger := ParamByName('PRESULT').Value;
  end;
end;

end.
