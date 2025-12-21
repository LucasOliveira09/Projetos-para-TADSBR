unit uCliente;

{$mode objfpc}{$H+}

interface

type
  TCliente = class
  private
    FID: Integer;
    FNome: String;
    FEmail: String;
    FTelefone: Integer;
  public
    constructor Create(ID, Telefone: Integer; Nome, Email: String);

    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Email: String read FEmail write FEmail;
    property Telefone: Integer read FTelefone write FTelefone;
  end;


implementation

{$R *.lfm}

constructor TCliente.Create(ID, Telefone: Integer; Nome, Email: String);
begin
  FID := ID;
  FNome := Nome;
  FEmail := Email;
  FTelefone := Telefone;
end;

end.

