# Unit Tee.Collection with two methods to read and write a TCollection to a TStream.

The difference with typical TStream WriteCollection is this code is capable of writing TCollection items that are of different class types.

(Not all items in the TCollection are exactly ItemClass)

## Usage:

  * Declare your published TCollection property with "stored False" clause:
  
  ```delphi
  type
    TMyCollection = class(TCollection) // or TOwnerCollection or whatever
    ...
    end;
    
    TMyComponent=class(TComponent)
    private
      FMyCollection : TMyCollection;
      ...
    published
      property MyCollection : TMyCollection read FMyCollection write SetMyCollection stored False;
    end;
  ```
  
  * Add a protected DefineProperties method:
  
  ```delphi
  TMyComponent = class(TComponent)
  ...
  protected
    procedure DefineProperties(Filer: TFiler); override;
  ...
  ``` 

  * DefineProperties typical code is:
  
  ```delphi
  procedure TMyComponent.DefineProperties(Filer: TFiler);
  begin
    inherited;
    ...
    // Choose any name (eg: "_Coll"), it will be hidden
    Filer.DefineProperty('_Coll', ReadColl, WriteColl, FMyCollection.Count>0);
  end;
  ```
  
  * Then the ReadColl and WriteColl methods just call a method:
  
  ```delphi
  uses
    Tee.Collection;
    
  procedure TMyComponent.ReadColl(Reader: TReader);
  begin
    TPersistCollection.Read(FMyCollection,Reader);
  end;

  procedure TMyComponent.WriteColl(Writer: TWriter);
  begin
    TPersistCollection.Write(FMyCollection, Writer);
  end;
  ```
  
## Notes:

  * Items should be of TCollection.ItemClass type or derived from it:
  
  ```delphi
  type
    TMyItem = class(TCollectionItem) ... end;
    
    TMyItem2 = class(TMyItem) ... end; // derived class
    
    TMyItem3 = class(TMyItem) ... end;  // another derived class
  ```
  
  * Item classes should be registered (typically at your unit's initialization section):
  
  ```delphi
  initialization
    RegisterClasses([ TMyItem, TMyItem2, TMyItem3 ]);
  end.
  ```
  
  
