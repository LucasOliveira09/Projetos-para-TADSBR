unit uFormLivros;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  ZDataset, uLivro, uLivroDAO, uModuloDados;

type

  { TFrmLivros }

  TFrmLivros = class(TForm)
    btnVoltar: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DataSource1: TDataSource;
    ZQuery1: TZQuery;
    procedure btnVoltarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    FQueryLivros : TZQuery;
    DAO : TLivroDAO;
  public
  end;

var
  FrmLivros: TFrmLivros;

implementation

{$R *.lfm}

procedure TFrmLivros.FormShow(Sender: TObject);
var
  DAO: TLivroDAO;
begin
  DAO := TLivroDAO.Create(GetConnection);
  try
    DAO.ListarLivrosParaDataset(ZQuery1);
  finally
    DAO.Free;
  end;
end;

procedure TFrmLivros.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;





procedure TFrmLivros.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(FQueryLivros) then FQueryLivros.Free;
  if Assigned(DAO) then DAO.Free;
end;

procedure TFrmLivros.btnVoltarClick(Sender: TObject);
begin
   Close;
  end;

end.
