unit uClienteDAO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uCliente, ZDataset, ZConnection, Generics.Collections;

type
  TListaClientes = specialize TObjectList<TCliente>;
  TClienteDAO = class
  private
    FConnection: TZConnection;
  public
    constructor Create(AConnection: TZConnection);
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Deletar(ID: Integer);
    function CarregarClientes : TListaClientes;;
    function ProcurarPorId(ID: Integer) : TCliente;
    function ProcurarPorNome(Nome : String) : TListaClientes;
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
    Query.SQL.Add('VALUES (:NOME, :EMAIL, :TELEFONE)');
    Query.ParamByName('NOME').AsString := Cliente.Nome;
    Query.ParamByName('EMAIL').AsString := Cliente.Email;
    Query.ParamByName('TELEFONE').AsInteger := Cliente.Telefone;
    Query.ExecSQL;
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
  finally
    Query.Free;
  end;
end;

function TClienteDAO.ProcurarPorId(ID: Integer): TCliente;
var
Query: TZQuery;
CShow: TCliente;
begin
 CShow:= nil;
 Query := TZQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('SELECT * FROM CLIENTES WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;

    if not Query.IsEmpty then
    begin

    CShow := TCliente.Create(
        Query.FieldByName('ID').AsInteger,
        Query.FieldByName('TELEFONE').AsInteger,
        Query.FieldByName('NOME').AsString,
        Query.FieldByName('EMAIL').AsString
      );


    end;
    Result := CShow;
  finally
    Query.Free;
  end;
end;

function TClienteDAO.ProcurarPorNome(Nome : String) : TListaClientes;
  var
  Query: TZQuery;
  Cliente: TCliente;
  begin
  Query := TZQuery.Create(nil);
  Result := TListaClientes.Create(True);
  try
  Query.Connection := FConnection;
    Query.SQL.Add('SELECT * FROM CLIENTES WHERE UPPER(NOME) LIKE :Nome');
    Query.ParamByName('Nome').AsString := '%' + UpperCase(Nome) + '%';
    Query.Open;

    while not Query.EOF do
    begin
      Cliente := TCliente.Create(
        Query.FieldByName('ID').AsInteger,
        Query.FieldByName('TELEFONE').AsInteger,
        Query.FieldByName('NOME').AsString,
        Query.FieldByName('EMAIL').AsString
      );

      Result.Add(Cliente);

      Query.Next;
      end;


  finally
       Query.Free;
  end;
end;

function TClienteDAO.CarregarClientes : TListaClientes;
  var
  Query: TZQuery;
  Cliente: TCliente;
  begin
  Query := TZQuery.Create(nil);
  Result := TListaClientes.Create(True);
  try
  Query.Connection := FConnection;
    Query.SQL.Add('SELECT * FROM CLIENTES');
    Query.Open;

    while not Query.EOF do
    begin
      Cliente := TCliente.Create(
        Query.FieldByName('ID').AsInteger,
        Query.FieldByName('TELEFONE').AsInteger,
        Query.FieldByName('NOME').AsString,
        Query.FieldByName('EMAIL').AsString
      );

      Result.Add(Cliente);

      Query.Next;
      end;


  finally
       Query.Free;
  end;
end;

end.

