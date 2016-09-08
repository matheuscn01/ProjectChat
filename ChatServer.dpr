program ChatServer;

uses
  Forms,
  FMainServer in 'FMainServer.pas' {Form1},
  Module in 'Module.pas' {dmServer: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmServer, dmServer);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
