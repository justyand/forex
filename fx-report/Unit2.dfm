object TradeForm: TTradeForm
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 200
  AutoSize = True
  BorderStyle = bsNone
  ClientHeight = 20
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 20
    Height = 20
    Align = alLeft
    BevelOuter = bvNone
    Caption = '||'
    TabOrder = 0
    OnDblClick = Panel1DblClick
    OnMouseDown = Panel1MouseDown
  end
  object Panel2: TPanel
    Left = 20
    Top = 0
    Width = 308
    Height = 20
    Align = alLeft
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object LOT: TLabel
      AlignWithMargins = True
      Left = 55
      Top = 0
      Width = 18
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'LOT'
      Layout = tlCenter
    end
    object SYMBOL: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 40
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'SYMBOL'
      Layout = tlCenter
    end
    object Commission: TLabel
      AlignWithMargins = True
      Left = 83
      Top = 0
      Width = 30
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'COMMISSION'
      Layout = tlCenter
    end
    object Swap: TLabel
      AlignWithMargins = True
      Left = 123
      Top = 0
      Width = 30
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'SWAP'
      Layout = tlCenter
    end
    object Profit: TLabel
      AlignWithMargins = True
      Left = 163
      Top = 0
      Width = 45
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'PROFIT'
      Layout = tlCenter
    end
    object TotalProfit: TLabel
      AlignWithMargins = True
      Left = 218
      Top = 0
      Width = 45
      Height = 20
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'TOTAL_PROFIT'
      Layout = tlCenter
    end
    object SpeedButton1: TSpeedButton
      Left = 288
      Top = 0
      Width = 20
      Height = 20
      Align = alLeft
      Caption = 'x'
      Flat = True
      Layout = blGlyphBottom
      Spacing = 0
      OnClick = SpeedButton1Click
      ExplicitLeft = 263
    end
    object SpeedButton2: TSpeedButton
      Left = 268
      Top = 0
      Width = 20
      Height = 20
      Align = alLeft
      Caption = '_'
      Flat = True
      Layout = blGlyphBottom
      Spacing = 0
      OnClick = SpeedButton2Click
      ExplicitLeft = 263
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 150
    Top = 5
  end
end
