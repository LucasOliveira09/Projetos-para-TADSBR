program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,
  Forms,
  uCliente,
  uClienteController,
  uClienteDAO, uModuloDados,
  uClienteService;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;

  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar := True;
  {$POP}

  Application.Initialize;
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TFormCliente, FormCliente);

  Application.Run;
end.
