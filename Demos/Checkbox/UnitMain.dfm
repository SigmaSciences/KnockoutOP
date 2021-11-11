object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Checkbox Demo'
  ClientHeight = 337
  ClientWidth = 646
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
    Width = 646
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = -3
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
  object CheckBoxView: THtPanel
    Left = 0
    Top = 37
    Width = 646
    Height = 300
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
      
        '    <input type="checkbox" id="cbtest1" name="cbtest1" checked d' +
        'ata-bind="checked: IsChecked">'
      '    <label for="cbtest1"> This is a test checkbox</label>'
      '    <br/>'
      '  </form>'
      '   <br/>'
      '    <label>Check Status:</label>'
      
        '    <label id="lblcheckstatus" data-bind="text: CheckStatus">Ini' +
        'tially checked</label>'
      '</body>')
    HighlightTextColor = 0
    ExplicitLeft = -3
    ExplicitTop = 27
    ExplicitWidth = 649
    ExplicitHeight = 310
  end
end
