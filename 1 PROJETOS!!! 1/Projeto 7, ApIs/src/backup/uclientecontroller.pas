unit uClienteController;

{$mode Delphi}

interface

uses
  Horse, SysUtils, fpjson, jsonparser, ZConnection, ZDataset, uClienteService, uCliente, uModuloDados;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure GetClienteNome(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure PostCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure PutCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure DeleteCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

var
  GConnection: TZConnection;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Query: TZQuery;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
begin
  try
    Query := TZQuery.Create(nil);
    JSONArray := TJSONArray.Create;
    try
      Query.Connection := GConnection;
      Query.SQL.Text := 'SELECT ID, NOME, EMAIL FROM CLIENTES';
      Query.Open;

      while not Query.Eof do
      begin
        JSONObject := TJSONObject.Create;
        JSONObject.Add('id', Query.FieldByName('ID').AsInteger);
        JSONObject.Add('nome', Query.FieldByName('NOME').AsString);
        JSONObject.Add('email', Query.FieldByName('EMAIL').AsString);
        JSONArray.Add(JSONObject);
        Query.Next;
      end;

      Res.ContentType('application/json');
      Res.Send(JSONArray.AsJSON);
    finally
      Query.Free;
      JSONArray.Free;
    end;
  except
    on E: Exception do
      Res.Status(500).Send('Erro: ' + E.Message);
  end;
end;

procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Service : TClienteService;
  JSONObject: TJSONObject;
  ID : string;
  Cliente : TCliente;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    ID := Req.Params.Items['id'];
    JSONObject := TJSONObject.Create;
    try
      Cliente := Service.BuscarPorID(StrToInt(ID));
      begin
        JSONObject := TJSONObject.Create;
        JSONObject.Add('id', Cliente.ID);
        JSONObject.Add('telefone', Cliente.Telefone);
        JSONObject.Add('nome', Cliente.Nome);
        JSONObject.Add('email', Cliente.Email);

        Res.ContentType('application/json');
        Res.Send(JSONObject.AsJSON);
      end

    finally
      Service.Free;
      JSONObject.Free;
    end;
  except
    on E: Exception do
      Res.Status(500).Send('Erro: ' + E.Message);
  end;
end;

procedure GetClienteNome(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Service : TClienteService;
  JSONArray: TJSONArray;
  Nome : string;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    Nome := Req.Params.Items['nome'];
    try
      JSONArray := Service.BuscarPorNome(Nome);

        Res.ContentType('application/json');
        Res.Send(JSONArray.AsJSON);
    finally
      Service.Free;
      JSONArray.Free;
    end;
  except
    on E: Exception do
      Res.Status(500).Send('Erro: ' + E.Message);
  end;
end;

procedure PostCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  JSONBody: TJSONObject;
  Nome, Email, telefone: String;
  Service : TClienteService;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    JSONBody := GetJSON(Req.Body) as TJSONObject;
    try
      Nome     := JSONBody.Strings['nome'];
      Email    := JSONBody.Strings['email'];
      telefone := JSONBody.Strings['telefone'];

      try
        Service.CriarCliente(Nome, Email, StrToInt(telefone));
      finally
        Service.Free;
      end;

      Res.Status(201).Send('Cliente criado com sucesso');
    finally
      JSONBody.Free;
    end;
  except
    on E: Exception do
      Res.Status(400).Send('Erro: ' + E.Message);
  end;
end;

procedure PutCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  JSONBody: TJSONObject;
  Service: TClienteService;
  Cliente: TCliente;
  ID: Integer;
  Nome, Email, telefone: String;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    ID := StrToIntDef(Req.Params['id'], 0);
    JSONBody := GetJSON(Req.Body) as TJSONObject;

    try
      Nome  := JSONBody.Strings['nome'];
      Email := JSONBody.Strings['email'];
      telefone := JSONBody.Strings['telefone'];
      try
        Cliente := TCliente.Create(ID, StrToInt(telefone), Nome, Email);
        Service.AtualizarCliente(Cliente);
      finally
        Cliente.Free;
        Service.Free;
      end;

      Res.Send('Cliente atualizado com sucesso');
    finally
      JSONBody.Free;
    end;
  except
    on E: Exception do
      Res.Status(400).Send('Erro: ' + E.Message);
  end;
end;

procedure DeleteCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ID: Integer;
  Service: TClienteService;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    ID := StrToInt(Req.Params['id']);
    try
     Service.Deletar(ID);
    finally
      Service.Free;
    end;

    Res.Send('Cliente deletado com sucesso');
  except
    on E: Exception do
      Res.Status(400).Send('Erro: ' + E.Message);
  end;
end;
end.
