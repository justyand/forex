unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StrUtils, StdCtrls, Unit2, Menus;

type
  TTrades = packed record
    Ticket     : integer;
    Lot        : double;
    Symbol     : string[30];
    Swap       : double;
    Commission : double;
    Profit     : double;
    TotalProfit: double;
    OrderType  : integer;
    // Order types
    {
       0 - Buy
       1 - Sell
       2 - Pending Buy Limit
       3 - Pending Sell Limit
       4 - Pending Buy Stop
       5 - Pending Sell Stop
    }
  end;
  TData = packed record
    account   : integer;
    refresh   : integer;
    trade_line: integer;
    trades    : Array of TTrades;
  end;
  TTradeMain = class(TForm)
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Timer2: TTimer;
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Show1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TradeMain : TTradeMain;
  a_file: string;
  iData: TData;
  fo : TTradeForm;

implementation

{$R *.dfm}

function ShowTotalProfit: boolean;
var
 t : double;
 i : integer;
begin
 t := 0;
 for i := 0 to Length( iData.trades )-1 do
 begin
  If ( iData.trades[i].OrderType = 0 ) or ( iData.trades[i].OrderType = 1 )
   then t := t + iData.trades[i].TotalProfit;
 end;
 TradeMain.Caption := 'Refresh: ' + IntToStr( iData.refresh ) + 's | Total profit: $' + FloatToStr( t ); 
end;

function ShowData( data: TListBox ): boolean;
var
 s : string;
 n, i : integer;
 fo: TTradeForm;
 find: boolean;
begin
 find := False;
 TradeMain.ProgressBar1.Position := TradeMain.ProgressBar1.Max;
 data.Clear;
 s := '';
 for n:= 0 to Length( iData.trades )-1 do
 begin
  for i:= 0 to Screen.FormCount -1 do
  Begin
  If screen.Forms[i].Caption = IntToStr( iData.trades[n].Ticket ) then
  begin
   find := True;
   break;
  end else find := False;
  End;
  If find = true then fo := Screen.forms[i] as TTradeForm else
  fo := TTradeForm.Create(TradeMain);
  fo.BorderStyle := bsNone;
  If find = false then
  begin
   fo.Left := 0;
   fo.Top := n * 20;
   fo.Width := 300;
   fo.Height := 20;
  end;
  fo.FormStyle := fsStayOnTop;
  fo.PopupMode := pmExplicit;
  fo.PopupParent := TradeMain;
  fo.Caption := FloatToStr( iData.trades[n].Ticket );
  fo.SYMBOL.Caption := iData.trades[n].Symbol;
  fo.LOT.Caption := FloatToStr( iData.trades[n].Lot );
  fo.Commission.Caption := FloatToStr( iData.trades[n].Commission );
  fo.Swap.Caption := FloatToStr( iData.trades[n].Swap );
  fo.Profit.Caption := FloatToStr( iData.trades[n].Profit );
  fo.TotalProfit.Caption := FloatToStr( iData.trades[n].TotalProfit );
  fo.AutoSize := False;
  fo.AutoSize := True;
  If find = false then
  fo.Show;
   s := iData.trades[n].Symbol +' # ' +
        FloatToStr(iData.trades[n].Lot) +' # ' +
        FloatToStr(iData.trades[n].Commission) +' # ' +
        FloatToStr(iData.trades[n].Swap) +' # ' +
        FloatToStr(iData.trades[n].Profit) +' # ' +
        FloatToStr(iData.trades[n].TotalProfit) +' # ' +
        IntToStr(iData.trades[n].OrderType) +' # ' +
        FloatToStr(iData.trades[n].Ticket);
   data.Items.Add( s );
 end;
end;

procedure TTradeMain.FormCreate(Sender: TObject);
var
 f : TextFile;
begin
If FileExists( ExtractFilePath(Application.ExeName) + 'conf.conf' ) = false then a_file := '' else
begin
 AssignFile( f, ExtractFilePath(Application.ExeName) + 'conf.conf' );
 Reset( f );
 ReadLn( f, a_file );
 CloseFile( f );
 If FileExists( a_file ) = False then a_file := '';
end;
end;

procedure TTradeMain.ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
If Button = mbRight then TradeMain.Hide;
end;

procedure TTradeMain.Timer1Timer(Sender: TObject);
var
 f, c : TextFile;
 s, settings, temp : string;
 i: integer;
 dd: TStringList;
begin
 If Length( a_file ) = 0 then
 begin
 Timer1.Enabled := False;
  If OpenDialog1.Execute then
  begin
   a_file := OpenDialog1.FileName;
   Timer1.Enabled := True;
   AssignFile( c, ExtractFilePath(Application.ExeName) + 'conf.conf' );
   Rewrite( c );
   WriteLn( c, a_file );
   CloseFile( c );
  end;
 end
 else
  begin
    Timer1.Enabled := False;
    SetLength( iData.trades, 0 );
    AssignFile( f, a_file );
    Reset( f );
    while not Eof( f ) do
    begin
      ReadLn( f, s );
      If AnsiContainsText( s, 'Setting' ) then
      begin
       ReadLn( f, settings );
       //showmessage(settings);
       temp := Copy( settings, 0, Pos( '|', settings )-1);
       //Form1.Caption := temp;
       iData.account := StrToInt( temp );
       temp := Copy( settings, Pos( '|' , settings )+1, Length( settings ) - Pos( '|', settings ));
       iData.refresh := StrToInt( temp );
       //Form1.Caption := 'Refresh: ' + IntToStr( iData.refresh ) + 's';
       Timer1.Interval := iData.refresh * 1000;
       ProgressBar1.Max := Timer1.Interval;
       ProgressBar1.Position := Timer2.Interval;
       Timer2.Enabled := True;
       Timer1.Enabled := True;
       repeat
         ReadLn( f, s );
         If AnsiContainsText( s, 'symbol' ) = true then
         begin
          iData.trade_line := FilePos( f );
          break;
         end;
       until Eof( f );
       ListBox1.Clear;
       repeat
         ReadLn( f, s );
         If Length( s ) > 0 then
         begin
          s := StringReplace( s, '.', ',', [rfReplaceAll] );
          dd := TStringList.Create;
          dd.Clear;
          dd.Delimiter := '|';
          dd.DelimitedText := s;
          s := '';
          SetLength( iData.trades, Length( iData.trades ) +1 );
          for i := 0 to dd.Count -1 do
          begin
           case i of
            0 : iData.trades[Length( iData.trades )-1].Symbol := dd[i];
            1 : iData.trades[Length( iData.trades )-1].Lot := StrToFloat(dd[i]);
            2 : iData.trades[Length( iData.trades )-1].Commission := StrToFloat(dd[i]);
            3 : iData.trades[Length( iData.trades )-1].Swap := StrToFloat(dd[i]);
            4 : iData.trades[Length( iData.trades )-1].Profit := StrToFloat(dd[i]);
            5 : iData.trades[Length( iData.trades )-1].TotalProfit := StrToFloat(dd[i]);
            6 : iData.trades[Length( iData.trades )-1].OrderType := StrToInt(dd[i]);
            7 : iData.trades[Length( iData.trades )-1].Ticket := StrToInt(dd[i]);
           end;
          end;
          dd.Free;
         end
         else break;
       until Eof( f );
      end;
    end;
    CloseFile( f );
    ShowData( ListBox1 );
    ShowTotalProfit;
  end;
end;

procedure TTradeMain.Timer2Timer(Sender: TObject);
var
i : integer;
begin
 Application.ProcessMessages;
 If ProgressBar1.Position < Timer1.Interval then
  ProgressBar1.StepBy( Timer2.Interval )
  else ProgressBar1.Position := 0;
end;

end.
