program fun;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

function EhPar(Numero : Integer) : Boolean;
begin
     if Numero mod 2 = 0 then
           Result := True
     else
           Result := False
end;

function CalcularMedia(N1, N2, N3: Real): Real;
begin

     Result := (N1 + N2 + N3) / 3

end;

function ValidarEmail(Email: String): Boolean;
begin

     if Pos('@', Email) > 0 then
           Result := True
     else
           Result := False;

end;

function ContarOcorrencias(Texto, Caractere: String): Integer;
var
  contOco : Integer;
  i : Integer;
begin
     contOco := 0;
     for i := 0 to Texto.length do
     begin
       if Texto[i] = Caractere then
             contOco := contOco + 1;
     end;

     Result := contOco;


end;

begin
   writeln(FloatToStr(CalcularMedia(10, 8, 9)));
   writeln(EhPar(10));
   writeln(ValidarEmail('eumemail@gmail.com'));
   writeln(ValidarEmail('nao e email'));
   writeln(ContarOcorrencias('isso é um teste', 's'));
   readln;
end.

