library minhabiblioteca;

{$mode objfpc}{$H+}

uses
  SysUtils;

function Soma(A, B: Integer): Integer;
begin
  Result := A + B;
end;

exports
  Soma;

end.

