program api;

{$mode delphi}{$H+}

uses
  SysUtils, Horse, zcomponent, uClienteController, uDBConnection;

procedure Listen(_listen : THorse);
begin
  WriteLn('Servidor ativo na porta: '+ IntToStr(_listen.Port));
end;

begin
  try
    GetConnection.Connect;

    THorse
      .Get('/api/clientes', GetClientes)
      .Get('/api/clientes/:id', GetCliente)
      .Get('/api/clientes/busca/:nome', GetClienteNome)
      .Post('/api/clientes', PostCliente)
      .Put('/api/clientes/:id', PutCliente)
      .Delete('/api/clientes/:id', DeleteCliente);

    THorse.Listen(9000, @Listen);

  finally
    DataModule2.Free;
  end;
end.
