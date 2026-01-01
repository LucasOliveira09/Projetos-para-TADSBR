unit uFormLivros;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  ZDataset, uLivro, uLivroDAO;

type

  { TFrmLivros }

  TFrmLivros = class(TForm)
    btnVoltar: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure btnVoltarClick(Sender: TObject);


    AtualizarButton: TButton;
    DeletarButton: TButton;
    InserirButton: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    InserirInput2: TEdit;
    InserirInput1: TEdit;
    InserirInput3: TEdit;
    BuscarInput: TEdit;
    DeletarInput: TEdit;
    AtualizarInput1: TEdit;
    AtualizarInput2: TEdit;
    AtualizarInput3: TEdit;
    AtualizarInput4: TEdit;
    AtualizarLabel5: TLabel;
    AtualizarLabel1: TLabel;
    AtualizarLabel2: TLabel;
    InserirLabel2: TLabel;
    InserirLabel3: TLabel;
    InserirLabel4: TLabel;
    BuscarLabel: TLabel;
    InserirLabel1: TLabel;
    DeletarLabel: TLabel;
    AtualizarLabel4: TLabel;
    AtualizarLabel3: TLabel;
    Label1: TLabel;
    procedure AtualizarButtonClick(Sender: TObject);
    procedure BuscarButtonClick(Sender: TObject);
    procedure DeletarButtonClick(Sender: TObject);
    procedure InserirButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
  public
  end;

var
  FrmLivros: TFrmLivros;

implementation

{$R *.lfm}

{ TFrmLivros }



procedure TFrmLivros.btnVoltarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmLivros.CarregarLivros;
var
  DAO: TLivroDAO;
begin
  // Nota: Idealmente o Service deveria chamar o DAO, mas para carregar o Grid
  // diretamente no ZQuery do DataModule, acessar o DAO direto é aceitável aqui.
  DAO := TLivroDAO.Create;
  try
    // O método ListarTodos do DAO retorna uma Query.
    // Você pode ligar o DataSource do Grid nessa Query ou usar a lógica abaixo se o DAO manipular o DataModule.
    // Assumindo que seu DAO tem um método que popula um dataset externo:
    // DAO.Carregar(DataModule2.ZQuery1);

    // OU se seu DAO retorna uma Query (como fizemos nos exemplos anteriores):
    DataModule2.ZQuery1.SQL.Text := DAO.ListarTodos.SQL.Text;
    DataModule2.ZQuery1.Open;
  finally
    DAO.Free;
  end;
end;

// 2. Controlar visibilidade dos inputs
procedure TFrmLivros.MudarLayout(Acao: String);
begin
  ComecarLimpo; // Esconde tudo primeiro

  if Acao = 'Inserir' then
  begin
    edtTitulo.Visible := True;
    edtISBN.Visible := True;
    edtAno.Visible := True;
    edtAutorID.Visible := True;
    InserirButton.Visible := True;
  end
  else if Acao = 'Buscar' then
  begin
    BuscarInput.Visible := True;
    BuscarButton.Visible := True;
  end
  else if Acao = 'Atualizar' then
  begin
    // Na atualização precisamos do ID também
    BuscarInput.Visible := True; // Usando campo de busca como ID para editar
    edtTitulo.Visible := True;
    edtISBN.Visible := True;
    edtAno.Visible := True;
    edtAutorID.Visible := True;
    // AtualizarButton.Visible := True; // Supondo que tenha esse botão
  end
  else if Acao = 'Deletar' then
  begin
    DeletarInput.Visible := True;
    DeletarButton.Visible := True;
  end;
end;

procedure TFrmLivros.ComecarLimpo;
begin
  // Implemente aqui o código para deixar .Visible := False em todos os inputs
end;

// 3. Inserir Livro
procedure TFrmLivros.InserirButtonClick(Sender: TObject);
var
  Livro: TLivro;
  Service: TLivroService;
begin
  Service := TLivroService.Create; // Removemos o DataModule daqui, pois o DAO já sabe onde conectar
  try
    // Cria o objeto Livro com os dados da tela
    // Ordem do Create: ID, Ano, AutorID, Titulo, ISBN
    Livro := TLivro.Create(
      0, // ID 0 para novo cadastro
      StrToIntDef(edtAno.Text, 2024),
      StrToIntDef(edtAutorID.Text, 0), // Precisamos do ID do Autor
      edtTitulo.Text,
      edtISBN.Text
    );

    try
      // Passa para o Service validar e salvar
      Service.Salvar(Livro);

      ShowMessage('Livro cadastrado com sucesso!');
      CarregarLivros;
      ComecarLimpo;
    finally
      Livro.Free;
    end;
  finally
    Service.Free;
  end;
end;

// 4. Buscar Livro
procedure TFrmLivros.BuscarButtonClick(Sender: TObject);
var
  Id: Integer;
  Livro: TLivro;
  Service: TLivroService;
begin
  Id := StrToIntDef(BuscarInput.Text, 0);
  Service := TLivroService.Create;
  try
    // Nota: O método BuscarPorID do Service geralmente retorna um objeto TLivro ou Query.
    // Vamos supor que retorne um objeto para exibir na mensagem.
    // Se o seu Service retorna Query, a lógica muda um pouco.

    // Exemplo conceitual:
    // Livro := Service.BuscarObjeto(Id);
    // if Assigned(Livro) then ShowMessage(Livro.Titulo);

    ShowMessage('Busca realizada (Implementar retorno visual)');
  finally
    Service.Free;
  end;
end;

// 5. Atualizar Livro
procedure TFrmLivros.AtualizarButtonClick(Sender: TObject);
var
  Livro: TLivro;
  Service: TLivroService;
begin
  Service := TLivroService.Create;
  try
    // Para atualizar, precisamos do ID original
    Livro := TLivro.Create(
      StrToIntDef(BuscarInput.Text, 0), // ID vem do campo de busca ou um campo hidden
      StrToIntDef(edtAno.Text, 2024),
      StrToIntDef(edtAutorID.Text, 0),
      edtTitulo.Text,
      edtISBN.Text
    );

    try
      Service.Salvar(Livro); // Service decide se é update pelo ID > 0

      ShowMessage('Livro atualizado com sucesso!');
      CarregarLivros;
      ComecarLimpo;
    finally
      Livro.Free;
    end;
  finally
    Service.Free;
  end;
end;

// 6. Deletar Livro
procedure TFrmLivros.DeletarButtonClick(Sender: TObject);
var
  Service: TLivroService;
  Id: Integer;
begin
  Id := StrToIntDef(DeletarInput.Text, 0);
  Service := TLivroService.Create;
  try
    Service.Excluir(Id);

    ShowMessage('Livro removido com sucesso!');
    CarregarLivros;
    ComecarLimpo;
  finally
    Service.Free;
  end;
end;

// Navegação de Layout
procedure TFrmLivros.BtnMudarInserirClick(Sender: TObject);
begin
  MudarLayout('Inserir');
end;

procedure TFrmLivros.BtnMudarAtualizarClick(Sender: TObject);
begin
  MudarLayout('Atualizar');
end;

procedure TFrmLivros.BtnMudarDeletarClick(Sender: TObject);
begin
  MudarLayout('Deletar');
end;

procedure TFrmLivros.BtnMudarBuscarClick(Sender: TObject);
begin
  MudarLayout('Buscar');
end;

procedure TFrmLivros.FormCreate(Sender: TObject);
begin
  if Assigned(DataModule2) then
    DBGrid1.DataSource := DataModule2.DataSource1;

  CarregarLivros;
  ComecarLimpo;
end;

end.
