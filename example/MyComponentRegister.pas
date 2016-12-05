unit MyComponentRegister;

interface

uses
  Classes,
  DesignIntf, DesignEditors, PropertyCategories;

procedure Register;

implementation

uses
  MyComponent;

type
  TMyComponentEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer); override;
    function GetVerbCount:Integer; override;
    function GetVerb(Index:Integer):String; override;
  end;

procedure Register;
begin
  RegisterComponents('TColl',[TComp]);

  RegisterComponentEditor(TComp,TMyComponentEditor);
end;

{ TMyComponentEditor }

procedure TMyComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index=GetVerbCount-1 then
     TItem.Create(TComp(Component).Coll).Foo:='abc'
  else
  if Index=GetVerbCount-2 then
     TItem2.Create(TComp(Component).Coll).Bar:=123
  else
  if Index=GetVerbCount-3 then
     TItem3.Create(TComp(Component).Coll).Test:=456.789
  else
     inherited;
end;

function TMyComponentEditor.GetVerb(Index: Integer): String;
begin
  if Index=GetVerbCount-1 then
     result:='Add TItem'
  else
  if Index=GetVerbCount-2 then
     result:='Add TItem2'
  else
  if Index=GetVerbCount-3 then
     result:='Add TItem3'
  else
     result:=inherited;
end;

function TMyComponentEditor.GetVerbCount: Integer;
begin
  result:=inherited+3;
end;

end.
