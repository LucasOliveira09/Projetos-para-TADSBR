unit uDBConnection;

{$mode Delphi}

interface

uses
  SysUtils, ZConnection;

procedure InitConnection;
procedure FreeConnection;
function GetConnection: TZConnection;

implementation

var
  GConnection: TZConnection;

procedure InitConnection;
begin
  GConnection             := TZConnection.Create(nil);
  GConnection.Protocol    := 'firebird';
  GConnection.Database    := ExtractFilePath(ParamStr(0)) +'crud.fdb';
  GConnection.User        := 'SYSDBA';
  GConnection.Password    := 'masterkey';
  GConnection.LoginPrompt := False;
  GConnection.AutoCommit  := False;
  GConnection.Connect;
end;

function GetConnection: TZConnection;
begin
  if not Assigned(GConnection) then
    InitConnection;

  Result := GConnection;
end;

procedure FreeConnection;
begin
  GConnection.Free;
  GConnection := nil;
end;

initialization
  InitConnection;

finalization
  FreeConnection;

end.
