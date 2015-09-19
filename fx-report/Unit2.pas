unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, Buttons, XPman;

type
  TTradeForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    LOT: TLabel;
    SYMBOL: TLabel;
    Commission: TLabel;
    Swap: TLabel;
    Profit: TLabel;
    TotalProfit: TLabel;
    Timer1: TTimer;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Caption1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TradeForm: TTradeForm;

implementation

uses Unit1;

{$R *.dfm}

procedure TTradeForm.Caption1Click(Sender: TObject);
begin
ShowMessage( self.Caption );
end;

procedure TTradeForm.Close1Click(Sender: TObject);
begin
Self.Close;
Self.Free;
end;

procedure TTradeForm.FormCreate(Sender: TObject);
begin
//Form1 := TForm1.Create(self);
//TradeForm.Hide;
end;

procedure TTradeForm.Panel1DblClick(Sender: TObject);
begin
If TradeMain.Showing then TradeMain.Hide else TradeMain.Show;
end;

procedure TTradeForm.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end else
end;

procedure TTradeForm.SpeedButton1Click(Sender: TObject);
begin
Self.Close;
Self.Free;
end;

procedure TTradeForm.SpeedButton2Click(Sender: TObject);
begin
Self.Close;
end;

procedure TTradeForm.Timer1Timer(Sender: TObject);
var
  Fd, cfd : HWND;
  s, cs : string;
begin
 SetLength(s, Length(Self.Caption) );
 s := Self.Caption;
 //Form1.ListBox1.Items.Add(s);
 cfd := GetForegroundWindow;
 SetLength(cs, 10);
 GetClassName( cfd, PChar(cs), Length(cs)+1 );
 //TradeMain.ListBox1.Items.Add( IntToStr(Length( cs )) + ( IntToStr(Length('TTradeMain'))));
 //TradeMain.ListBox1.Items.Add( LowerCase(cs) + IntToStr(Pos( LowerCase(cs), '0ttradeformttrademain0' )) );
 If Pos( LowerCase(cs), '0ttrademainttradeform0' ) > 0
 then else
 begin
  //TradeMain.ListBox1.Items.Add( cs );
  Fd := FindWindow( 'TTradeForm', PChar(s) );
  If Fd <> null then
   SetWindowPos( Fd, HWND_TOPMOST, Left, Top, 0, 0, SWP_NOSIZE);
 end;

  //SetLength(s, GetWindowTextLength(fd));
  //GetWindowText( fd, PChar(s), Length(s)+1 );
 //PostMessage( Fd, WM_CLOSE, 0,0 );
end;

end.
