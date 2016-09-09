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
    btnHistorico: TButton;
    tabGrupo: TTabSheet;
    btnEnviarGrupo: TButton;
    mConversaGrupo: TMemo;
    mMensagemGrupo: TMemo;
    Label5: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    btnConectar: TButton;
    cbDestinatarios: TComboBox;
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
    procedure cbDestinatariosChange(Sender: TObject);
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
    if (btnConectar.Caption = 'Desconectar') then
    begin
      RtcClientModuleAux.Prepare('Offline');
      RtcClientModuleAux.Param['ID_USUARIO'] := IntToStr(id_usuario);
      RtcClientModuleAux.Call(RtcResOffline);

      Image1.Picture.LoadFromFile('Imagens/offline.jpg');
      online := false;
      Form1.Visible := false;
      RtcClient.Disconnect();
      FLogin := TFLogin.Create(Self);
      FLogin.ShowModal;
      cbDestinatarios.Items.Clear;
    end;
  end;
end;

procedure TForm1.btnEnviarClick(Sender: TObject);
begin
  if ((cbDestinatarios.Text <> IntToStr(id_usuario)) and (cbDestinatarios.Text <> '')
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
          RtcClientModule.Param['ID_DESTINATARIO'] := cbDestinatarios.Text;
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
  if not(cbDestinatarios.Text = '') then
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
        RtcClientModule.Param['ID_USUARIO2'] := cbDestinatarios.Text;
        RtcClientModule.Call(RtcResCarregaHistorico);
      end;
    end;
  end
  else
    ShowMessage('Informe um Destinatario!');
end;

procedure TForm1.cbDestinatariosChange(Sender: TObject);
begin
  mConversa.Lines.Clear;
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

  TimerCarregarMensagem.Enabled := true;
  TimerCarregarMensagemGrupo.Enabled := true;
  With dmClient.RtcClientModule do
  begin
    Prepare('CarregaUsuarios');
    Param['ID_USUARIO'] := id_usuario;
    Call(dmClient.RtcResCarregaUsuarios);
  end;
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
  if(cbDestinatarios.Text <> '') then
  begin
    TimerCarregarMensagem.Enabled := false;
    With dmClient do
    begin
      RtcClientModule.Prepare('CarregarMensagens');
      RtcClientModule.Param['ID_USUARIO'] := IntToStr(id_usuario);
      RtcClientModule.Param['DESTINATARIO'] := cbDestinatarios.Text;
      RtcClientModule.Call(RtcResCarregarMsg);

      RtcClientModuleAux.Prepare('VerificaOnline');
      RtcClientModuleAux.Param['ID_DESTINATARIO'] := cbDestinatarios.Text;
      RtcClientModuleAux.Call(RtcResVerificaOline);
    end;
  end;
end;

end.
