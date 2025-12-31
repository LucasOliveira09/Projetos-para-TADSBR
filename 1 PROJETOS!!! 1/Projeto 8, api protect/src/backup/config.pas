unit config;

{$mode ObjFPC}{$H+}

interface

uses
  Horse.JWT, horse.CORS;

procedure ConfigurarHorseJWT();
procedure ConfigurarHorseCORS();

var
  publicRoutes : array of string;
  configJWT : IHorseJWTConfig;

const
  JWT_KEY = '1234567';

implementation

procedure ConfigurarHorseJWT();
begin
  //Configura as rotas que são públicas: Não precisam do token JWT para serem acessadas. As demais rotas estão todas autenticadas.
  SetLength(publicRoutes, 2);
  publicRoutes[0] := '/api/login';
  publicRoutes[1] := '/api/clientes';

  configJWT := THorseJWTConfig.New.SkipRoutes(publicRoutes);
end;

procedure ConfigurarHorseCORS();
begin
  HorseCORS
    .AllowedOrigin('*')
    .AllowedHeaders('Content-Type, Accept, Accept-Encoding, X-Requested-With, Content-Length, Authorization, x-user, x-password, x-filename, x-id, x-emp, bearer, Bearer')
    .AllowedMethods('PUT, GET, POST, DELETE, OPTIONS, PATCH')
    .ExposedHeaders('*')
    .AllowedCredentials(True);
end;

end.
