unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Sinal: TComboBox;
    num1: TEdit;
    num2: TEdit;
    ResultadoCalc: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure num1Change(Sender: TObject);
    procedure ResultadoCalcClick(Sender: TObject);
    procedure SinalChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
var
  nume1, nume2, Resultado : Real;
  sinalStr : String;
begin
  nume1 := StrToFloat(num1.Text);
  nume2 := StrToFloat(num2.Text);
  sinalStr := Sinal.Text;

  case sinalStr of
  '+': Resultado := nume1 + nume2;
  '-': Resultado := nume1 - nume2;
  '*': Resultado := nume1 * nume2;
  '/': if nume2 <> 0 then
          Resultado := nume1 / nume2;
  else
    ShowMessage('Numero inserido é invalido')
  end;




  ResultadoCalc.Caption := FormatFloat('0.00', Resultado);
end;

procedure TForm1.num1Change(Sender: TObject);
begin

end;

procedure TForm1.ResultadoCalcClick(Sender: TObject);
begin

end;

procedure TForm1.SinalChange(Sender: TObject);
begin

end;

end.

