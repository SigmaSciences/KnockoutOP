object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Combobox Observable Array'
  ClientHeight = 361
  ClientWidth = 612
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 612
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object btnAddItem: TButton
      Left = 82
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Add Item'
      TabOrder = 0
      OnClick = btnAddItemClick
    end
    object btnBind: TButton
      Left = 4
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Bind'
      TabOrder = 1
      OnClick = btnBindClick
    end
  end
  object CarsView: THtPanel
    Left = 0
    Top = 37
    Width = 612
    Height = 324
    Align = alClient
    Caption = 'CarsView'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Touch.InteractiveGestures = [igZoom, igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia]
    Touch.ParentTabletOptions = False
    Touch.TabletOptions = [toPressAndHold, toSmoothScrolling]
    HTML.Strings = (
      '<!DOCTYPE html>'
      '<body>'
      '  <style>'
      #9'body {'
      '      font-family: "Roboto", sans-serif;'
      '      background: #f7f7f7;'
      '    }'
      #9'</style>'
      ''
      '  <br/>'
      
        '  <input type="text" id="sCar" name="SelCar" data-bind="value: S' +
        'electedCar">'
      '  <br/>'
      '  <br/>'
      
        '  <select name="cars" id="cars" data-bind="options: AvailableCar' +
        'Types, value: SelectedCar">'
      '  </select>'
      '</body>')
    HighlightTextColor = 0
  end
end
