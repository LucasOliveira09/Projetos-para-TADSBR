program api;

{$mode delphi}{$H+}

uses
  SysUtils, Horse, Horse.CORS, Horse.Jhonson, Horse.Compression, Horse.JWT,
  zcomponent, uClienteController, controller.auth, config, uModuloData;

procedure Listen(_listen : THorse);
begin
  WriteLn('Servidor ativo na porta: '+ IntToStr(_listen.Port));
end;

const
  JWT_KEY = '1234567';
var
  App : THorse;
begin
  DataModule2 := TDataModule2.Create(nil);
  try
    DataModule2.ZConnection1.Connect;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao conectar no banco: ' + E.Message);
      ReadLn;
      Exit;
    end;
  end;

  App := THorse.Create;

  //Personalização de configurações do CORS
  ConfigurarHorseCORS();
  //Personalização de configurações do JWT
  ConfigurarHorseJWT();

  //Configurando componentes
  App.Use(CORS);
  App.Use(Compression); //Compactação
  App.Use(Jhonson); //Middleware json
  App.Use(HorseJWT(JWT_KEY, configJWT));

  //Controladores (Rotas)
  controller.auth.Registry(App);
  uClienteController.Registry(App);

  THorse.Listen(9000, @Listen);
end.
