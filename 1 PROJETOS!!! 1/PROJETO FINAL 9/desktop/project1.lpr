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

  try
    DataModule2.ZConnection1.Connect;
  except
    on E: Exception do
    begin
      ShowMessage('Erro Crítico: Não foi possível conectar ao banco de dados.' + sLineBreak +
                  'Detalhes: ' + E.Message);
      Application.Terminate;
      Exit;
    end;
  end;

  FrmLogin := TFrmLogin.Create(nil);
  try
    if FrmLogin.ShowModal = mrOK then
    begin


      Application.CreateForm(TFrmPrincipal, FrmPrincipal);

      // Application.CreateForm(TFrmLivros, FrmLivros);
      // Application.CreateForm(TFrmAutores, FrmAutores);


      Application.Run;
    end
    else
    begin
      Application.Terminate;
    end;
  finally
    FrmLogin.Free;
  end;

end.
