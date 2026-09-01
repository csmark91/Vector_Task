unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDataModule;

type
  TfrmLogin = class(TForm)
    lblServer: TLabel;
    lblDatabase: TLabel;
    lblUser: TLabel;
    lblPassword: TLabel;
    edtServer: TEdit;
    edtDatabase: TEdit;
    edtUser: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnCancel: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);

  begin
    if Trim(edtServer.Text) = '' then
      begin
        ShowMessage('Kérjük, adja meg a szerver nevét!');
        edtServer.SetFocus;
        Exit;
      end;


    if Trim(edtDatabase.Text) = '' then
      begin
        ShowMessage('Kérjük, adja meg az adatbázis nevét!');
        edtDatabase.SetFocus;
        Exit;
      end;


    // Csatlakozás az adatbázishoz a DataModule segítségével
    if dmMain.ConnectToDatabase(edtServer.Text, edtDatabase.Text, edtUser.Text, edtPassword.Text) then
      begin
        ModalResult := mrOk; // Sikeres csatlakozás esetén bezárjuk a login ablakot OK eredménnyel
      end;
  end;



procedure TfrmLogin.btnCancelClick(Sender: TObject);

  begin
    ModalResult := mrCancel; // Megszakítás esetén bezárjuk az ablakot Cancel eredménnyel
  end;

end.
