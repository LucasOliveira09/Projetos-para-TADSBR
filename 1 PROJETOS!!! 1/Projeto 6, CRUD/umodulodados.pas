unit uModuloDados;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset;

type

  { TDataModule2 }

  TDataModule2 = class(TDataModule)
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
  private

  public

  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.lfm}

end.

