{
  https://github.com/davidberneda/Diverse-Collection-Items
}
unit Tee.Collection;

{
  Enable design-time persistence of TCollection properties with
  different TCollectionItem classes.
}

interface

uses
  Classes;

type
  TPersistCollection=record
  public
    class procedure Read(const ACollection:TCollection; const AReader:TReader); static;
    class procedure Write(const ACollection:TCollection; const AWriter:TWriter); static;
  end;

implementation

type
  TReaderAccess=class(TReader);

class procedure TPersistCollection.Read(const ACollection:TCollection;
                                        const AReader:TReader);

  procedure ReadItems;

    procedure ReadProperties(const AItem:TPersistent);
    begin
      AReader.ReadListBegin;

      while not AReader.EndOfList do
            TReaderAccess(AReader).ReadProperty(AItem);

      AReader.ReadListEnd;
    end;

  var t : Integer;
  begin
    AReader.ReadValue;

    t:=0;

    ACollection.BeginUpdate;
    try
      while not AReader.EndOfList do
      begin
        if AReader.NextValue in [vaInt8, vaInt16, vaInt32] then
           AReader.ReadInteger;

        ReadProperties(ACollection.Items[t]);

        Inc(t);
      end;

      AReader.ReadListEnd;
    finally
      ACollection.EndUpdate;
    end;
  end;

  procedure CreateItems;

    function ItemClassName:String;
    begin
      result:=AReader.ReadString;

      if result='' then
         result:=ACollection.ItemClass.ClassName;
    end;

  var Count,
      t : Integer;
  begin
    Count:=AReader.ReadInteger;

    ACollection.BeginUpdate;
    try
      ACollection.Clear;

      for t:=0 to Count-1 do
          TCollectionItemClass(FindClass(ItemClassName)).Create(ACollection);
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  AReader.ReadListBegin;

  CreateItems;
  ReadItems;

  AReader.ReadListEnd;
end;

class procedure TPersistCollection.Write(const ACollection:TCollection;
                                         const AWriter:TWriter);

  procedure WriteItems;

    function ItemClassOf(const AItem:TPersistent):String;
    begin
      if AItem.ClassType=ACollection.ItemClass then
         result:=''
      else
         result:=AItem.ClassName;
    end;

  var Item : TPersistent;
  begin
    AWriter.WriteInteger(ACollection.Count);

    for Item in ACollection do
        AWriter.WriteString(ItemClassOf(Item));
  end;

begin
  AWriter.WriteListBegin;

  WriteItems;
  AWriter.WriteCollection(ACollection);

  AWriter.WriteListEnd;
end;

end.
