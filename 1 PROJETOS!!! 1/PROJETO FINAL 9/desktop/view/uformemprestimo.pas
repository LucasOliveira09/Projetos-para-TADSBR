unit uFormEmprestimo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, DB,
  ZDataset, uEmprestimosDAO, uModuloDados;

type

  { TFrmEmprestimo }

  TFrmEmprestimo = class(TForm)
    btn: TButton;
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    Label3: TLabel;
    Query: TZQuery;


    procedure btnVoltarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DAO: TEmprestimosDAO;

  public

  end;

var
  FrmEmprestimo: TFrmEmprestimo;

implementation

{$R *.lfm}

procedure TFrmEmprestimo.FormShow(Sender: TObject);
begin
  DAO := TEmprestimosDAO.Create(GetConnection);
  try
    DAO.ListarEmprestimosParaDataset(Query);



  except
    on E: Exception do
      ShowMessage('Erro ao carregar empréstimos: ' + E.Message);
  end;
end;

procedure TFrmEmprestimo.FormClose(Sender: TObject);
begin
  if Assigned(DAO) then
  begin
    DAO.Free;
    DAO := nil;
  end;
end;

procedure TFrmEmprestimo.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEmprestimo.DataSourceDataChange(Sender: TObject; Field: TField);
begin

end;


end.

