unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uCliente, ZDataset, ZConnection;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;


var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

uses ZQuery;

{ TDataModule1 }

procedure TDataModule1.ZConnection1AfterConnect(Sender: TObject);
begin

end;

end.

