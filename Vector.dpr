program Vector;

uses
  Vcl.Forms,
  Vcl.Controls,
  uMain in 'uMain.pas' {frmMain},
  uDataModule in 'uDataModule.pas' {dmMain: TDataModule},
  uLogin in 'uLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  // 1. Létrehozzuk a DataModule-t a memóriában
  Application.CreateForm(TdmMain, dmMain);

  // 2. Megjelenítjük a Login ablakot
  frmLogin := TfrmLogin.Create(nil);

  try

    if frmLogin.ShowModal = mrOk then
      begin
        // 3. Ha sikeres volt a login, létrehozzuk és elindítjuk a Fõablakot
        Application.CreateForm(TfrmMain, frmMain);
        Application.Run;
      end;

  finally
    frmLogin.Free;

  end;

end.
