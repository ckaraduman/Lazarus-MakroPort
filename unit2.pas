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
    Label14: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

uses
  Unit1;

procedure TForm2.Button4Click(Sender: TObject);
var
  mx_time:String;
  user_id:integer;
  GetIpPub:String;
begin
     Form1.ZQuery2.SQL.Clear;
     mx_time:=FormatDateTime('DD MM YYYY hh:nn:ss', now);
     Edit2.Caption:='update m_user_logs set system_exit_time="'+mx_time+'" where user_id='+IntToStr(userid)+' and system_entry_time='+usertime+' and user_ip='+userip;
     //ZQuery2.SQL.Add('insert into m_user_logs (user_id, system_entry_time, user_ip) values ('+IntToStr(user_id)+',"'+mx_time+'", "'+GetIpPub+'")');
     Form1.ZQuery2.SQL.Add('update m_user_logs set system_exit_time="'+mx_time+'" where user_id='+IntToStr(userid)+' and system_entry_time="'+usertime+'" and user_ip="'+userip+'"');
     Form1.ZQuery2.ExecSQL;
     Form1.ZQuery2.Close;
     Application.Terminate;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
mx_time:String;
user_id:integer;
GetIpPub:String;
begin
  Application.MessageBox('Yazılımı kapatmak istediğinize emin misiniz?','MakroPort Onay Mesajı');
  Form1.ZQuery2.SQL.Clear;
     mx_time:=FormatDateTime('DD MM YYYY hh:nn:ss', now);
     Edit2.Caption:='update m_user_logs set system_exit_time="'+mx_time+'" where user_id='+IntToStr(userid)+' and system_entry_time='+usertime+' and user_ip='+userip;
     //ZQuery2.SQL.Add('insert into m_user_logs (user_id, system_entry_time, user_ip) values ('+IntToStr(user_id)+',"'+mx_time+'", "'+GetIpPub+'")');
     Form1.ZQuery2.SQL.Add('update m_user_logs set system_exit_time="'+mx_time+'" where user_id='+IntToStr(userid)+' and system_entry_time="'+usertime+'" and user_ip="'+userip+'"');
     Form1.ZQuery2.ExecSQL;
     Form1.ZQuery2.Close;
     Application.Terminate;
end;

procedure TForm2.Button1Click(Sender: TObject);
var hashTexto : TSHA1Digest;
begin
     hashTexto := Sha1String( Edit1.Text );
     Edit2.Caption:= SHA1Print( hashTexto );
end;
end.

