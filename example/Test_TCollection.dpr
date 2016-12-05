program Test_TCollection;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {FormExample},
  MyComponent in 'MyComponent.pas',
  Tee.Collection in '..\source\Tee.Collection.pas';

{$R *.res}

begin
  {$IFOPT D+}
  ReportMemoryLeaksOnShutdown:=True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormExample, FormExample);
  Application.Run;
end.
