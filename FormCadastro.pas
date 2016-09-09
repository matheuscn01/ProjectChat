unit FormCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFCadastro = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtCadastroUsuario: TEdit;
    edtCadastroSenha: TEdit;
    btnCadastrar: TButton;
    Label3: TLabel;
    edtConfirmacaooSenha: TEdit;
    labErro: TLabel;
    btnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtConfirmacaooSenhaChange(Sender: TObject);
    procedure edtCadastroSenhaChange(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure edtCadastroUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadastro: TFCadastro;

implementation

uses FMainClient, FormLogin, ModuleClient;

{$R *.dfm}

procedure TFCadastro.btnCadastrarClick(Sender: TObject);
begin
  With dmClient do
  begin
    if not (RtcClient.isConnected) then
      RtcClient.Connect();

    RtcClientModule.Prepare('InsereUsuario');
    RtcClientModule.Param['LOGIN'] := edtCadastroUsuario.Text;
    RtcClientModule.Param['SENHA'] := edtCadastroSenha.Text;
    RtcClientModule.Call(RtcResInsereUsuario);
  end;
end;

procedure TFCadastro.btnCancelarClick(Sender: TObject);
begin
  FCadastro.Close;
end;

procedure TFCadastro.edtCadastroSenhaChange(Sender: TObject);
begin
  if (edtCadastroSenha.Text <> edtConfirmacaooSenha.Text) then
  begin
    labErro.Visible := true;
    btnCadastrar.Enabled := false;
  end
  else
  begin
    labErro.Visible := false;
    btnCadastrar.Enabled := true;
  end;
end;

procedure TFCadastro.edtCadastroUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = '>') then
    Key := #0;
end;

procedure TFCadastro.edtConfirmacaooSenhaChange(Sender: TObject);
begin
  if (edtCadastroSenha.Text <> edtConfirmacaooSenha.Text) then
  begin
    labErro.Visible := true;
    btnCadastrar.Enabled := false;
  end
  else
  begin
    labErro.Visible := false;
    btnCadastrar.Enabled := true;
  end;
end;

procedure TFCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
