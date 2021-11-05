object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Objects ComboBox'
  ClientHeight = 349
  ClientWidth = 639
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
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = -455
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
    object btnAddTicket: TButton
      Left = 90
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Add Ticket'
      TabOrder = 1
      OnClick = btnAddTicketClick
    end
  end
  object TicketsView: THtPanel
    Left = 0
    Top = 37
    Width = 347
    Height = 312
    Align = alLeft
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
      
        '  <input type="text" id="tkt" name="ctkt" data-bind="value: Chos' +
        'enTicket.Price">'
      '  <br/>'
      '  <br/>'
      
        '  <select name="tickets" id="tickets" data-bind="options: Ticket' +
        's, value: ChosenTicket, optionsText: Name">'
      '  </select>'
      '</body>')
    HighlightTextColor = 0
  end
  object Memo1: TMemo
    Left = 347
    Top = 37
    Width = 292
    Height = 312
    Align = alClient
    Lines.Strings = (
      'Demonstrates how to bind a combobox to an object '
      'property.'
      ''
      'We use an ObservableArray in the viewmodel to '
      'demonstrate how the list updates when we add a new '
      'item. For static lists we could have used a TList<>.')
    TabOrder = 2
    ExplicitLeft = 384
    ExplicitWidth = 255
  end
end
