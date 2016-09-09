unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    btnEntrar: TButton;
    labCadastro: TLabel;
    labErro: TLabel;
    procedure labCadastroMouseEnter(Sender: TObject);
    procedure labCadastroMouseLeave(Sender: TObject);
    procedure labCadastroClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure ProcLogou(Sender: TObject);
  private

  public
    logou: boolean;
  end;

var
  FLogin: TFLogin;

implementation

uses
  FormCadastro, FMainClient, ModuleClient;
{$R *.dfm}

//Botão para Logar
procedure TFLogin.btnEntrarClick(Sender: TObject);
begin
  With dmClient do
  begin
    if not (RtcClient.isConnected) then
      RtcClient.Connect();

    RtcClientModule.Prepare('Online');
    RtcClientModule.Param['LOGIN'] := edtLogin.Text;
    RtcClientModule.Param['SENHA'] := edtSenha.Text;
    RtcClientModule.Call(RtcResOnline);
  end;
end;

//Liberar o Form da Memória
procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if (logou) then
    Form1.Visible := true;
end;

//Boolean de Login
procedure TFLogin.FormCreate(Sender: TObject);
begin
  logou := false;
end;

//Abrir o Form para cadastro
procedure TFLogin.labCadastroClick(Sender: TObject);
begin
  FCadastro := TFCadastro.Create(Self);
  FCadastro.ShowModal;
end;

//Altera o Cursor
procedure TFLogin.labCadastroMouseEnter(Sender: TObject);
begin
  labCadastro.Cursor := crHandPoint;
end;

//Altera o Cursor
procedure TFLogin.labCadastroMouseLeave(Sender: TObject);
begin
  labCadastro.Cursor := crDefault;
end;

//Fechar o FormLogin
procedure TFLogin.ProcLogou(Sender: TObject);
begin
  FLogin.Close;
end;

end.
