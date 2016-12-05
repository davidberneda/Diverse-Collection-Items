object FormExample: TFormExample
  Left = 0
  Top = 0
  Caption = 'Diverse TCollection Items Persistence Example'
  ClientHeight = 438
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 390
    Width = 455
    Height = 13
    Caption = 
      'Right-click Comp1 to show menu capable of adding Items of differ' +
      'ent class types'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 120
    Top = 8
    Width = 337
    Height = 361
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Add Items'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Clear Items'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Comp1: TComp
    Left = 32
    Top = 320
    _Coll = (
      3
      ''
      'TItem2'
      'TItem3'
      <
        item
          Foo = 'hhh'
        end
        item
          Bar = 123
        end
        item
          Bar = 0
          Test = 456.789001464843800000
        end>)
  end
end
