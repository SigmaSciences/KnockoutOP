object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'KnockoutOP Buttons Demo'
  ClientHeight = 374
  ClientWidth = 664
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 664
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object btnBind: TButton
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Bind'
      TabOrder = 0
      OnClick = btnBindClick
    end
    object btnSetNumber: TButton
      Left = 98
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Set Number'
      TabOrder = 1
      OnClick = btnSetNumberClick
    end
    object btnHasCellPhone: TButton
      Left = 174
      Top = 4
      Width = 75
      Height = 25
      Caption = 'HasCellPhone'
      TabOrder = 2
      OnClick = btnHasCellPhoneClick
    end
    object btnNoCellPhone: TButton
      Left = 249
      Top = 4
      Width = 75
      Height = 25
      Caption = 'NoCellPhone'
      TabOrder = 3
      OnClick = btnNoCellPhoneClick
    end
  end
  object CellPhoneView: THtPanel
    Left = 0
    Top = 35
    Width = 664
    Height = 339
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
      ' <form>'
      
        '  <label for="cellphoneNumber" id="lblcellphoneNumber">Cell Phon' +
        'e Number:</label>'
      
        '  <input type="text" id="mobileNumber" name="cellNumber" data-bi' +
        'nd="value: cellphoneNumber">'
      
        '  <input type="button" id="mobileNumberBtn" name="cellNumberBtn"' +
        ' data-bind="click: HandleFormButtonClick, enabled: HasCellPhone"' +
        ' value="Form Button">'
      '</form> '
      
        '  <button id="btn1" class="button1" data-bind="click: HandleButt' +
        'onClick">Button 1</button>'
      '  <button id="btn2" class="button2" disabled>Button 2</button>'
      
        '  <button hidden id="btn3" class="button3" data-bind="click: Han' +
        'dleButton3Click">Button 3</button>'
      '  <br/>'
      '  <br/>'
      '</body>')
    HighlightTextColor = 0
    ExplicitLeft = -380
    ExplicitTop = -91
    ExplicitWidth = 1044
    ExplicitHeight = 465
  end
end
