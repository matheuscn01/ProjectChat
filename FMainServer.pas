unit FMainServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtPort: TEdit;
    Label2: TLabel;
    edtAdress: TEdit;
    btnConect: TButton;
    labInfo: TLabel;
    procedure btnConectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Module;
{$R *.dfm}

procedure TForm1.btnConectClick(Sender: TObject);
begin
  With dmServer do
  Begin
    if RtcServer.isListening then
    Begin
      btnConect.Caption := 'Run';
      RtcServer.StopListen;
      labInfo.Caption := 'Server Offline';
    End
    else
    Begin
      btnConect.Caption := 'Stop';
      RtcServer.ServerAddr := edtAdress.Text;
      RtcServer.ServerPort := edtPort.Text;
      RtcServer.Listen();
      labInfo.Caption := 'Server Online';
    End;
  End
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  banco : string;
begin
  //GetDir(0,banco);
  //dmServer.DbChat.DatabaseName := '\\server-disk02\D:\Desenvolvimento\Estagio\Chat\Servidor\CHAT.FDB';
  //dmServer.DbChat.Connected := true;
end;

end.
