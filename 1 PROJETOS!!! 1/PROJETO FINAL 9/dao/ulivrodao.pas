unit uLivroDAO;

{$mode Delphi}

interface

uses
  SysUtils, ZDataset, uModuloDados, uLivro;

type
  TLivroDAO = class
  public
    function ListarTodos: TZQuery;
    function Salvar(ALivro: TLivro): Boolean;

  end;

implementation

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

function TLivroDAO.Salvar(ALivro: TLivro): Boolean;
var
  Qry: TZQuery;
begin
  Qry := TZQuery.Create(nil);
  try
    Qry.Connection := DataModule2.ZConnection1;
    if ALivro.ID = 0 then
    begin
      // Insert
      Qry.SQL.Add('INSERT INTO LIVROS (TITULO, AUTOR_ID, ANO_PUBLICACAO, ISBN) VALUES (:T, :A, :ANO, :I)');
    end
    else
    begin
      // Update
      Qry.SQL.Add('UPDATE LIVROS SET TITULO=:T, AUTOR_ID=:A, ANO_PUBLICACAO=:ANO, ISBN=:I WHERE ID=:ID');
      Qry.ParamByName('ID').AsInteger := ALivro.ID;
    end;

    Qry.ParamByName('T').AsString := ALivro.Titulo;
    Qry.ParamByName('A').AsInteger := ALivro.AutorID; // Aqui vai o ID, vindo do ComboBox
    Qry.ParamByName('ANO').AsInteger := ALivro.Ano;
    Qry.ParamByName('I').AsString := ALivro.ISBN;
    Qry.ExecSQL;
    Result := True;
  finally
    Qry.Free;
  end;
end;
// ... Implementar Excluir ...
end.
