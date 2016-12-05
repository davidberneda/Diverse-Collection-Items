unit MyComponent;

interface

uses
  Classes;

type
  // Base Item class
  TItem=class(TCollectionItem)
  private
    FFoo : String;
  published
    property Foo:String read FFoo write FFoo;
  end;

  // Some more Item classes examples

  TItem2=class(TItem)
  private
    FBar : Integer;
  published
    property Bar:Integer read FBar write FBar;
  end;

  TItem3=class(TItem2)
  private
    FTest : Single;
  published
    property Test:Single read FTest write FTest;
  end;

  // Simple TCollection, using base class TItem

  TMyCollection=class(TOwnedCollection)
  private
    function Get(Index:Integer):TItem;
    procedure Put(Index:Integer; Item:TItem);
  public
    property Items[Index:Integer]:TItem read Get write Put; default;
  end;

  // Example Component

  TComp=class(TComponent)
  private
    FCollection : TMyCollection;

    procedure ReadCollection(Reader: TReader);
    procedure WriteCollection(Writer: TWriter);
    procedure SetCollection(const Value:TMyCollection);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    Constructor Create(Owner:TComponent); override;
    Destructor Destroy; override;
  published
    property Collection:TMyCollection read FCollection write SetCollection stored False;
  end;

implementation

uses
  Tee.Collection;

{ TMyCollection }

function TMyCollection.Get(Index:Integer):TItem;
begin
  result:=inherited Items[Index] as TItem;
end;

procedure TMyCollection.Put(Index:Integer; Item:TItem);
begin
  inherited Items[Index]:=Item;
end;

{ TComp }

Constructor TComp.Create(Owner:TComponent);
begin
  inherited;
  FCollection:=TMyCollection.Create(Self,TItem);
end;

Destructor TComp.Destroy;
begin
  FCollection.Free;
  inherited;
end;

procedure TComp.SetCollection(const Value:TMyCollection);
begin
  FCollection.Assign(Value);
end;

procedure TComp.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('_Coll',ReadCollection,WriteCollection,FCollection.Count>0);
end;

procedure TComp.ReadCollection(Reader: TReader);
begin
  TPersistCollection.Read(FCollection,Reader);
end;

procedure TComp.WriteCollection(Writer: TWriter);
begin
  TPersistCollection.Write(FCollection,Writer);
end;

// Important, Item classes must be registered
initialization
  RegisterClasses([TItem,TItem2,TItem3]);
end.
