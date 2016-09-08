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

procedure TFLogin.btnEntrarClick(Sender: TObject);
begin
  With dmClient do
  begin
    RtcClient.Connect();
    //tenta logar
    RtcClientModule.Prepare('Online');
    RtcClientModule.Param['LOGIN'] := edtLogin.Text;
    RtcClientModule.Param['SENHA'] := edtSenha.Text;
    RtcClientModule.Call(RtcResOnline);
  end;

  if logou then
    FLogin.Close
  else
  begin
    edtSenha.Text := '';
  end;
end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFLogin.FormCreate(Sender: TObject);
begin
  logou := false;
end;

procedure TFLogin.labCadastroClick(Sender: TObject);
begin
  FCadastro := TFCadastro.Create(Self);
  FCadastro.ShowModal;
end;

procedure TFLogin.labCadastroMouseEnter(Sender: TObject);
begin
  labCadastro.Cursor := crHandPoint;
end;

procedure TFLogin.labCadastroMouseLeave(Sender: TObject);
begin
  labCadastro.Cursor := crDefault;
end;

procedure TFLogin.ProcLogou(Sender: TObject);
begin
  FLogin.Close;
end;

end.
