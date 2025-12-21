unit uClientDao;

{$mode objfpc}{$H+}

interface

uses
  uCliente, ZDataset, ZConnection;

type

  { TForm1 }

  type
  TClienteDAO = class
  private
    FConnection: TZConnection;
  public
    constructor Create(Connection: TZConnection);
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Deletar(ID: Integer);
    function BuscarPorID(ID: Integer): TCliente;
    function BuscarTodos: TList;
  end;

implementation

uses ZQuery;

constructor TClienteDAO.Create(Connection: TZConnection);
begin
  FConnection := Connection;
end;






end.

