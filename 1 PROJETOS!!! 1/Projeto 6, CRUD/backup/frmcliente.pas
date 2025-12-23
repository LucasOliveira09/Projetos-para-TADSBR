unit frmCliente;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, DB, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, uCliente, uClienteDAO, uModuloDados, uClienteController, uClienteService;

type

  { TFormCliente }

  TFormCliente = class(TForm)
    BuscarButton: TButton;
    AtualizarButton: TButton;
    DBGrid1: TDBGrid;
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
     procedure MudarLayout(Acao: String);
  public
    procedure ComecarLimpo;
    procedure CarregarUsuarios;


  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.lfm}

{ TFormCliente }
procedure TFormCliente.ComecarLimpo;
begin
  // Esconde TUDO de Inserção
  InserirInput1.Visible := False; InserirInput2.Visible := False; InserirInput3.Visible := False;
  InserirLabel1.Visible := False; InserirLabel2.Visible := False; InserirLabel3.Visible := False; InserirLabel4.Visible := False;

  // Esconde TUDO de Busca
  BuscarInput.Visible := False; BuscarLabel.Visible := False;

  // Esconde TUDO de Deleção
  DeletarInput.Visible := False; DeletarLabel.Visible := False;

  // Esconde TUDO de Atualização
  AtualizarInput1.Visible := False; AtualizarInput2.Visible := False; AtualizarInput3.Visible := False; AtualizarInput4.Visible := False;
  AtualizarLabel1.Visible := False; AtualizarLabel2.Visible := False; AtualizarLabel3.Visible := False; AtualizarLabel4.Visible := False; AtualizarLabel5.Visible := False;

  // ESCONDE OS BOTÕES DE EXECUÇÃO
  InserirButton.Visible := False;
  BuscarButton.Visible := False;
  AtualizarButton.Visible := False;
  DeletarButton.Visible := False;
end;

procedure TFormCliente.CarregarUsuarios;
var
  DAO: TClienteDAO;
begin


    DAO := TClienteDAO.Create(DataModule2.ZConnection1);

    try

      DAO.Carregar(DataModule2.ZQuery1);
    finally

      DAO.Free;
    end;
end;

procedure TFormCliente.MudarLayout(Acao: String);
begin
  ComecarLimpo; // Primeiro limpamos o visual

  if Acao = 'Inserir' then
  begin
    InserirInput1.Visible := True; InserirInput2.Visible := True; InserirInput3.Visible := True;
    InserirLabel1.Visible := True; InserirLabel2.Visible := True; InserirLabel3.Visible := True; InserirLabel4.Visible := True;
    InserirButton.Visible := True;
  end
  else if Acao = 'Buscar' then
  begin
    BuscarInput.Visible := True;
    BuscarLabel.Visible := True;
    BuscarButton.Visible := True;
  end
  else if Acao = 'Atualizar' then
  begin
    AtualizarInput1.Visible := True; AtualizarInput2.Visible := True; AtualizarInput3.Visible := True; AtualizarInput4.Visible := True;
    AtualizarLabel1.Visible := True; AtualizarLabel2.Visible := True; AtualizarLabel3.Visible := True; AtualizarLabel4.Visible := True; AtualizarLabel5.Visible := True;
    AtualizarButton.Visible := True;
  end
  else if Acao = 'Deletar' then
  begin
    DeletarInput.Visible := True;
    DeletarLabel.Visible := True;
    DeletarButton.Visible := True;
  end;
end;


procedure TFormCliente.Label1Click(Sender: TObject);
begin

end;


procedure TFormCliente.InserirButtonClick(Sender: TObject);
  var
  Cliente: TCliente;
  Service: TClienteService;
begin
  Service := TClienteService.Create(DataModule2.ZConnection1);
  try
    Cliente := TCliente.Create(
      0,
      StrToInt(InserirInput3.Text),
      InserirInput2.Text,
      InserirInput1.Text
    );

    try

      Service.CriarCliente(Cliente.Nome, Cliente.Email, Cliente.Telefone);

      ShowMessage('Cliente inserido com sucesso!');

      CarregarUsuarios;
      ComecarLimpo;
    finally
      Service.Free;
    end;
  finally
    Cliente.Free;
  end;
end;

procedure TFormCliente.BuscarButtonClick(Sender: TObject);
  var
  Id : Integer;
  Cliente: TCliente;
  Service : TClienteService;
  Controller : TClienteController;
    begin
       Id := StrToInt(BuscarInput.Text);
       Service := TClienteService.Create(DataModule2.ZConnection1);

       try
        Cliente := Service.BuscarPorID(Id);
        ShowMessage('Cliente encontrado: ' + Controller.FormatarParaExibicao(Cliente));
       finally
       Service.Free;
       end;
end;

procedure TFormCliente.AtualizarButtonClick(Sender: TObject);
  var
    Cliente: TCliente;
    Service: TClienteService;
  begin
    Service := TClienteService.Create(DataModule2.ZConnection1);
    try
      Cliente := TCliente.Create(
        StrToInt(AtualizarInput4.Text),
        StrToInt(AtualizarInput3.Text),
        AtualizarInput1.Text,
        AtualizarInput2.Text
      );

      try

        Service.AtualizarCliente(Cliente);

        ShowMessage('Cliente atualizado com sucesso!');

        CarregarUsuarios;
        ComecarLimpo;
      finally

        Service.Free;
      end;

    finally

      Cliente.Free;
    end;
end;

procedure TFormCliente.DeletarButtonClick(Sender: TObject);
var
Service : TClienteService;
Id : Integer;
begin
     Id := StrToIntDef(DeletarInput.Text, 0);
     Service := TClienteService.Create(DataModule2.ZConnection1);
     try
      Service.Deletar(Id);

      ShowMessage('Cliente removido com sucesso!');

      CarregarUsuarios;
      ComecarLimpo;
  finally
    DAO.Free;
  end;
end;


procedure TFormCliente.Button2Click(Sender: TObject);
begin
  MudarLayout('Inserir');
end;

procedure TFormCliente.Button3Click(Sender: TObject);
begin
  MudarLayout('Atualizar');
end;

procedure TFormCliente.Button4Click(Sender: TObject);
begin
  MudarLayout('Deletar');
end;

procedure TFormCliente.Button5Click(Sender: TObject);
begin
  MudarLayout('Buscar');
end;

procedure TFormCliente.FormCreate(Sender: TObject);
begin
  if Assigned(DataModule2) then
    DBGrid1.DataSource := DataModule2.DataSource1;

  CarregarUsuarios;
  ComecarLimpo;
end;

end.

