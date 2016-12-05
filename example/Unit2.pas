unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tee.Collection, Vcl.StdCtrls, MyComponent;

type
  TFormExample = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Comp1: TComp;
    Label1: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

    procedure FillMemo(const AStream:TStream);
    procedure ShowComponent;
  public
    { Public declarations }
  end;

var
  FormExample: TFormExample;

implementation

{$R *.dfm}

function SaveComponent(const AComponent:TComponent):TStream;
begin
  result:=TMemoryStream.Create;
  result.WriteComponent(AComponent);
end;

function ConvertToText(const AStream:TStream):TStream;
begin
  result:=TMemoryStream.Create;
  ObjectBinaryToText(AStream,result);
  result.Position:=0;
end;

procedure TFormExample.FillMemo(const AStream:TStream);
var s : TStream;
begin
  s:=ConvertToText(AStream);
  try
    Memo1.Lines.LoadFromStream(s);
  finally
    s.Free;
  end;
end;

procedure TFormExample.FormCreate(Sender: TObject);
begin
  // Start filling Memo with current Comp1 items:
  ShowComponent;
end;

// Fill Memo with Comp1 persistence
procedure TFormExample.ShowComponent;
var s : TStream;
begin
  s:=SaveComponent(Comp1);
  try
    s.Position:=0;

    FillMemo(s);
  finally
    s.Free;
  end;
end;

procedure TFormExample.Button1Click(Sender: TObject);
begin
  ShowComponent;
end;

// Just add several Items of different class types to Comp1.Collection
procedure TFormExample.Button2Click(Sender: TObject);
var i : TItem;
    i2 : TItem2;
    i3 : TItem3;
begin
  i:=TItem.Create(Comp1.Collection);
  i.Foo:='abc';

  i2:=TItem2.Create(Comp1.Collection);
  i2.Foo:='i2';
  i2.Bar:=1234;

  i3:=TItem3.Create(Comp1.Collection);
  i3.Foo:='i2';
  i3.Bar:=1234;
  i3.Test:=456.789;

  ShowComponent;
end;

procedure TFormExample.Button3Click(Sender: TObject);
var s : TStream;
begin
  s:=SaveComponent(Comp1);
  try
    s.Position:=0;

    Comp1.Free;

    Comp1:=TComp.Create(Self);
    s.ReadComponent(Comp1);

    s.Position:=0;
    FillMemo(s);
  finally
    s.Free;
  end;
end;

procedure TFormExample.Button4Click(Sender: TObject);
begin
  Comp1.Collection.Clear;
  ShowComponent;
end;

end.
