unit uFormPrincipal;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls, ComCtrls,
  StdCtrls;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    btnLivros: TButton;
    btnAutores: TButton;
    btnEmprestimos: TButton;
    inutil: TLabel;
    procedure btnLivrosClick(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFormLivros;

{$R *.lfm}

{ TFrmPrincipal }

procedure TFrmPrincipal.btnLivrosClick(Sender: TObject);
begin
 Self.Hide;
 if not Assigned(FrmLivros) then
    FrmLivros := TFrmLivros.Create(nil);

  try

    FrmLivros.ShowModal;
  finally

    FreeAndNil(FrmLivros);
    Self.Show;
  end;
end;

{ TFrmPrincipal }



end.
