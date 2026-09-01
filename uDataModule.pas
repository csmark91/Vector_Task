unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, System.Math, Data.DB, Data.Win.ADODB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  frxSmartMemo, frxClass, frCoreClasses, frxDBSet;

type
  TdmMain = class(TDataModule)
    ADOConnection1: TADOConnection;
    qryPartnerek: TADOQuery;
    qryTermekek: TADOQuery;
    qryTetelek: TADOQuery;
    dsPartnerek: TDataSource;
    dsTermekek: TDataSource;
    dsTetelek: TDataSource;
    cmdExec: TADOCommand;
    qryRiport: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryTetelekBeforePost(DataSet: TDataSet);

  private
    { Private declarations }

  public
    function ConnectToDatabase(const AServer, ADatabase, AUser, APassword: string): Boolean;

  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMain.DataModuleCreate(Sender: TObject);
  begin
    // DFM szinkronizációhoz szükséges
  end;

function TdmMain.ConnectToDatabase(const AServer, ADatabase, AUser, APassword: string): Boolean;
var
  ConnStr: string;
  i: Integer;

  begin
    Result := False;

    // 1. Ha nyitva van a kapcsolat, lezárjuk
    if ADOConnection1.Connected then
      ADOConnection1.Close;


    // 2. Kapcsoljuk a lekérdezéseket és a parancs komponenst a kapcsolathoz
    qryPartnerek.Connection := ADOConnection1;
    qryTermekek.Connection  := ADOConnection1;
    qryTetelek.Connection   := ADOConnection1;
    cmdExec.Connection      := ADOConnection1;


    // Rácsok helyének beállítása futásidõben
    qryTetelek.CursorLocation := clUseClient;
    qryTetelek.LockType       := ltOptimistic;


    // 3. Elsõdleges próbálkozás MSOLEDBSQL meghajtóval
    ConnStr := Format(
      'Provider=MSOLEDBSQL;' +
      'Data Source=%s;' +
      'Initial Catalog=%s;' +
      'User ID=%s;' +
      'Password=%s;' +
      'DataTypeCompatibility=80;',
      [AServer, ADatabase, AUser, APassword]
      );

    ADOConnection1.ConnectionString := ConnStr;
    ADOConnection1.LoginPrompt := False;


    try
      ADOConnection1.Open;
    except
      on E: Exception do
        begin
          // 4. Ha az MSOLEDBSQL hiányzik, lezárjuk a hibás kapcsolatot és megpróbáljuk az SQLOLEDB-t
          if ADOConnection1.Connected then
            ADOConnection1.Close;


          ConnStr := Format(
            'Provider=SQLOLEDB;' +
            'Data Source=%s;' +
            'Initial Catalog=%s;' +
            'User ID=%s;' +
            'Password=%s;',
            [AServer, ADatabase, AUser, APassword]
            );
          ADOConnection1.ConnectionString := ConnStr;


          try
            ADOConnection1.Open;
          except
            on E2: Exception do
              raise Exception.Create('Sikertelen csatlakozás az adatbázishoz: ' + E2.Message);
          end;

        end;

    end;



    // 5. Ha felépült a kapcsolat, megnyitjuk a lekérdezéseket
    if ADOConnection1.Connected then
      begin
        try
          qryPartnerek.SQL.Text := 'SELECT ID, NEV, IRANYITOSZAM, TELEPULES, UTCA, HAZSZAM, ENGEDMENY FROM Partnerek ORDER BY NEV';
          qryPartnerek.Open;

          qryTermekek.SQL.Text := 'SELECT ID, CIKKSZAM, MEGNEVEZES, AFA_KULCS, ELADASI_EGYSEGAR FROM Termekek ORDER BY MEGNEVEZES';
          qryTermekek.Open;


          qryTetelek.SQL.Text :=
            'SELECT t.ID, p.NEV AS Partner, term.MEGNEVEZES AS Termek, t.MENNYISEG, ' +
            't.EGYSEGAR, t.ENGEDMENY, t.KEDV_EGYSEGAR, t.NETTO_ERTEK, t.AFA_KULCS, ' +
            't.AFATERTEK, t.BRUTTO_ERTEK, t.MEGJEGYZES, t.ROGZITVE ' +
            'FROM Tetelek t ' +
            'INNER JOIN Partnerek p ON t.PARTNER_ID = p.ID ' +
            'INNER JOIN Termekek term ON t.TERMEK_ID = term.ID ' +
            'ORDER BY t.ID ASC';
          qryTetelek.Open;


          // ADO JOIN mentési hely kijelölése
          qryTetelek.Properties['Unique Table'].Value := 'Tetelek';


          // Eseménykezelõ társítása
          qryTetelek.BeforePost := qryTetelekBeforePost;


          // Zárolások pontosítása: A szerkeszthetõ és újraszámolt nem "read-only" mezõk
          for i := 0 to qryTetelek.FieldCount - 1 do
            begin

              if not SameText(qryTetelek.Fields[i].FieldName, 'MENNYISEG') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'ENGEDMENY') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'MEGJEGYZES') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'KEDV_EGYSEGAR') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'NETTO_ERTEK') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'AFATERTEK') and
                 not SameText(qryTetelek.Fields[i].FieldName, 'BRUTTO_ERTEK') then
                qryTetelek.Fields[i].ReadOnly := True;

            end;

          Result := True;

        except
          on E: Exception do
            raise Exception.Create('Hiba a lekérdezések megnyitása során: ' + E.Message);
        end;

      end;

  end;



procedure TdmMain.qryTetelekBeforePost(DataSet: TDataSet);
var
  Egysegar, Mennyiseg, Engedmeny: Double;
  KedvEgysegar, NettoErtek, AfaErtek, BruttoErtek: Double;
  AfaKulcs: Integer;

  begin
    // Adatok kiolvasása a módosítás alatt álló rekordból
    Egysegar  := DataSet.FieldByName('EGYSEGAR').AsFloat;
    Mennyiseg := DataSet.FieldByName('MENNYISEG').AsFloat;
    Engedmeny := DataSet.FieldByName('ENGEDMENY').AsFloat;
    AfaKulcs  := DataSet.FieldByName('AFA_KULCS').AsInteger;

    // Újraszámolások 2 tizedesjegyre kerekítve
    KedvEgysegar := SimpleRoundTo(Egysegar * (1 - (Engedmeny / 100.0)), -2);
    NettoErtek   := SimpleRoundTo(Mennyiseg * KedvEgysegar, -2);
    AfaErtek     := SimpleRoundTo(NettoErtek * (AfaKulcs / 100.0), -2);
    BruttoErtek  := NettoErtek + AfaErtek;

    // Számított mezõk frissítése a Dataset-ben
    DataSet.FieldByName('KEDV_EGYSEGAR').AsFloat := KedvEgysegar;
    DataSet.FieldByName('NETTO_ERTEK').AsFloat   := NettoErtek;
    DataSet.FieldByName('AFATERTEK').AsFloat     := AfaErtek;
    DataSet.FieldByName('BRUTTO_ERTEK').AsFloat  := BruttoErtek;
  end;

end.
