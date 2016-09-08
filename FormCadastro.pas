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
    procedure edtCadastroSenhaExit(Sender: TObject);
    procedure edtConfirmacaooSenhaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
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

procedure TFCadastro.btnCancelarClick(Sender: TObject);
begin
  FCadastro.Close;
end;

procedure TFCadastro.edtCadastroSenhaExit(Sender: TObject);
begin
  if (edtCadastroSenha.Text <> edtConfirmacaooSenha.Text) then
    labErro.Visible := true
  else
    labErro.Visible := false;
end;

procedure TFCadastro.edtConfirmacaooSenhaExit(Sender: TObject);
begin
  if (edtCadastroSenha.Text <> edtConfirmacaooSenha.Text) then
    labErro.Visible := true
  else
    labErro.Visible := false;
end;

procedure TFCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
