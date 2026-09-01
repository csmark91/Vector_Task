object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Bejelentkez'#233's'
  ClientHeight = 297
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblServer: TLabel
    Left = 39
    Top = 32
    Width = 68
    Height = 15
    Caption = 'Szerver neve:'
  end
  object lblDatabase: TLabel
    Left = 192
    Top = 32
    Width = 82
    Height = 15
    Caption = 'Adatb'#225'zis neve:'
  end
  object lblUser: TLabel
    Left = 122
    Top = 96
    Width = 64
    Height = 15
    Caption = 'Felhaszn'#225'l'#243':'
  end
  object lblPassword: TLabel
    Left = 122
    Top = 159
    Width = 33
    Height = 15
    Caption = 'Jelsz'#243':'
  end
  object edtServer: TEdit
    Left = 39
    Top = 53
    Width = 75
    Height = 23
    TabOrder = 0
    Text = 'localhost'
  end
  object edtDatabase: TEdit
    Left = 192
    Top = 53
    Width = 82
    Height = 23
    TabOrder = 1
    Text = 'VectorDB'
  end
  object edtUser: TEdit
    Left = 122
    Top = 117
    Width = 71
    Height = 23
    TabOrder = 2
    Text = 'dbuser'
  end
  object edtPassword: TEdit
    Left = 122
    Top = 180
    Width = 71
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
    Text = 'dbuser'
  end
  object btnLogin: TButton
    Left = 39
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Bel'#233'p'#233's'
    Default = True
    TabOrder = 4
    OnClick = btnLoginClick
  end
  object btnCancel: TButton
    Left = 199
    Top = 236
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'M'#233'gse'
    ModalResult = 2
    TabOrder = 5
  end
end
