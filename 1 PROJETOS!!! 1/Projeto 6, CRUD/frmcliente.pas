unit frmCliente;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, uCliente, uClienteController;

type

  { TFormCliente }

  TFormCliente = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.lfm}

{ TFormCliente }

procedure TFormCliente.Label1Click(Sender: TObject);
begin

end;

procedure TFormCliente.Button1Click(Sender: TObject);
begin

end;

end.

