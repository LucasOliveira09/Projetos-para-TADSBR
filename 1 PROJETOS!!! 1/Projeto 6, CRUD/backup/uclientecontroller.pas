unit uClienteController;

{$mode objfpc}{$H+}

interface

uses
  uCliente, SysUtils;

type
  TClienteController = class
  public
    function ValidarCliente(Cliente: TCliente): Boolean;
    function FormatarParaExibicao(Cliente: TCliente): String;
  end;


implementation

{$R *.lfm}

 function TClienteController.ValidarCliente(Cliente: TCliente): Boolean;
begin
  Result := (Cliente.Nome <> '') and
            (Pos('@', Cliente.Email) > 0) and (Cliente.Telefone >= 10000000);
end;

 function TClienteController.FormatarParaExibicao(Cliente: TCliente): String;
 begin
   Result := 'ID: ' + IntToStr(Cliente.ID) + ' | ' +
             'Nome: ' + Cliente.Nome + ' | ' +
             'Email: ' + Cliente.Email + ' | ' +
             'Telefone: ' + IntToStr(Cliente.Telefone);
 end;

end.

