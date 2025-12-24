unit uClienteController;

{$mode objfpc}{$H+}

interface

uses
  uCliente, SysUtils, uClienteService;

type
  TClienteController = class
    private
      Service : TClienteService;
  public
    function ValidarCliente(Cliente: TCliente): Boolean;
    function FormatarParaExibicao(Cliente: TCliente): String;
    procedure CriarCliente(Nome, Email: String; Telefone: Integer);
  end;


implementation

 function TClienteController.ValidarCliente(Cliente: TCliente): Boolean;
begin
  Result := (Cliente.Nome <> '') and
            (Pos('@', Cliente.Email) > 0);
end;

 function TClienteController.FormatarParaExibicao(Cliente: TCliente): String;
 begin
   Result := 'ID: ' + IntToStr(Cliente.ID) + ' | ' +
             'Nome: ' + Cliente.Nome + ' | ' +
             'Email: ' + Cliente.Email + ' | ' +
             'Telefone: ' + IntToStr(Cliente.Telefone);
 end;



 procedure TClienteController.CriarCliente(Nome, Email: String; Telefone: Integer);
 var
   Controller : TCLienteController;
   Cliente: TCliente;
 begin
 Cliente := Cliente.Create(0, Telefone, Nome, Email);
try
  if not Controller.ValidarCliente(Cliente) then
 raise Exception.Create('Cliente inválido!');

  Service.CriarCliente(Cliente.Nome, Cliente.Email, Cliente.Telefone);
 finally
   Cliente.free
 end;


 end;

end.

