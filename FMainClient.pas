unit FMainClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, jpeg;

type
  TForm1 = class(TForm)
    TimerCarregarMensagem: TTimer;
    TimerCarregarMensagemGrupo: TTimer;
    PageControl1: TPageControl;
    TabConversa: TTabSheet;
    Label4: TLabel;
    labinfo: TLabel;
    btnEnviar: TButton;
    mMensagem: TMemo;
    mConversa: TMemo;
    edtDestinatario: TEdit;
    btnHistorico: TButton;
    tabGrupo: TTabSheet;
    btnEnviarGrupo: TButton;
    mConversaGrupo: TMemo;
    mMensagemGrupo: TMemo;
    Label5: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtPort: TEdit;
    edtEndereco: TEdit;
    btnConectar: TButton;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure TimerCarregarMensagemTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mMensagemKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnviarGrupoClick(Sender: TObject);
    procedure TimerCarregarMensagemGrupoTimer(Sender: TObject);
    procedure mMensagemGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure TabConversaShow(Sender: TObject);
    procedure edtDestinatarioChange(Sender: TObject);
    procedure Abrir(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabGrupoShow(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    online: boolean;
    id_usuario: integer;
    login: string;
  end;

var
  Form1: TForm1;

implementation

uses
  ModuleClient, FormLogin, FormCadastro;
{$R *.dfm}

procedure TForm1.Abrir(Sender: TObject);
begin
  Form1.WindowState := wsNormal;
  Application.BringToFront;
end;

procedure TForm1.btnConectarClick(Sender: TObject);
begin
  With dmClient do
  begin
    if not((IntToStr(id_usuario) = '') or (edtEndereco.Text = '') or (edtPort.Text = '')) then
    begin
      if (btnConectar.Caption = 'Conectar') then
      begin
        RtcClient.ServerAddr := edtEndereco.Text;
        RtcClient.ServerPort := edtPort.Text;
        RtcClientModule.ModuleHost := edtEndereco.Text;
        RtcClientModuleAux.ModuleHost := edtEndereco.Text;
        RtcClient.Connect();
        if not(online) then
        begin
          RtcClientModule.Prepare('Online');
          RtcClientModule.Param['ID_USUARIO'] := IntToStr(id_usuario);
          RtcClientModule.Call(RtcResOnline);
          online := true;
        end;
        btnConectar.Caption := 'Desconectar';
        Image1.Visible := true;
        LabInfo.Visible := true;
        Label1.Enabled := false;
        Label2.Enabled := false;
        edtEndereco.Enabled := false;
        edtPort.Enabled := false;
        Label4.Enabled := true;
        edtDestinatario.Enabled := true;
        mConversa.Enabled := true;
        mConversaGrupo.Enabled := true;
        mMensagem.Enabled := true;
        mMensagemGrupo.Enabled := true;
        btnEnviar.Enabled := true;
        btnHistorico.Enabled := true;
        btnEnviarGrupo.Enabled := true;
        TimerCarregarMensagem.Enabled := true;
        TimerCarregarMensagemGrupo.Enabled := true;
      end
      else if (btnConectar.Caption = 'Desconectar') then
      begin
        RtcClient.Disconnect();

        RtcClientModuleAux.Prepare('Offline');
        RtcClientModuleAux.Param['ID_USUARIO'] := IntToStr(id_usuario);
        RtcClientModuleAux.Call(RtcResOffline);

        Image1.Picture.LoadFromFile('Imagens/offline.jpg');
        Image1.Visible := false;
        LabInfo.Visible := false;
        btnConectar.Caption := 'Conectar';
        Label1.Enabled := true;
        Label2.Enabled := true;
        edtEndereco.Enabled := true;
        edtPort.Enabled := true;
        Label4.Enabled := false;
        edtDestinatario.Enabled := false;
        mConversa.Enabled := false;
        mConversaGrupo.Enabled := false;
        mMensagem.Enabled := false;
        mMensagemGrupo.Enabled := false;
        btnEnviar.Enabled := false;
        btnHistorico.Enabled := false;
        btnEnviarGrupo.Enabled := false;
        TimerCarregarMensagem.Enabled := false;
        TimerCarregarMensagemGrupo.Enabled := false;
      end;
    end
    else
      showMessage('Campos Inválidos!');
  end;
end;

procedure TForm1.btnEnviarClick(Sender: TObject);
begin
  if ((edtDestinatario.Text <> IntToStr(id_usuario)) and (edtDestinatario.Text <> '')
    ) then
  begin
    With dmClient do
    begin
      if not(RtcClient.isConnected) then
        ShowMessage('Você está Offline')
      else
      begin
        if (mMensagem.Lines[0] <> '') then
        begin
          RtcClientModule.Prepare('EnviarMsg');
          RtcClientModule.Param['MENSAGEM'] := mMensagem.Lines.Text;
          RtcClientModule.Param['ID_REMETENTE'] := IntToStr(id_usuario);
          RtcClientModule.Param['ID_DESTINATARIO'] := edtDestinatario.Text;
          RtcClientModule.Call(RtcResEnviarMsg);

          mMensagem.Clear;
        end;
      end;
    end;
  end
  else
    ShowMessage('Destinatario Inválido');
end;

procedure TForm1.btnHistoricoClick(Sender: TObject);
begin
  if not(edtDestinatario.Text = '') then
  begin
    With dmClient do
    begin
      if not(RtcClient.isConnected) then
        ShowMessage('Você está Offline')
      else
      begin
        mConversa.Lines.Clear;
        RtcClientModule.Prepare('CarregaHistorico');
        RtcClientModule.Param['ID_USUARIO1'] := IntToStr(id_usuario);
        RtcClientModule.Param['ID_USUARIO2'] := edtDestinatario.Text;
        RtcClientModule.Call(RtcResCarregaHistorico);
      end;
    end;
  end
  else
    ShowMessage('Informe um Destinatario!');
end;

procedure TForm1.edtDestinatarioChange(Sender: TObject);
begin
  mConversa.Lines.Clear;
end;

procedure TForm1.btnEnviarGrupoClick(Sender: TObject);
begin
  With dmClient do
  begin
    if not(RtcClient.isConnected) then
      ShowMessage('Você está Offline')
    else
    begin
      if (mMensagemGrupo.Lines[0] <> '') then
      begin
        RtcClientModule.Prepare('EnviarMsgGrupo');
        RtcClientModule.Param['MENSAGEM'] := mMensagemGrupo.Lines.Text;
        RtcClientModule.Param['ID_REMETENTE'] := IntToStr(id_usuario);
        RtcClientModule.Call(RtcResEnviarMsgGrupo);

        mMensagemGrupo.Clear;
      end;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  With dmClient do
  begin
    RtcClientModuleAux.Prepare('Offline');
    RtcClientModuleAux.Param['ID_USUARIO'] := IntToStr(id_usuario);
    RtcClientModuleAux.Call(RtcResOffline);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TimerCarregarMensagem.Enabled := false;
  online := false;
  FLogin := TFLogin.Create(Self);
  FLogin.ShowModal;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not (FLogin.logou) then
    Close;
end;

procedure TForm1.mMensagemGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    btnEnviarGrupoClick(Sender);
    Key := #0;
  end;
end;

procedure TForm1.mMensagemKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    btnEnviarClick(Sender);
    Key := #0;
  end;
end;

procedure TForm1.TabConversaShow(Sender: TObject);
begin
  if not(dmClient.notificacao = 0) then
    TabConversa.Caption := 'Privado';

  dmClient.notificacao := 0;
end;

procedure TForm1.tabGrupoShow(Sender: TObject);
begin
  if not(dmClient.notificacaoGrupo = 0) then
    TabConversa.Caption := 'Grupo';

  dmClient.notificacao := 0;
end;

procedure TForm1.TimerCarregarMensagemGrupoTimer(Sender: TObject);
begin
  TimerCarregarMensagemGrupo.Enabled := false;
  With dmClient do
  begin
    RtcClientModule.Prepare('CarregarMensagensGrupo');
    RtcClientModule.Param['ID_USUARIO'] := IntToStr(id_usuario);
    RtcClientModule.Call(RtcResCarregarMsgGrupo);
  end;
end;

procedure TForm1.TimerCarregarMensagemTimer(Sender: TObject);
begin
  TimerCarregarMensagem.Enabled := false;
  With dmClient do
  begin
    RtcClientModule.Prepare('CarregarMensagens');
    RtcClientModule.Param['ID_USUARIO'] := IntToStr(id_usuario);
    RtcClientModule.Param['ID_DESTINATARIO'] := edtDestinatario.Text;
    RtcClientModule.Call(RtcResCarregarMsg);

    if (edtDestinatario.Text <> '') then
    begin
      RtcClientModuleAux.Prepare('VerificaOnline');
      RtcClientModuleAux.Param['ID_DESTINATARIO'] := edtDestinatario.Text;
      RtcClientModuleAux.Call(RtcResVerificaOline);
    end;
  end;
end;

end.
