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
    RtcResInsereUsuario: TRtcResult;
    RtcResCarregaUsuarios: TRtcResult;
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
    procedure RtcResInsereUsuarioReturn(Sender: TRtcConnection; Data, Result: TRtcValue);
    procedure RtcResCarregaUsuariosReturn(Sender: TRtcConnection; Data,
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
  showMessage('Falha ao conectar ao endereço 192.168.0.58 na porta 81');
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

procedure TdmClient.RtcResCarregaUsuariosReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
var
  usuarios, usuario: string;
  I: integer;
begin
  usuarios := Result.asString;
  for I := 1 to length(usuarios) do
  begin
    if (usuarios[I] <> '>') then
      usuario :=  usuario + usuarios[I]
    else
    begin
      Form1.cbDestinatarios.Items.Add(usuario);
      usuario := '';
    end;
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
  resultado: string;
  P : PChar;
begin
  resultado := Result.asString;
  p := PChar(resultado);
  if (p^ in ['0' .. '9']) then
  begin
    Form1.id_usuario := StrToInt(resultado);
    FLogin.logou := true;
    FLogin.ProcLogou(Sender);
  end
  else
    FLogin.labErro.Caption := Result.asString;
end;

procedure TdmClient.RtcResInsereUsuarioReturn(Sender: TRtcConnection; Data,
  Result: TRtcValue);
begin
  showMessage(Result.asString);
  if (Result.asString = 'Usuário cadastrado') then
    FormCadastro.FCadastro.Close;
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
