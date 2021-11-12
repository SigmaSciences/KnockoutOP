object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Radio Group Demo'
  ClientHeight = 380
  ClientWidth = 685
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
  object RadioGroupView: THtPanel
    Left = 0
    Top = 37
    Width = 685
    Height = 343
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
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
      '  <fieldset>'
      '    <legend>&nbsp;Select a Contact Method&nbsp;</legend>'
      ''
      '    <input type="radio" id="contactChoice1"'
      
        '     name="contact" value="email" data-bind="checked: ContactTyp' +
        'e">'
      '    <label for="contactChoice1">Email</label>'
      ''
      '    <input type="radio" id="contactChoice2"'
      
        '     name="contact" value="phone" data-bind="checked: ContactTyp' +
        'e">'
      '    <label for="contactChoice2">Phone</label>'
      ''
      '    <input type="radio" id="contactChoice3"'
      
        '     name="contact" value="mail" data-bind="checked: ContactType' +
        '">'
      '    <label for="contactChoice3">Mail</label>'
      '  </fieldset>'
      '</form>'
      '<br/>'
      
        '<label id="lblcontacttype" data-bind="text: ContactNotification"' +
        '>We will contact you via...</label>'
      '</body>'
      ''
      ''
      '')
    HighlightTextColor = 0
    ExplicitLeft = 44
    ExplicitTop = 76
    ExplicitWidth = 591
    ExplicitHeight = 279
  end
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 685
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitWidth = 649
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
end
