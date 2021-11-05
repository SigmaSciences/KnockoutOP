object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ListBox using a TList<string>'
  ClientHeight = 340
  ClientWidth = 596
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
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = -448
    ExplicitWidth = 1044
    object btnBind: TButton
      Left = 4
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Bind'
      TabOrder = 0
      OnClick = btnBindClick
    end
  end
  object CarsListView: THtPanel
    Left = 0
    Top = 37
    Width = 596
    Height = 303
    Align = alClient
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
      
        '  <select name="cars" id="cars" size="6" width="200" data-bind="' +
        'options: AvailableCarTypes, value: SelectedCar">'
      ''
      '  </select>'
      '</body>')
    HighlightTextColor = 0
    ExplicitLeft = -448
    ExplicitTop = -88
    ExplicitWidth = 1044
    ExplicitHeight = 428
  end
end
