program api;

{$mode delphi}{$H+}

uses
  SysUtils, Horse, zcomponent, uClienteController, uModuloDados;

procedure Listen(_listen : THorse);
begin
  WriteLn('Servidor ativo na porta: '+ IntToStr(_listen.Port));
end;

begin
  DataModule2 := TDataModule2.Create(nil);
  try
    DataModule2.ZConnection1.Connect;

    THorse
      .Get('/api/clientes', GetClientes)
      .Get('/api/clientes/:id', GetCliente)
      .Post('/api/clientes', PostCliente)
      .Put('/api/clientes/:id', PutCliente)
      .Delete('/api/clientes/:id', DeleteCliente);

    THorse.Listen(9000, @Listen);

  finally
    DataModule2.Free;
  end;
end.
