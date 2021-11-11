object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Dependent Label'
  ClientHeight = 347
  ClientWidth = 649
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
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 649
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
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
  object DependentLabelView: THtPanel
    Left = 0
    Top = 37
    Width = 649
    Height = 310
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
      ''
      '  <br/>'
      '  <form>'
      '    <label for="firstname" id="lblfirstname">First Name:</label>'
      
        '    <input type="text" id="firstname" name="firstname" data-bind' +
        '="value: FirstName">'
      '    <br/>'
      '    <br/>'
      '    <label for="lastname" id="lbllastname">Last Name:</label>'
      
        '    <input type="text" id="lastname" name="lastname" data-bind="' +
        'value: LastName">'
      '  </form>'
      '   <br/>'
      '    <label>Full Name:</label>'
      
        '    <label id="lblfullname" data-bind="text: FullName">FullName<' +
        '/label>'
      '</body>')
    HighlightTextColor = 0
  end
end
