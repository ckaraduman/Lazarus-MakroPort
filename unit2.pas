unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SHA1;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm2.Button1Click(Sender: TObject);
var hashTexto : TSHA1Digest;
begin
     hashTexto := Sha1String( Edit1.Text );
     Edit2.Caption:= SHA1Print( hashTexto );
end;
end.

