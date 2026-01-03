unit uLivrosController;

{$mode Delphi}

interface

uses
  Horse, SysUtils, fpjson, jsonparser, ZConnection, ZDataset, uLivroService, uLivro, uModuloDados;

procedure Registry(App : THorse);
procedure GetLivros(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure GetLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure PostLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure PutLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure DeleteLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

var
  GConnection: TZConnection;


procedure Registry(App : THorse);
begin
  App
    .Get('/api/livros', GetLivros)
    .Get('/api/livros/:id', GetLivro)
    .Post('/api/livros', PostLivro)
    .Put('/api/livros/:id', PutLivro)
    .Delete('/api/livros/:id', DeleteLivro);
end;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Service : TLivrosService;
  JSONArray: TJSONArray;
begin
  Service := TLivrosService.Create(DataModule2.ZConnection1);
  try
    try
      JSONArray := Service.CarregarLivros;

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

procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Service : TLivrosService;
  JSONObject: TJSONObject;
  ID : string;
  Livro : TLivro;
begin
  Service := TLivrosService.Create(DataModule2.ZConnection1);
  try
    ID := Req.Params.Items['id'];
    JSONObject := TJSONObject.Create;
    try
      Livro := Service.BuscarPorID(StrToInt(ID));
      begin
        JSONObject := TJSONObject.Create;
        JSONObject.Add('id', Livro.ID);
        JSONObject.Add('titulo', Livro.Titulo);
        JSONObject.Add('autor_id', Livro.AutorID);
        JSONObject.Add('ano_publicacao', Livro.Ano);
        JSONObject.Add('isbn', Livro.ISBN);

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

procedure PostLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
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

procedure PutLivro(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  JSONBody: TJSONObject;
  Service: TLivrosService;
  Livro: TLivro;
  ID, AutorID, Ano: Integer;
  Titulo, ISBN: String;
begin
  Service := TLivrosService.Create(DataModule2.ZConnection1);
  try
    ID := StrToIntDef(Req.Params['id'], 0);
    JSONBody := GetJSON(Req.Body) as TJSONObject;

    try
      Titulo  := JSONBody.Strings['nome'];
      AutorID := JSONBody.Strings['autor_id'];
      Ano := JSONBody.Strings['ano_publicacao'];
      ISBN := JSONBody.Strings['isbn'];
      try
        Livro := TLivro.Create(ID, Ano, AutorID, Titulo, ISBN);
        Service.AtualizarLivro(Livro);
      finally
        Livro.Free;
        Service.Free;
      end;

      Res.Send('Livro atualizado com sucesso');
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

