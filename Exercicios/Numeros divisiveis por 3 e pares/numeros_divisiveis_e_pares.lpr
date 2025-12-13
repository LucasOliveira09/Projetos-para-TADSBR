program numeros_divisiveis_e_pares;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;
const
  NUM_LIMITE = 100;
var
  i : Integer;
  contOf : Integer;
  somPar : Integer;

begin
  somPar := 0;
  for i := 1 to NUM_LIMITE do
      begin
      if i mod 2 = 0 then
         somPar := somPar + i;
      if i mod 3 = 0 then
         contOf := contOf + 1;
      end;

  writeln('A soma de todos os numeros pares é ' + IntToStr(somPar) + ' e existem ' + IntToStr(contOf) + ' numeros divisiveis por 3!');
  writeln('');
  writeln('');
  writeln('');
  writeln('Pressione enter para finalizar...');
  readln;



end.

