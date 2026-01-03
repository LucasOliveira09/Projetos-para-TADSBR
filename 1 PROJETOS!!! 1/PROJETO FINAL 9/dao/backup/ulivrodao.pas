unit uLivroDAO;

{$mode Delphi}

interface

uses
  SysUtils, ZDataset, uModuloDados, uLivro, ZConnection;

type
  TLivroDAO = class
  private
    FConnection: TZConnection;
  public
    constructor Create(AConnection: TZConnection);
    function ListarTodos: TZQuery;
    procedure Inserir(Livro: TLivro);
    function ProcurarPorId(ID: Integer): TLivro;
    procedure Deletar(ID: Integer);
    procedure Atualizar(Livro: TLivro);
  end;

implementation

constructor TLivroDAO.Create(AConnection: TZConnection);
begin
  FConnection := AConnection;
end;

function TLivroDAO.ListarTodos: TZQuery;
var
  Qry: TZQuery;
begin
  Qry := TZQuery.Create(nil);
  Qry.Connection := DataModule2.ZConnection1;

  Qry.SQL.Add('SELECT L.ID, L.TITULO, L.ANO_PUBLICACAO, L.ISBN, L.AUTOR_ID, A.NOME as NOME_AUTOR');
  Qry.SQL.Add('FROM LIVROS L');
  Qry.SQL.Add('INNER JOIN AUTORES A ON A.ID = L.AUTOR_ID');
  Qry.SQL.Add('ORDER BY L.TITULO');

  Qry.Open;
  Result := Qry;
end;

procedure TLivroDAO.Inserir(Livro: TLivro);
var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := DataModule2.ZConnection1;
    Query.SQL.Add('INSERT INTO LIVROS (TITULO, AUTOR_ID, ANO_PUBLICACAO, ISBN)');
    Query.SQL.Add('VALUES (:TITULO, :AUTOR_ID, :ANO_PUBLICACAO, :ISBN)');
    Query.ParamByName('TITULO').AsString := Livro.Titulo;
    Query.ParamByName('AUTOR_ID').AsInteger := Livro.AutorID;
    Query.ParamByName('ANO_PUBLICACAO').AsInteger := Livro.Ano;
    Query.ParamByName('ISBN').AsString := Livro.ISBN;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TLivroDAO.Atualizar(Livro: TLivro);
var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := DataModule2.ZConnection1;
    Query.SQL.Add('UPDATE LIVROS SET TITULO = :TITULO, AUTOR_ID = :AUTOR_ID, ANO_PUBLICACAO = :ANO_PUBLICACAO, ISBN = :ISBN WHERE ID = :ID');
    Query.ParamByName('TITULO').AsString := Livro.Titulo;
    Query.ParamByName('AUTOR_ID').AsInteger := Livro.AutorID;
    Query.ParamByName('ANO_PUBLICACAO').AsInteger := Livro.Ano;
    Query.ParamByName('ISBN').AsString := Livro.ISBN;
    Query.ParamByName('ID').AsString := Livro.ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TLivroDAO.Deletar(ID: Integer);
 var
Query: TZQuery;
begin
 Query := TZQuery.Create(nil);
  try
    Query.Connection := DataModule2.ZConnection1;
    Query.SQL.Add('DELETE FROM LIVROS WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TLivroDAO.ProcurarPorId(ID: Integer): TLivro;
var
Query: TZQuery;
CShow: TLivro;
begin
 CShow:= nil;
 Query := TZQuery.Create(nil);
  try
    Query.Connection := DataModule2.ZConnection1;
    Query.SQL.Add('SELECT * FROM LIVROS WHERE ID = :ID');
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;

    if not Query.IsEmpty then
    begin

    CShow := TLivro.Create(
    ID,
    Query.ParamByName('AUTOR_ID').AsInteger,
    Query.ParamByName('ANO').AsInteger,
    Query.ParamByName('TITULO').AsString,
    Query.ParamByName('ISBN').AsString
      );


    end;
    Result := CShow;
  finally
    Query.Free;
  end;
end;


end.
