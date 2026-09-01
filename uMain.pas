unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDataModule, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, System.UITypes, System.Math,
  frxSmartMemo, frCoreClasses, frxClass;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    gridTetelek: TDBGrid;
    cboPartnerek: TDBLookupComboBox;
    //Amire nem hivatkozok a kódban, azt nem neveztem át
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    //-------------------
    edtCim: TEdit;
    edtEngedmeny: TEdit;
    cboTermekek: TDBLookupComboBox;
    edtMennyiseg: TEdit;
    edtEgysegar: TEdit;
    edtKedvEgyegar: TEdit;
    edtAfa: TEdit;
    edtNetto: TEdit;
    edtBrutto: TEdit;
    edtMegjegyzes: TEdit;
    btnHozzaad: TButton;
    btnTorles: TButton;
    btnModositas: TButton;
    btnMentes: TButton;
    btnKimutatas: TButton;
    procedure FormShow(Sender: TObject);
    procedure cboPartnerekClick(Sender: TObject);
    procedure cboTermekekClick(Sender: TObject);
    procedure edtMennyisegChange(Sender: TObject);
    procedure edtEngedmenyChange(Sender: TObject);
    procedure btnHozzaadClick(Sender: TObject);
    procedure btnTorlesClick(Sender: TObject);
    procedure GridOszlopokBeallitasa;
    procedure btnModositasClick(Sender: TObject);
    procedure btnMentesClick(Sender: TObject);
    procedure btnKimutatasClick(Sender: TObject);

  private
    FEditingID: Integer;
    procedure Szamolas;

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uLogin;



procedure TfrmMain.FormShow(Sender: TObject);
var
  lf: TfrmLogin;

  begin
    FEditingID := 0;

    if not dmMain.qryTetelek.Active then
        dmMain.qryTetelek.Open;

    GridOszlopokBeallitasa;

  end;



procedure TfrmMain.cboPartnerekClick(Sender: TObject);
var
  Cim: string;
  PartnerID: Integer;

  begin
    if not VarIsNull(cboPartnerek.KeyValue) and not VarIsEmpty(cboPartnerek.KeyValue) then

    begin
      PartnerID := cboPartnerek.KeyValue;
      // Kurzormozgatás a kiválasztott partnerre

      if dmMain.qryPartnerek.Locate('ID', PartnerID, []) then
        begin
          Cim := Format('%s %s, %s %s', [
            dmMain.qryPartnerek.FieldByName('IRANYITOSZAM').AsString,
            dmMain.qryPartnerek.FieldByName('TELEPULES').AsString,
            dmMain.qryPartnerek.FieldByName('UTCA').AsString,
            dmMain.qryPartnerek.FieldByName('HAZSZAM').AsString
            ]);

          edtCim.Text := Cim;
          edtEngedmeny.Text := dmMain.qryPartnerek.FieldByName('ENGEDMENY').AsString;
          Szamolas;

        end;

    end;

  end;



procedure TfrmMain.cboTermekekClick(Sender: TObject);
var
  TermekID: Integer;

  begin
    if not VarIsNull(cboTermekek.KeyValue) and not VarIsEmpty(cboTermekek.KeyValue) then

      begin
        TermekID := cboTermekek.KeyValue;
        // Kurzormozgatás a kiválasztott termékre

        if dmMain.qryTermekek.Locate('ID', TermekID, []) then

          begin
            edtEgysegar.Text := FormatFloat('0.00', dmMain.qryTermekek.FieldByName('ELADASI_EGYSEGAR').AsFloat);
            edtAfa.Text := dmMain.qryTermekek.FieldByName('AFA_KULCS').AsString;
            Szamolas;
          end;

      end;

  end;



procedure TfrmMain.edtMennyisegChange(Sender: TObject);
  begin
    Szamolas;
  end;



procedure TfrmMain.edtEngedmenyChange(Sender: TObject);
  begin
    Szamolas;
  end;



procedure TfrmMain.Szamolas;
var
  Mennyiseg, Egysegar, Engedmeny, AfaKulcs: Double;
  KedvEgysegar, Netto, Brutto: Double;



function StrToFloatSafe(const AText: string): Double;
var
S: string;

  begin
    S := StringReplace(Trim(AText), '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    S := StringReplace(S, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    Result := StrToFloatDef(S, 0);
  end;


  begin
    Mennyiseg  := StrToFloatSafe(edtMennyiseg.Text);
    Egysegar   := StrToFloatSafe(edtEgysegar.Text);
    Engedmeny  := StrToFloatSafe(edtEngedmeny.Text);
    AfaKulcs   := StrToFloatSafe(edtAfa.Text);

    // Kiszámítások kerekítéssel
    KedvEgysegar := SimpleRoundTo(Egysegar * (1 - (Engedmeny / 100.0)), -2);
    Netto        := SimpleRoundTo(Mennyiseg * KedvEgysegar, -2);
    Brutto       := SimpleRoundTo(Netto * (1 + (AfaKulcs / 100.0)), -2);

    edtKedvEgyegar.Text := FormatFloat('0.00', KedvEgysegar);
    edtNetto.Text        := FormatFloat('0.00', Netto);
    edtBrutto.Text       := FormatFloat('0.00', Brutto);
  end;



procedure TfrmMain.btnHozzaadClick(Sender: TObject);
var
  PartnerID, TermekID, AfaKulcs: Integer;
  Mennyiseg, Egysegar, Engedmeny: Double;
  KedvEgysegar, NettoErtek, AfaErtek, BruttoErtek: Double;
  MennyisegStr: string;

  begin

    if VarIsNull(cboPartnerek.KeyValue) or VarIsEmpty(cboPartnerek.KeyValue) or
       VarIsNull(cboTermekek.KeyValue) or VarIsEmpty(cboTermekek.KeyValue) then
      begin
        ShowMessage('Kérjük, válasszon partnert és terméket!');
        Exit;
      end;


    MennyisegStr := StringReplace(Trim(edtMennyiseg.Text), '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    MennyisegStr := StringReplace(MennyisegStr, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);


    if not TryStrToFloat(MennyisegStr, Mennyiseg) or (Mennyiseg <= 0) then
      begin
        ShowMessage('Kérjük, adjon meg érvényes, pozitív mennyiséget!');
        Exit;
      end;


    PartnerID := cboPartnerek.KeyValue;
    TermekID  := cboTermekek.KeyValue;


    if not dmMain.qryPartnerek.Locate('ID', PartnerID, []) then
      begin
        ShowMessage('A kiválasztott partner nem található az adatbázisban!');
        Exit;
      end;


    if not dmMain.qryTermekek.Locate('ID', TermekID, []) then
      begin
        ShowMessage('A kiválasztott termék nem található az adatbázisban!');
        Exit;
      end;


    Egysegar  := dmMain.qryTermekek.FieldByName('ELADASI_EGYSEGAR').AsFloat;
    AfaKulcs  := dmMain.qryTermekek.FieldByName('AFA_KULCS').AsInteger;
    Engedmeny := dmMain.qryPartnerek.FieldByName('ENGEDMENY').AsFloat;


    KedvEgysegar := SimpleRoundTo(Egysegar * (1 - (Engedmeny / 100.0)), -2);
    NettoErtek   := SimpleRoundTo(Mennyiseg * KedvEgysegar, -2);
    AfaErtek     := SimpleRoundTo(NettoErtek * (AfaKulcs / 100.0), -2);
    BruttoErtek  := NettoErtek + AfaErtek;


    dmMain.ADOConnection1.BeginTrans;


    try
      dmMain.cmdExec.CommandText :=
        'INSERT INTO Tetelek ' +
        '(PARTNER_ID, TERMEK_ID, MENNYISEG, EGYSEGAR, ENGEDMENY, KEDV_EGYSEGAR, ' +
        ' NETTO_ERTEK, AFA_KULCS, AFATERTEK, BRUTTO_ERTEK, MEGJEGYZES) ' +
        'VALUES ' +
        '(:PARTNER_ID, :TERMEK_ID, :MENNYISEG, :EGYSEGAR, :ENGEDMENY, :KEDV_EGYSEGAR, ' +
        ' :NETTO_ERTEK, :AFA_KULCS, :AFATERTEK, :BRUTTO_ERTEK, :MEGJEGYZES)';

      dmMain.cmdExec.Parameters.ParamByName('PARTNER_ID').Value   := PartnerID;
      dmMain.cmdExec.Parameters.ParamByName('TERMEK_ID').Value    := TermekID;
      dmMain.cmdExec.Parameters.ParamByName('MENNYISEG').Value     := Mennyiseg;
      dmMain.cmdExec.Parameters.ParamByName('EGYSEGAR').Value      := Egysegar;
      dmMain.cmdExec.Parameters.ParamByName('ENGEDMENY').Value     := Engedmeny;
      dmMain.cmdExec.Parameters.ParamByName('KEDV_EGYSEGAR').Value := KedvEgysegar;
      dmMain.cmdExec.Parameters.ParamByName('NETTO_ERTEK').Value   := NettoErtek;
      dmMain.cmdExec.Parameters.ParamByName('AFA_KULCS').Value     := AfaKulcs;
      dmMain.cmdExec.Parameters.ParamByName('AFATERTEK').Value     := AfaErtek;
      dmMain.cmdExec.Parameters.ParamByName('BRUTTO_ERTEK').Value  := BruttoErtek;
      dmMain.cmdExec.Parameters.ParamByName('MEGJEGYZES').Value   := Trim(edtMegjegyzes.Text);

      dmMain.cmdExec.Execute;
      dmMain.ADOConnection1.CommitTrans;

      if dmMain.qryTetelek.Active then
        dmMain.qryTetelek.Requery()
      else
        dmMain.qryTetelek.Open();

      edtMennyiseg.Text := '';
      edtMegjegyzes.Text := '';

      ShowMessage('Tétel sikeresen rögzítve!');

    except
      on E: Exception do
      begin
        if dmMain.ADOConnection1.InTransaction then
          dmMain.ADOConnection1.RollbackTrans;
        ShowMessage('Hiba a rögzítés során: ' + E.Message);
      end;

    end;

  end;



procedure TfrmMain.GridOszlopokBeallitasa;
var
  i: Integer;
  begin
    if not dmMain.qryTetelek.Active then Exit;

    // Rács beállításai a jobb olvashatóságért
    gridTetelek.Options := gridTetelek.Options + [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgRowSelect];

    // Egyedi oszlopszélességek és magyar fejlécek
    with gridTetelek do

      begin
        if Columns.Count < 12 then Exit; // Ellenõrzés a túlmutatás ellen

        Columns[0].Title.Caption := 'ID';
        Columns[0].Width := 40;

        Columns[1].Title.Caption := 'Partner';
        Columns[1].Width := 250;

        Columns[2].Title.Caption := 'Termék';
        Columns[2].Width := 210;

        Columns[3].Title.Caption := 'Mennyiség';
        Columns[3].Width := 75;

        Columns[4].Title.Caption := 'Egységár';
        Columns[4].Width := 70;

        Columns[5].Title.Caption := 'Eng. %';
        Columns[5].Width := 60;

        Columns[6].Title.Caption := 'Kedv. egységár';
        Columns[6].Width := 110;

        Columns[7].Title.Caption := 'Nettó érték';
        Columns[7].Width := 95;

        Columns[8].Title.Caption := 'ÁFA %';
        Columns[8].Width := 55;

        Columns[9].Title.Caption := 'ÁFA érték';
        Columns[9].Width := 85;

        Columns[10].Title.Caption := 'Bruttó érték';
        Columns[10].Width := 100;

        Columns[11].Title.Caption := 'Megjegyzés';
        Columns[11].Width := 200;
      end;

  end;



procedure TfrmMain.btnTorlesClick(Sender: TObject);
var
  TetelID: Integer;
  SqlCmd: string;

  begin
    if dmMain.qryTetelek.IsEmpty then
      begin
        ShowMessage('Nincs törölhetõ tétel a listában!');
        Exit;
      end;


    if MessageDlg('Biztosan törölni szeretné a kiválasztott tételt?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin
      TetelID := dmMain.qryTetelek.FieldByName('ID').AsInteger;

      dmMain.ADOConnection1.BeginTrans;
      try
        SqlCmd := Format('DELETE FROM Tetelek WHERE ID = %d', [TetelID]);
        dmMain.ADOConnection1.Execute(SqlCmd);

        dmMain.ADOConnection1.CommitTrans;

        if dmMain.qryTetelek.Active then
          dmMain.qryTetelek.Requery()
        else
          dmMain.qryTetelek.Open();

        ShowMessage('A tétel sikeresen törölve lett!');


      except
        on E: Exception do
          begin
            if dmMain.ADOConnection1.InTransaction then
              dmMain.ADOConnection1.RollbackTrans;
            ShowMessage('Hiba történt a törlés során: ' + sLineBreak + E.Message);
          end;

      end;

    end;

  end;



procedure TfrmMain.btnModositasClick(Sender: TObject);

  begin
    if dmMain.qryTetelek.IsEmpty then
      begin
        ShowMessage('Nincs kiválasztott tétel a módosításhoz!');
        Exit;
      end;

  // 1. Kijelölt tétel ID-jának eltárolása
  FEditingID := dmMain.qryTetelek.FieldByName('ID').AsInteger;


  // 2. Partner és termék kikeresése és kijelölése a comboboxokban
  if dmMain.qryPartnerek.Locate('NEV', dmMain.qryTetelek.FieldByName('Partner').AsString, []) then
    begin
      cboPartnerek.KeyValue := dmMain.qryPartnerek.FieldByName('ID').AsInteger;
      cboPartnerekClick(Self); // Cím és partner engedmény frissítése
    end;


  if dmMain.qryTermekek.Locate('MEGNEVEZES', dmMain.qryTetelek.FieldByName('Termek').AsString, []) then
    begin
      cboTermekek.KeyValue := dmMain.qryTermekek.FieldByName('ID').AsInteger;
      cboTermekekClick(Self); // Egységár és ÁFA frissítése
    end;


  // 3. Szerkeszthetõ mezõk feltöltése a kijelölt rekordból
  edtMennyiseg.Text  := dmMain.qryTetelek.FieldByName('MENNYISEG').AsString;
  edtEngedmeny.Text  := dmMain.qryTetelek.FieldByName('ENGEDMENY').AsString;
  edtMegjegyzes.Text := dmMain.qryTetelek.FieldByName('MEGJEGYZES').AsString;


  // 4. Számított mezõk frissítése
  Szamolas;


  ShowMessage('Módosítsa a kívánt mezõket (Mennyiség, Engedmény, Megjegyzés), majd kattintson a Mentés gombra!');

  end;



procedure TfrmMain.btnKimutatasClick(Sender: TObject);

  begin
    // 1. Az adatok lekérdezése
    dmMain.qryRiport.Close;
    dmMain.qryRiport.Open;

    if dmMain.qryRiport.IsEmpty then
      begin
        ShowMessage('Nincs megjeleníthetõ adat a kimutatáshoz!');
        Exit;
      end;

    // 2. FastReport elõnézet indítása
    dmMain.frxReport1.ShowReport();
  end;

procedure TfrmMain.btnMentesClick(Sender: TObject);
var
  Mennyiseg, Egysegar, Engedmeny: Double;
  KedvEgysegar, NettoErtek, AfaErtek, BruttoErtek: Double;
  AfaKulcs: Integer;
  MennyisegStr: string;

  begin

    if FEditingID <= 0 then
      begin
        ShowMessage('Nincs betöltve módosítandó tétel! Elõbb nyomja meg a Módosítás gombot!');
        Exit;
      end;

    MennyisegStr := StringReplace(Trim(edtMennyiseg.Text), '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    MennyisegStr := StringReplace(MennyisegStr, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);


    if not TryStrToFloat(MennyisegStr, Mennyiseg) or (Mennyiseg <= 0) then
      begin
        ShowMessage('Kérjük, adjon meg érvényes, pozitív mennyiséget!');
        Exit;
      end;

    Egysegar  := dmMain.qryTermekek.FieldByName('ELADASI_EGYSEGAR').AsFloat;
    AfaKulcs  := dmMain.qryTermekek.FieldByName('AFA_KULCS').AsInteger;
    Engedmeny := StrToFloatDef(StringReplace(edtEngedmeny.Text, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);


    // Számított mezõk újraszámolása
    KedvEgysegar := SimpleRoundTo(Egysegar * (1 - (Engedmeny / 100.0)), -2);
    NettoErtek   := SimpleRoundTo(Mennyiseg * KedvEgysegar, -2);
    AfaErtek     := SimpleRoundTo(NettoErtek * (AfaKulcs / 100.0), -2);
    BruttoErtek  := NettoErtek + AfaErtek;


    dmMain.ADOConnection1.BeginTrans;

    try
      dmMain.cmdExec.CommandText :=
        'UPDATE Tetelek SET ' +
        '  MENNYISEG = :MENNYISEG, ' +
        '  ENGEDMENY = :ENGEDMENY, ' +
        '  KEDV_EGYSEGAR = :KEDV_EGYSEGAR, ' +
        '  NETTO_ERTEK = :NETTO_ERTEK, ' +
        '  AFATERTEK = :AFATERTEK, ' +
        '  BRUTTO_ERTEK = :BRUTTO_ERTEK, ' +
        '  MEGJEGYZES = :MEGJEGYZES ' +
        'WHERE ID = :ID';

      dmMain.cmdExec.Parameters.ParamByName('MENNYISEG').Value     := Mennyiseg;
      dmMain.cmdExec.Parameters.ParamByName('ENGEDMENY').Value     := Engedmeny;
      dmMain.cmdExec.Parameters.ParamByName('KEDV_EGYSEGAR').Value := KedvEgysegar;
      dmMain.cmdExec.Parameters.ParamByName('NETTO_ERTEK').Value   := NettoErtek;
      dmMain.cmdExec.Parameters.ParamByName('AFATERTEK').Value     := AfaErtek;
      dmMain.cmdExec.Parameters.ParamByName('BRUTTO_ERTEK').Value  := BruttoErtek;
      dmMain.cmdExec.Parameters.ParamByName('MEGJEGYZES').Value   := Trim(edtMegjegyzes.Text);
      dmMain.cmdExec.Parameters.ParamByName('ID').Value          := FEditingID;

      dmMain.cmdExec.Execute;
      dmMain.ADOConnection1.CommitTrans;

      // Rács frissítése és mezeink alaphelyzetbe állítása
      dmMain.qryTetelek.Requery();
      FEditingID := 0;

      edtMennyiseg.Text := '';
      edtMegjegyzes.Text := '';

      ShowMessage('A tétel módosítása sikeresen elmentve!');

    except
      on E: Exception do
        begin
          if dmMain.ADOConnection1.InTransaction then
            dmMain.ADOConnection1.RollbackTrans;
          ShowMessage('Hiba a módosítás mentése során: ' + E.Message);
        end;

    end;

  end;

end.
