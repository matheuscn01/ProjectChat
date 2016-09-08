program Client;

uses
  Forms,
  FMainClient in 'FMainClient.pas' {Form1},
  ModuleClient in 'ModuleClient.pas' {dmClient: TDataModule},
  FormLogin in 'FormLogin.pas' {FLogin},
  FormCadastro in 'FormCadastro.pas' {FCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmClient, dmClient);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
