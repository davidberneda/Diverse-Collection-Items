unit Tee.Collection;

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
  var t : Integer;
     Item : TPersistent;
  begin
    AReader.ReadValue;

    t:=0;

    ACollection.BeginUpdate;
    try
      while not AReader.EndOfList do
      begin
        if AReader.NextValue in [vaInt8, vaInt16, vaInt32] then
           AReader.ReadInteger;

        Item := ACollection.Items[t];

        AReader.ReadListBegin;

        while not AReader.EndOfList do
              TReaderAccess(AReader).ReadProperty(Item);

        AReader.ReadListEnd;

        Inc(t);
      end;

      AReader.ReadListEnd;
    finally
      ACollection.EndUpdate;
    end;
  end;

  procedure CreateItems;
  var tmp,
      t : Integer;
      tmpClass : TClass;
      tmpS : String;
  begin
    tmp:=AReader.ReadInteger;

    ACollection.BeginUpdate;
    try
      ACollection.Clear;

      for t:=0 to tmp-1 do
      begin
        tmpS:=AReader.ReadString;

        if tmpS='' then
           tmpS:=ACollection.ItemClass.ClassName;

        tmpClass:=FindClass(tmpS);
        TCollectionItemClass(tmpClass).Create(ACollection);
      end;
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
  var t : Integer;
      tmp : TPersistent;
  begin
    AWriter.WriteInteger(ACollection.Count);

    for t := 0 to ACollection.Count - 1 do
    begin
      tmp:=ACollection.Items[t];

      if tmp.ClassType=ACollection.ItemClass then
         AWriter.WriteString('')
      else
         AWriter.WriteString(tmp.ClassName);
    end;
  end;

begin
  AWriter.WriteListBegin;

  WriteItems;
  AWriter.WriteCollection(ACollection);

  AWriter.WriteListEnd;
end;

end.
