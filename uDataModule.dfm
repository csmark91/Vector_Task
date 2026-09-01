object dmMain: TdmMain
  OnCreate = DataModuleCreate
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSOLEDBSQL.1;Persist Security Info=False;User ID=dbuser' +
      ';Initial Catalog=VectorDB;Data Source=localhost;Initial File Nam' +
      'e="";Server SPN="";Authentication="";Access Token="";'
    LoginPrompt = False
    Provider = 'MSOLEDBSQL.1'
    Left = 168
    Top = 56
  end
  object qryPartnerek: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 160
  end
  object qryTermekek: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 272
  end
  object qryTetelek: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    BeforePost = qryTetelekBeforePost
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '    t.ID,'
      '    p.NEV AS Partner,'
      '    term.MEGNEVEZES AS Termek,'
      '    t.MENNYISEG,'
      '    t.EGYSEGAR,'
      '    t.ENGEDMENY,'
      '    t.KEDV_EGYSEGAR,'
      '    t.NETTO_ERTEK,'
      '    t.AFA_KULCS,'
      '    t.AFATERTEK,'
      '    t.BRUTTO_ERTEK,'
      '    t.MEGJEGYZES,'
      '    t.ROGZITVE'
      'FROM Tetelek t'
      'INNER JOIN Partnerek p ON t.PARTNER_ID = p.ID'
      'INNER JOIN Termekek term ON t.TERMEK_ID = term.ID'
      'ORDER BY t.ID ASC')
    Left = 56
    Top = 400
  end
  object dsPartnerek: TDataSource
    DataSet = qryPartnerek
    Left = 264
    Top = 168
  end
  object dsTermekek: TDataSource
    DataSet = qryTermekek
    Left = 264
    Top = 272
  end
  object dsTetelek: TDataSource
    DataSet = qryTetelek
    Left = 264
    Top = 400
  end
  object cmdExec: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 152
    Top = 528
  end
  object qryRiport: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  p.ID AS PartnerID,'
      '  p.NEV AS PartnerNev,'
      
        '  CONCAT(p.IRANYITOSZAM, '#39' '#39', p.TELEPULES, '#39', '#39', p.UTCA, '#39' '#39', p.' +
        'HAZSZAM) AS PartnerCim,'
      '  term.CIKKSZAM AS Cikkszam,'
      '  term.MEGNEVEZES AS CikkNev,'
      '  t.EGYSEGAR AS Egysegar,'
      '  t.NETTO_ERTEK AS NettoErtek'
      'FROM Tetelek t'
      'INNER JOIN Partnerek p ON t.PARTNER_ID = p.ID'
      'INNER JOIN Termekek term ON t.TERMEK_ID = term.ID'
      'ORDER BY p.NEV ASC, term.MEGNEVEZES ASC')
    Left = 408
    Top = 64
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = qryRiport
    BCDToCurrency = False
    DataSetOptions = []
    Left = 448
    Top = 224
    FieldDefs = <
      item
        FieldName = 'PartnerID'
      end
      item
        FieldName = 'PartnerNev'
        FieldType = fftString
        Size = 100
      end
      item
        FieldName = 'PartnerCim'
        FieldType = fftString
        Size = 214
      end
      item
        FieldName = 'Cikkszam'
        FieldType = fftString
        Size = 50
      end
      item
        FieldName = 'CikkNev'
        FieldType = fftString
        Size = 100
      end
      item
        FieldName = 'Egysegar'
      end
      item
        FieldName = 'NettoErtek'
      end>
  end
  object frxReport1: TfrxReport
    Version = '2026.2.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection, pbWatermarks]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 46266.943921157400000000
    ReportOptions.LastChange = 46266.975460266210000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 440
    Top = 384
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    Watermarks = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 192.756017750000000000
          Top = 11.338590000000000000
          Width = 347.716760730000000000
          Height = 26.456709770000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            #220'gyfelenk'#233'nti forgalmi kimutat'#225's')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 128.504020000000000000
        Top = 132.283550000000000000
        Width = 718.110700000000000000
        KeepWithData = False
        Condition = 'frxDBDataset1."PartnerNev"'
        object MemofrxDBDataset1PartnerNev: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 7.559060000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'PartnerNev'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."PartnerNev"]')
          ParentFont = False
        end
        object MemofrxDBDataset1PartnerCim: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 49.133890000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'PartnerCim'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."PartnerCim"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795299670000000000
          Top = 98.267776320000000000
          Width = 94.488253590000000000
          Height = 18.897659300000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Cikksz'#225'm')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 234.330858120000000000
          Top = 98.267776320000000000
          Width = 94.488250730000000000
          Height = 18.897659300000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Cikkn'#233'v')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 423.307367260000000000
          Top = 98.267780570000000000
          Width = 94.488250730000000000
          Height = 18.897644040000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Egys'#233'g'#225'r')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488574680000000000
          Top = 98.267776320000000000
          Width = 94.488250730000000000
          Height = 18.897659300000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Nett'#243' '#233'rt'#233'k')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 71.811070000000000000
        Top = 283.464750000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object MemofrxDBDataset1Cikkszam: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 11.338590000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'Cikkszam'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Cikkszam"]')
          ParentFont = False
        end
        object MemofrxDBDataset1CikkNev: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 192.756030000000000000
          Top = 11.338590000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'CikkNev'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CikkNev"]')
          ParentFont = False
        end
        object MemofrxDBDataset1Egysegar: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 400.630180000000000000
          Top = 11.338590000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'Egysegar'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Egysegar"]')
          ParentFont = False
        end
        object MemofrxDBDataset1NettoErtek: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 563.149970000000000000
          Top = 11.338590000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          DataField = 'NettoErtek'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."NettoErtek"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 45.354360000000000000
        Top = 377.953000000000000000
        Width = 718.110700000000000000
        KeepWithData = False
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060100000000000
          Top = 15.118120000000000000
          Width = 136.063079780000000000
          Height = 18.897674560000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            #220'gyf'#233'l '#246'sszesen:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929476410000000000
          Top = 15.118120000000000000
          Width = 136.063111250000000000
          Height = 18.897674560000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."NettoErtek">, MasterData1)]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 483.779840000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 15.118120390000000000
          Top = 18.897665410000000000
          Width = 94.488246920000000000
          Height = 18.897644040000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            #214'sszforgalom:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929470450000000000
          Top = 18.897665410000000000
          Width = 132.283581250000000000
          Height = 18.897644040000000000
          ContentScaleOptions.Constraints.MaxIterationValue = 0
          ContentScaleOptions.Constraints.MinIterationValue = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."NettoErtek">, MasterData1)]')
          ParentFont = False
        end
      end
    end
  end
end
