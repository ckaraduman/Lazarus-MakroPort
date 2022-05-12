unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql80conn, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ZConnection, ZDataset, Unit2, Unit3, SHA1, fphttpclient;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  pass:string;
  userid:Integer;
  usertime:String;
  userip:String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     Label3.Caption:=DateToStr(Date());
     Label4.Caption:=TimeToStr(Time());
end;
Function GetIpPub:String;
var
  IdGetIP: TFPHTTPClient;
  Html : String;
const
  gUrlIpA= 'http://dynupdate.no-ip.com/ip.php';
  gUrlIpB= 'http://www.networksecuritytoolkit.org/nst/tools/ip.php';
begin
  try
  IdGetIP:=TFPHTTPClient.Create(nil);
  Result := '';
  try
    Html := IdGetIP.Get(gUrlIpA);
  except
    Html := IdGetIP.Get(gUrlIpB);
  end;
  Result := html;
  finally
    IdGetIP.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Label3.Caption:=DateToStr(Date());
     Label4.Caption:=TimeToStr(Time());
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Form3.Show;
     Form1.Hide;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  hashTexto : TSHA1Digest;
  m_time:String;

  user_id:integer;
begin
     If (Edit1.Text='') then ShowMessage('Lütfen kullanıcı adınızı ve şifrenizi giriniz!')
     else
     begin
     ZConnection1.Connect;
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.Add('select password, id from m_users where user_name="'+Edit1.Text+'"');
     ZQuery1.Open;
     If (ZQuery1.FieldByName('password').IsNull) then ShowMessage('Kullanıcı adı veya şifre hatalı!')
     else
     begin
     pass:=ZQuery1.FieldValues['password'];
           If ((SHA1Print(Sha1String(Edit2.Caption)))=pass) then
           begin
           user_id:=ZQuery1.FieldValues['id'];
           Form2.Show;
           Form1.Hide;
                ZQuery2.SQL.Clear;
                m_time:=FormatDateTime('DD MM YYYY hh:nn:ss', now);
                Form2.Edit2.Caption:=m_time;
                userid := user_id;
                usertime:= m_time;
                userip:= GetIpPub;
                ZQuery2.SQL.Add('insert into m_user_logs (user_id, system_entry_time, user_ip) values ('+IntToStr(user_id)+',"'+m_time+'", "'+GetIpPub+'")');
                ZQuery2.ExecSQL;
                ZQuery2.Close;
           end
           else ShowMessage('Kullanıcı adı veya şifre hatalı!');
     end;
     ZQuery1.Close;
     ZConnection1.Disconnect;
     end;
end;
end.



procedure TForm2.Button2Click(Sender: TObject);
begin

  //ShowMessage(GetIpPub);
end;

