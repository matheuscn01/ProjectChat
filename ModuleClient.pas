unit ModuleClient;

interface

uses
  SysUtils, Classes, rtcInfo, rtcConn, rtcDataCli, rtcHttpCli, rtcCliModule,
  rtcFunction, rtcMsgCli, rtcDataSrv, rtcMsgSrv, Forms;

type
  TdmClient = class(TDataModule)
    RtcClientModule: TRtcClientModule;
    RtcClient: TRtcHttpClient;
    RtcResCarregarMsg: TRtcResult;
    RtcResEnviarMsg: TRtcResult;
    RtcResCarregaHistorico: TRtcResult;
    RtcResCarregarMsgGrupo: TRtcResult;
    RtcResEnviarMsgGrupo: TRtcResult;
    RtcResOnline: TRtcResult;
    RtcClientModuleAux: TRtcClientModule;
    RtcResVerificaOline: TRtcResult;
    RtcResOffline: TRtcResult;
    procedure RtcResConfigDelayedReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcClientConnectFail(Sender: TRtcConnection);
    procedure RtcResCarregaHistoricoReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResEnviarMsgReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResCarregarMsgReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResCarregarMsgGrupoReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResEnviarMsgGrupoReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResOnlineReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResVerificaOlineReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
    procedure RtcResOfflineReturn(Sender: TRtcConnection; Data,
      Result: TRtcValue);
  private
    conversaAtual : string;
  public
    notificacao, notificacaoGrupo: integer;
  end;

var
  dmClient: TdmClient;

implementation

uses
  FMainClient, Dialogs, Windows, FormCadastro, FormLogin;
{$R *.dfm}

procedure TdmClient.RtcClientConnectFail(Sender: TRtcConnection);
begin
  showMessage('Falha ao conectar ao endereço: ' + Form1.edtEndereco.Text);
end;

procedure TdmClient.RtcResCarregaHistoricoReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  With Form1 do
  begin
    conversaAtual := mConversa.Lines.Text;
    mConversa.Clear;
    mConversa.Lines.Text := Result.asText;
    mConversa.Lines.add(conversaAtual);
  end;
end;

procedure TdmClient.RtcResCarregarMsgGrupoReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  With Form1 do
  begin
    if (Result.asString <> '') then
    begin
      mConversaGrupo.Lines.Add(Result.asString);
      Abrir(Sender);
      if not (tabGrupo.Showing) then
      begin
        notificacaoGrupo := notificacaoGrupo + 1;
        tabGrupo.Caption := 'Grupo (' + IntToStr(notificacaoGrupo) + ')';
      end;
    end;
    TimerCarregarMensagemGrupo.Enabled := true;
  end;
end;

procedure TdmClient.RtcResCarregarMsgReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  With Form1 do
  begin
    if (Result.asString <> '') then
    begin
      mConversa.Lines.Add(Result.asString);
      Abrir(Sender);
      if not (TabConversa.Showing) then
      begin
        notificacao := notificacao + 1;
        TabConversa.Caption := 'Privado (' + IntToStr(notificacao) + ')';
      end;
    end;
    TimerCarregarMensagem.Enabled := true;
  end;
end;

procedure TdmClient.RtcResConfigDelayedReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  ShowMessage(Result.asString);
end;

procedure TdmClient.RtcResEnviarMsgGrupoReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  Form1.mConversaGrupo.Lines.Add(Result.asText);
end;

procedure TdmClient.RtcResEnviarMsgReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  Form1.mConversa.Lines.Add(Result.asText);
end;

procedure TdmClient.RtcResOfflineReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  Form1.online := false;
end;

procedure TdmClient.RtcResOnlineReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
var
  resultado: integer;
begin
  try
    try
      StrToInt(Result.asString);
    except
      FLogin.labErro.Caption := Result.asString;
    end;
  finally
    Form1.id_usuario := StrToInt(Result.asString);
    FLogin.logou := true;
    FLogin.ProcLogou(Sender);
  end;
end;

procedure TdmClient.RtcResVerificaOlineReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  if (result.asInteger = 1) then
  begin
    Form1.labinfo.Caption := 'Online';
    Form1.Image1.Picture.LoadFromFile('Imagens/online.jpg');
  end
  else
  begin
    Form1.labinfo.Caption := 'Offline';
    Form1.Image1.Picture.LoadFromFile('Imagens/offline.jpg');
  end;
end;

end.
