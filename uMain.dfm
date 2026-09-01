object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'F'#337'oldal'
  ClientHeight = 617
  ClientWidth = 1199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1199
    Height = 265
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1197
    object Label1: TLabel
      Left = 65
      Top = 24
      Width = 38
      Height = 15
      Caption = 'Partner'
    end
    object Label2: TLabel
      Left = 217
      Top = 26
      Width = 38
      Height = 15
      Caption = 'Term'#233'k'
    end
    object Label3: TLabel
      Left = 401
      Top = 26
      Width = 58
      Height = 15
      Caption = 'Mennyis'#233'g'
    end
    object Label4: TLabel
      Left = 65
      Top = 96
      Width = 67
      Height = 15
      Caption = 'Partner c'#237'me'
    end
    object Label5: TLabel
      Left = 488
      Top = 26
      Width = 65
      Height = 15
      Caption = 'Egys'#233'g'#225'r(Ft)'
    end
    object Label6: TLabel
      Left = 401
      Top = 98
      Width = 63
      Height = 15
      Caption = 'Engedm'#233'ny'
    end
    object Label7: TLabel
      Left = 311
      Top = 173
      Width = 59
      Height = 15
      Caption = 'Nett'#243' '#233'rt'#233'k'
    end
    object Label8: TLabel
      Left = 488
      Top = 98
      Width = 146
      Height = 15
      Caption = 'Kedvezm'#233'nyes egys'#233'g'#225'r(Ft)'
    end
    object Label9: TLabel
      Left = 419
      Top = 173
      Width = 45
      Height = 15
      Caption = #193'fakulcs'
    end
    object Label10: TLabel
      Left = 65
      Top = 168
      Width = 62
      Height = 15
      Caption = 'Megjegyz'#233's'
    end
    object Label11: TLabel
      Left = 488
      Top = 173
      Width = 62
      Height = 15
      Caption = 'Brutt'#243' '#233'rt'#233'k'
    end
    object cboPartnerek: TDBLookupComboBox
      Left = 65
      Top = 47
      Width = 129
      Height = 23
      KeyField = 'ID'
      ListField = 'NEV'
      ListSource = dmMain.dsPartnerek
      TabOrder = 0
      OnClick = cboPartnerekClick
    end
    object edtCim: TEdit
      Left = 65
      Top = 119
      Width = 305
      Height = 23
      TabOrder = 1
    end
    object edtEngedmeny: TEdit
      Left = 401
      Top = 119
      Width = 58
      Height = 23
      TabOrder = 2
      OnChange = edtEngedmenyChange
    end
    object cboTermekek: TDBLookupComboBox
      Left = 217
      Top = 47
      Width = 153
      Height = 23
      KeyField = 'ID'
      ListField = 'MEGNEVEZES'
      ListSource = dmMain.dsTermekek
      TabOrder = 3
      OnClick = cboTermekekClick
    end
    object edtMennyiseg: TEdit
      Left = 401
      Top = 47
      Width = 58
      Height = 23
      TabOrder = 4
      Text = '1'
      OnChange = edtMennyisegChange
    end
    object edtEgysegar: TEdit
      Left = 488
      Top = 47
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 5
    end
    object edtKedvEgyegar: TEdit
      Left = 488
      Top = 119
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 6
    end
    object edtAfa: TEdit
      Left = 419
      Top = 194
      Width = 45
      Height = 23
      TabOrder = 7
    end
    object edtNetto: TEdit
      Left = 311
      Top = 194
      Width = 72
      Height = 23
      ReadOnly = True
      TabOrder = 8
    end
    object edtBrutto: TEdit
      Left = 488
      Top = 194
      Width = 97
      Height = 23
      ReadOnly = True
      TabOrder = 9
    end
    object edtMegjegyzes: TEdit
      Left = 65
      Top = 194
      Width = 224
      Height = 23
      TabOrder = 10
    end
    object btnHozzaad: TButton
      Left = 696
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Hozz'#225'ad'#225's'
      TabOrder = 11
      OnClick = btnHozzaadClick
    end
    object btnTorles: TButton
      Left = 696
      Top = 92
      Width = 75
      Height = 25
      Caption = 'T'#246'rl'#233's'
      TabOrder = 12
      OnClick = btnTorlesClick
    end
    object btnModositas: TButton
      Left = 696
      Top = 144
      Width = 75
      Height = 25
      Caption = 'M'#243'dos'#237't'#225's'
      TabOrder = 13
      OnClick = btnModositasClick
    end
    object btnMentes: TButton
      Left = 696
      Top = 193
      Width = 75
      Height = 25
      Caption = 'Ment'#233's'
      TabOrder = 14
      OnClick = btnMentesClick
    end
    object btnKimutatas: TButton
      Left = 872
      Top = 118
      Width = 75
      Height = 25
      Caption = 'Kimutat'#225's'
      TabOrder = 15
      OnClick = btnKimutatasClick
    end
  end
  object gridTetelek: TDBGrid
    Left = 0
    Top = 265
    Width = 1199
    Height = 352
    Align = alClient
    DataSource = dmMain.dsTetelek
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
