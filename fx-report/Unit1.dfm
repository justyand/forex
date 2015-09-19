object TradeMain: TTradeMain
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'TradeMain'
  ClientHeight = 216
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 197
    Width = 418
    Height = 19
    Align = alBottom
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 414
      Height = 15
      Align = alClient
      Step = 10000
      TabOrder = 0
      OnMouseDown = ProgressBar1MouseDown
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 418
    Height = 197
    Align = alClient
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 190
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.csv'
    Filter = 'Report CSV|*.csv|AnyFile|*.*'
    Title = 'Find reportfile'
    Left = 130
    Top = 60
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer2Timer
    Left = 225
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 155
    Top = 100
    object Show1: TMenuItem
      Caption = 'Show'
    end
  end
end
