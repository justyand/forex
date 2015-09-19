program fx_report;

uses
  Forms,
  Unit1 in 'Unit1.pas' {TradeMain},
  Unit2 in 'Unit2.pas' {TradeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTradeMain, TradeMain);
  Application.Run;
end.
