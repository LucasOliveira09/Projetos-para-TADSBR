unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ZConnection, ZDataset, ZSqlUpdate, ZAbstractRODataset, DB;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    buscar: TEdit;
    ZConnection1: TZConnection;
    clientes: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure buscarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    procedure CarregarClientes;
    procedure BuscarPorNome(Nome: String);

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormCreate(Sender: TObject);
begin
  ZConnection1.Protocol := 'firebird';
  ZConnection1.Database := 'C:\Users\Luquinhas\Desktop\dbtest\BIBLIOTECAEX.FDB';
  ZConnection1.User := 'SYSDBA';
  ZConnection1.Password := 'masterkey';
  ZConnection1.Connect;
  CarregarClientes;

  if ZConnection1.Connected then
    ShowMessage('Conectado ao banco!')
  else
    ShowMessage('Erro ao conectar');
end;

procedure TForm1.CarregarClientes;
begin

  if clientes.Active then
    clientes.Close;

  clientes.SQL.Clear;
  clientes.SQL.Add('SELECT * FROM LIVROS L JOIN AUTORES A ON L.AUTOR_ID = A.ID');
  clientes.Open;
end;

procedure TForm1.BuscarPorNome(Nome: String);
begin
  clientes.SQL.Clear;
  clientes.SQL.Add('SELECT * FROM LIVROS WHERE TITULO LIKE :NOME');
  clientes.ParamByName('NOME').AsString := '%' + Nome + '%';
  clientes.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 CarregarClientes;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  nome : String;
begin
 nome := buscar.Text;
 BuscarPorNome(nome);
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TForm1.buscarChange(Sender: TObject);
begin

end;




end.

