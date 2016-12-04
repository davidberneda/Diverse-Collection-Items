unit MyComponent;

interface

uses
  Classes;

type
  TItem=class(TCollectionItem)
  private
    FFoo : String;
  published
    property Foo:String read FFoo write FFoo;
  end;

  TItem2=class(TItem)
  private
    FBar : Integer;
  published
    property Bar:Integer read FBar write FBar;
  end;

  TColl=class(TOwnedCollection)
  private
    function Get(Index:Integer):TItem;
    procedure Put(Index:Integer; Item:TItem);
  public
    property Items[Index:Integer]:TItem read Get write Put; default;
  end;

  TComp=class(TComponent)
  private
    FColl : TColl;

    procedure ReadColl(Reader: TReader);
    procedure WriteColl(Writer: TWriter);
    procedure SetColl(Value:TColl);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    Constructor Create(Owner:TComponent); override;
    Destructor Destroy; override;
  published
    property Coll:TColl read FColl write SetColl stored False;
  end;

procedure Register;

implementation

uses
  Tee.Collection;

function TColl.Get(Index:Integer):TItem;
begin
  result:=inherited Items[Index] as TItem;
end;

procedure TColl.Put(Index:Integer; Item:TItem);
begin
  inherited Items[Index]:=Item;
end;

Constructor TComp.Create(Owner:TComponent);
begin
  inherited;
  FColl:=TColl.Create(Self,TItem);
end;

Destructor TComp.Destroy;
begin
  FColl.Free;
  inherited;
end;

procedure TComp.SetColl(Value:TColl);
begin
  FColl.Assign(Value);
end;

procedure TComp.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('_Coll',ReadColl,WriteColl,FColl.Count>0);
end;

procedure TComp.ReadColl(Reader: TReader);
begin
  TPersistCollection.Read(FColl,Reader);
end;

procedure TComp.WriteColl(Writer: TWriter);
begin
  TPersistCollection.Write(FColl,Writer);
end;

procedure Register;
begin
  RegisterComponents('TColl',[TComp]);
end;

initialization
  RegisterClasses([TItem,TItem2]);
end.
