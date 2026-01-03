wunit uClienteService;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uCliente, uClienteDAO, ZConnection, fpjson, jsonparser, Generics.Collections;

type
  TClienteService = class
  private
    FDAO: TClienteDAO;
  public
    constructor Create(Connection: TZConnection);
    destructor Destroy; override;

    procedure CriarCliente(Nome, Email: String; Telefone: Integer);
    procedure AtualizarCliente(Cliente: TCliente);
    function BuscarPorID(Id: Integer): TCliente;
    function ValidarDados(Nome, Email: String; Telefone: Integer): Boolean;
    procedure Deletar(Id: Integer);
    function BuscarPorNome(Nome : String): TJSONArray;
    function CarregarClientes : TJSONArray;

  end;

implementation

constructor TClienteService.Create(Connection: TZConnection);
begin
  FDAO := TClienteDAO.Create(Connection);
end;

destructor TClienteService.Destroy;
begin
  FDAO.Free;
  inherited;
end;

function TClienteService.ValidarDados(Nome, Email: String; Telefone: Integer): Boolean;
begin
  Result := (Length(Trim(Nome)) >= 3) and
            (Length(Email) > 0) and
            (Pos('@', Email) > 0) and
            (Pos('.', Email) > Pos('@', Email));
end;

procedure TClienteService.CriarCliente(Nome, Email: String; Telefone: Integer);
var
  Cliente: TCliente;
begin
  if not ValidarDados(Nome, Email, Telefone) then
    raise Exception.Create('Dados inválidos para inserção. Verifique nome, e-mail e telefone.');

  Cliente := TCliente.Create(0, Telefone, Nome, Email);
  try
    FDAO.Inserir(Cliente);
  finally
    Cliente.Free;
  end;
end;

procedure TClienteService.AtualizarCliente(Cliente: TCliente);
begin
  if not ValidarDados(Cliente.Nome, Cliente.Email, Cliente.Telefone) then
    raise Exception.Create('Dados inválidos para atualização.');

  FDAO.Atualizar(Cliente);
end;

function TClienteService.BuscarPorID(Id: Integer): TCliente;
begin
  if Id <= 0 then
    raise Exception.Create('ID inválido para busca!');

    Result := FDAO.ProcurarPorId(Id);
end;

procedure TClienteService.Deletar(Id: Integer);
begin
  if Id <= 0 then
    raise Exception.Create('ID inválido para deletar!');

    FDAO.Deletar(Id);
end;

function TClienteService.BuscarPorNome(Nome : String): TJSONArray;
var
  Lista : TListaClientes;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  Cliente : TCliente;
begin
  Lista :=  FDAO.ProcurarPorNome(Nome);
  try
  JSONArray := TJSONArray.Create;

  for Cliente in Lista do
    begin
        JSONObject := TJSONObject.Create;
        JSONObject.Add('id', Cliente.ID);
        JSONObject.Add('telefone', Cliente.Telefone);
        JSONObject.Add('nome', Cliente.Nome);
        JSONObject.Add('email', Cliente.Email);
        JSONArray.Add(JSONObject);
    end;

    Result := JSONArray;
  finally
    Lista.Free;
  end;
end;

function TClienteService.CarregarClientes : TJSONArray;
var
  Lista : TListaClientes;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  Cliente : TCliente;
begin
  Lista :=  FDAO.CarregarClientes;
  try
  JSONArray := TJSONArray.Create;

  for Cliente in Lista do
    begin
        JSONObject := TJSONObject.Create;
        JSONObject.Add('id', Cliente.ID);
        JSONObject.Add('telefone', Cliente.Telefone);
        JSONObject.Add('nome', Cliente.Nome);
        JSONObject.Add('email', Cliente.Email);
        JSONArray.Add(JSONObject);
    end;

    Result := JSONArray;
  finally
    Lista.Free;
  end;
end;

end.
