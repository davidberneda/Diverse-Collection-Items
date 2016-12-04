program Test_TCollection;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  MyComponent in 'MyComponent.pas',
  Tee.Collection in 'Tee.Collection.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
