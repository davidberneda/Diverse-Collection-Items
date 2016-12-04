object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 404
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 120
    Top = 8
    Width = 337
    Height = 361
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Add Item2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Comp1: TComp
    Left = 40
    Top = 24
    _Coll = (
      1
      ''
      <
        item
          Foo = 'hhh'
        end>)
  end
end
