{-------------------------------------------------------------------------------

KnockoutOP: HTML-based MVVM for Delphi

Copyright (c) 2021 Sigma Sciences Ltd.

Originator: Robert L S Devine

This file is licensed under the Mozilla Public License v2.

-------------------------------------------------------------------------------}

{ TODO : Currently using composition for THTMLView - review design. }

unit KnockoutOP.HTML;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  htmlpars,
  htmldraw,
  htmlcomp,
  htclasses,

  KnockoutOP.Intf;


type
  TDOMNode = THtNode;
  TElement = htmlcomp.TElement;
  TBaseInputElement = htmldraw.TBaseInputElement;
  TInputElement = htclasses.TInputElement;
  TTextAreaElement = htclasses.TTextAreaElement;
  TSelectElement = htclasses.TSelectElement;
  TLabelElement = htclasses.THtLabelElement;

  // -- Note that we translate the HTML names into VCL-style names.
  TElementType = (etUnknown,
                  etButton,
                  etEditBox,
                  etLabel,
                  etMemo,
                  etComboBox,       // TSelectElement
                  etListBox,        // TSelectElement with "size" attribute.
                  etListView        // Unordered list, also used for treeview.
                  );

  TDataBindNode = record
    Element: TElement;
    ParentElement: TElement;
    ElementType: TElementType;
    Bindings: string;
    constructor Create(elem, parentElem: TElement; const eType: TElementType; const bnd: string);
  end;

  TDataBindNodes = TDictionary<string, TDataBindNode>;

  THTMLView = class
  private
    FBindings: TList<IBinding>;
    FView: THtPanel;
    FDataBindNodes: TDataBindNodes;
    function ElementTypeFromHTML(e: TElement): TElementType;
    procedure FindDataBindings(node: THtNode);
    procedure Initialize;
  public
    constructor Create(AOwner: TComponent); overload;
    constructor Create(view: THtPanel); overload;
    destructor Destroy; override;
    function HasDataBinding: boolean;
    procedure AddBinding(binding: IBinding);
    procedure EnumerateDataBindNodes;
    procedure InsertComponent(cmp: TComponent);
    property DataBindNodes: TDataBindNodes read FDataBindNodes;
  end;


implementation

{ THTMLView }

//------------------------------------------------------------------------------
constructor THTMLView.Create(AOwner: TComponent);
begin
  { TODO : Complete the runtime THtPanel creation. }
  FView := THtPanel.Create(AOwner);
  //FView.Parent := AOwner;

  Initialize;
end;
//------------------------------------------------------------------------------
procedure THTMLView.AddBinding(binding: IBinding);
begin
  FBindings.Add(binding);
end;
//------------------------------------------------------------------------------
constructor THTMLView.Create(view: THtPanel);
begin
  FView := view;
  Initialize;
end;
//------------------------------------------------------------------------------
destructor THTMLView.Destroy;
begin
  if assigned(FDataBindNodes) then
    FDataBindNodes.Free;
  FBindings.Free;
  inherited;
end;
//------------------------------------------------------------------------------
function THTMLView.ElementTypeFromHTML(e: TElement): TElementType;
var
  eTag: string;
  typeAttr: string;
begin
  result := etUnknown;

  eTag := e.Tag;
  if SameText(eTag, 'input') then
  begin
    if e.HasAttribute('type') then
    begin
      typeAttr := Trim(e.Attr['type']);
      // -- From a data binding viewpoint, the text and password types can be regarded as text input.
      { TODO : Separate types for email etc.? - for validation. }
      if (SameText(typeAttr, 'text')) or (SameText(typeAttr, 'password')) or
        (SameText(typeAttr, 'email')) or (SameText(typeAttr, 'tel')) or (SameText(typeAttr, 'url')) then
        result := etEditBox
      else if SameText(typeAttr, 'button') then     // -- It's a Form button.
        result := etButton
      else if SameText(typeAttr, 'textarea') then   // -- It's a Form textarea.
        result := etMemo;
    end
    else
      result := etEditBox;
  end
  else if SameText(eTag, 'button') then
    result := etButton
  else if SameText(eTag, 'textarea') then
    result := etMemo
  else if SameText(eTag, 'label') then
    result := etLabel
  else if SameText(eTag, 'select') then
  begin
    if e.HasAttribute('size') then
      result := etListBox
    else
      result := etComboBox;
  end;
end;
//------------------------------------------------------------------------------
procedure THTMLView.EnumerateDataBindNodes;
var
  node: THtNode;
begin
  FDataBindNodes.Clear;

  for node in FView.Document.Nodes do
    FindDataBindings(node);
end;
//------------------------------------------------------------------------------
procedure THTMLView.FindDataBindings(node: THtNode);
var
  childNode: THtNode;
  eType: TElementType;
  e: TElement;
  pNode: THtNode;
  pe: TElement;
begin
  for childNode in node.Nodes do
  begin
    if childNode.HasAttribute('data-bind') then
      if childNode.HasAttribute('id') then
      begin
        if (Trim(childNode.Attr['id']) <> '') and (Trim(childNode.Attr['data-bind']) <> '') then
        begin
          e := childNode as TElement;
          eType := ElementTypeFromHTML(e);
          if eType <> etUnknown then
          begin
            pNode := childNode.Parent;
            if pNode is TElement then
              pe := pNode as TElement
            else
              pe := nil;

            FDataBindNodes.Add(childNode.Attr['id'], TDataBindNode.Create(childNode as TElement, pe, eType, childNode.Attr['data-bind']));
          end
          else
            raise Exception.Create('Error: Unknown element type in ' + childNode.TextContent);
        end;
      end
      else
        raise Exception.Create('Data-Bind node has no id: ' + childNode.Attr['data-bind']);
    FindDataBindings(childNode);
  end;
end;
//------------------------------------------------------------------------------
function THTMLView.HasDataBinding: boolean;
begin
  result := FDataBindNodes.Count > 0;
end;
//------------------------------------------------------------------------------
procedure THTMLView.Initialize;
begin
  FDataBindNodes := TDataBindNodes.Create;
  FBindings := TList<IBinding>.Create;
end;
//------------------------------------------------------------------------------
procedure THTMLView.InsertComponent(cmp: TComponent);
begin
  FView.InsertComponent(cmp);
end;


{ TDataBindNode }

//------------------------------------------------------------------------------
constructor TDataBindNode.Create(elem, parentElem: TElement; const eType: TElementType; const bnd: string);
begin
  Element := elem;
  ParentElement := parentElem;
  ElementType := eType;
  Bindings := bnd;
end;

end.
