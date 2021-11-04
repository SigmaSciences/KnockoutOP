program ComboBoxOA;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


