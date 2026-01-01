program BibliotecaDesktop;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,
  Forms, Controls, SysUtils, Dialogs,
  uModuloDados,
  uFormLogin, uUsuarioDAO, uUsuarioService,
  uFormPrincipal;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModule2, DataModule2);



      Application.CreateForm(TFrmPrincipal, FrmPrincipal);

      // Application.CreateForm(TFrmLivros, FrmLivros);
      // Application.CreateForm(TFrmAutores, FrmAutores);


      Application.Run;
    begin
      Application.Terminate;
    end;

end.
