program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}

  cthreads,
  {$ENDIF}
  Classes,
  SysUtils
  ;
var
  name : String;
  sSalario: String;
  salario: Real;
  idade : Integer;

begin
 writeln('Qual seu nome');
 readln(name);
 writeln('Qual sua idade');
 readln(idade);
 writeln('Quanto voce recebe');
 readln(sSalario);
 salario := StrToFloat(sSalario);
 salario := salario * 1.1;

 writeln(name + ' tem ' + IntToStr(idade) + ' anos e ganhara ' + FormatFloat('R$0.00', salario) + ' com aumento!');
 readln;
end.

