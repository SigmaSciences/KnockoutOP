object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TextArea as TMemo'
  ClientHeight = 330
  ClientWidth = 627
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
    Width = 627
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = -417
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
  object TextEditView: THtPanel
    Left = 0
    Top = 37
    Width = 627
    Height = 293
    Align = alClient
    Caption = 'CellPhoneView'
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
      
        '  <textarea id="textedit1" name="textedit1" rows="6" cols="50" d' +
        'ata-bind="value: UserText"></textarea>'
      '  <br/>'
      '  <br/>'
      
        '  <textarea id="textedit2" rows="6" cols="50" data-bind="value: ' +
        'UpperCaseText"></textarea>'
      '  <br/>'
      '</body>')
    HighlightTextColor = 0
    ExplicitLeft = -417
    ExplicitTop = -20
    ExplicitWidth = 1044
    ExplicitHeight = 350
  end
end
