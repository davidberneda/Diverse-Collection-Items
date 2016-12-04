unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TeeCollection, Vcl.StdCtrls, MyComponent;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Comp1: TComp;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var o,m : TMemoryStream;
begin
  m:=TMemoryStream.Create;
  try
    m.WriteComponent(Comp1);

    m.Position:=0;

    o:=TMemoryStream.Create;
    try
      ObjectBinaryToText(m,o);
      o.Position:=0;

      Memo1.Lines.LoadFromStream(o);
    finally
      o.Free;
    end;

  finally
    m.Free;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var i2 : TItem2;
    i : TItem;
begin
  i:=TItem.Create(Comp1.Coll);
  i.Foo:='abc';


  i2:=TItem2.Create(Comp1.Coll);
  i2.Foo:='i2';
  i2.Bar:=1234;
end;

procedure TForm2.Button3Click(Sender: TObject);
var m : TMemoryStream;
    tmp : TComp;
begin
  m:=TMemoryStream.Create;
  try
    m.WriteComponent(Comp1);

    m.Position:=0;

    tmp:=TComp.Create(Self);
    try
      m.ReadComponent(tmp);
    finally
      tmp.Free;
    end;

  finally
    m.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Comp1:=TComp.Create(Self);
end;

end.
