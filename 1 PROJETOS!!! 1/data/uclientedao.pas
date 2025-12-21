unit uClienteDAO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uCliente, ZDataset, ZConnection, ZQuery;

type
  TClienteDAO = class
  private
    FConnection: ZConnection1;
  public
    constructor Create(Connection: ZConnection1);
    procedure Inserir(Cliente: TCliente);
    procedure Deletar(ID: Integer);
    procedure Atualizar(Cliente: TCliente);
    function BuscarPorId(ID: Integer): TCliente;
  end;

implementation

{ TClienteDAO }

constructor TClienteDAO.Create(Connection: ZConnection1);
begin
  FConnection := Connection;
end;
