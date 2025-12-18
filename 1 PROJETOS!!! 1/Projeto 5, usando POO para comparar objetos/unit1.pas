unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
     procedure abrirLista;

  end;

    TAnimal = class
      private
         FNome : String;
         FIdade : Integer;
      public
         constructor Create(Nome: String; Idade: Integer);
         property Nome: String read FNome;
         property Idade: Integer read FIdade;
         function MakeSom: String; virtual;
    end;

    TGato = class(TAnimal)
       public
          function MakeSom: String; override;
       end;

    TCachorro = class(TAnimal)
       public
          function MakeSom: String; override;
       end;


var
  Form1: TForm1;

implementation

{$R *.lfm}

constructor TAnimal.Create(Nome: String; Idade: Integer);
begin
  FNome := Nome;
  FIdade := Idade;
end;

function TAnimal.MakeSom : String;
begin
  Result := 'Animal qualquer'
end;

function TGato.MakeSom: String;
begin
  Result := 'miau';
end;

function TCachorro.MakeSom: String;
begin
  Result := 'au au';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  abrirLista;
end;

procedure TForm1.abrirLista;
var
ListaAnimais: TList;
i: integer;
begin
  ListaAnimais := TList.Create;
  try
  ListaAnimais.Add(TCachorro.Create('Kira', 1));
  ListaAnimais.Add(TCachorro.Create('Marley', 5));
  ListaAnimais.Add(TGato.Create('Pandora', 2));

  for i := 0 to ListaAnimais.Count - 1 do
  begin
     ShowMessage(TAnimal(ListaAnimais[i]).Nome + ' ' + TAnimal(ListaAnimais[i]).MakeSom);
  end;

  finally
    ListaAnimais.free
  end;

end;




end.

