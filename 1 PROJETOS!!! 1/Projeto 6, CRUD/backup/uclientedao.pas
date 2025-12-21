unit uClienteDAO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uCliente, ZDataset, ZConnection;

type
  TClienteDAO = class
  private
    FConnection: TZConnection;
  public
    constructor Create(AConnection: TZConnection);
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Deletar(ID: Integer);
    function ProcurarPorId(ID: Integer) : TCliente;
  end;

implementation

constructor TClienteDAO.Create(AConnection: TZConnection);
begin
  FConnection := AConnection;
end;

procedure TClienteDAO.Inserir(Cliente: TCliente);
var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('INSERT INTO CLIENTES (NOME, EMAIL, TELEFONE)');
    Query.SQL.Add('VALUES (:NOME, :EMAIL :TELEFONE)');
    Query.ParamByName('NOME').AsString := Cliente.Nome;
    Query.ParamByName('EMAIL').AsString := Cliente.Email;
    Query.ParamByName('TELEFONE').AsInteger := Cliente.Telefone;
    Query.ExecSQL;
    FConnection.Commit;
  finally
    Query.Free;
  end;
end;

procedure TClienteDAO.Atualizar(Cliente: TCliente);
 var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('UPDATE CLIENTES SET NOME = :NOME, EMAIL = :EMAIL, TELEFONE = :TELEFONE WHERE ID = :ID');
    Query.ParamByName('NOME').AsString := Cliente.Nome;
    Query.ParamByName('EMAIL').AsString := Cliente.Email;
    Query.ParamByName('TELEFONE').AsInteger := Cliente.Telefone;
    Query.ParamByName('ID').AsInteger := Cliente.ID;
    Query.ExecSQL;
    FConnection.Commit;
  finally
    Query.Free;
  end;
end;

procedure TClienteDAO.Deletar(ID: Integer);
 var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('DELETE FROM CLIENTES WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL;
    FConnection.Commit;
  finally
    Query.Free;
  end;
end;

function TClienteDAO.ProcurarPorId(ID: Integer): TCliente;
var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('SELECT * FROM CLIENTES WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;

  finally
    Query.Free;
  end;
end;
end.

