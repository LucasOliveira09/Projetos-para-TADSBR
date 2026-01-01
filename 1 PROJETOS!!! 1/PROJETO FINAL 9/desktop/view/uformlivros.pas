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

end.
