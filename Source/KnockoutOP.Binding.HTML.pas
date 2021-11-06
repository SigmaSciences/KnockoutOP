{-------------------------------------------------------------------------------

Adapted from Knockoff.Binding.Components.

Original file: Copyright (c) 2015 Stefan Glienke - All rights reserved.

Original file at: https://bitbucket.org/sglienke/knockoff

Portions Copyright (c) 2021 Sigma Sciences Ltd.

Originator: Robert L S Devine

Knockoff prototype adapted for use with DelphiHTMLComponents.

-------------------------------------------------------------------------------}

{ TODO : Button shortcut keys. }


unit KnockoutOP.Binding.HTML;

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Rtti,
  System.Types,
  System.Generics.Collections,
  System.TypInfo,

  {$IFNDEF FMX}
  Vcl.Dialogs,
  {$ELSE}
  FMX.Dialogs,
  {$ENDIF}

  Knockoff.Observable,
  KnockoutOP.HTML,
  KnockoutOP.Intf;

type
  TBinding = class(TInterfacedObject, IBinding)
  private
    fSource: IObservable;
    fTarget: TElement;
  protected
    function InitGetValue(const observable: IObservable): TFunc<TValue>; virtual;
    procedure InitSource(const observable: IObservable); virtual;
    procedure InitTarget; virtual;

    property Source: IObservable read fSource;
    property Target: TElement read fTarget;
  public
    constructor Create(const target: TElement;
      const source: IObservable); reintroduce;
  end;

  TBindingClass = class of TBinding;

  TBinding<T: TElement> = class(TBinding)
  private
    function GetTarget: T;
  protected
    property Target: T read GetTarget;
  public
    constructor Create(const target: T; const source: IObservable);
  end;

  TInputElementBinding = class(TBinding<TInputElement>)
  protected
    fProperty: TRttiProperty;
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
  public
    constructor Create(const target: TElement; const source: IObservable;
      const propertyName: string); reintroduce;
  end;

  TButtonBinding = class(TBinding<TInputElement>)
  protected
    procedure HandleClick(Sender: TObject);
    procedure InitTarget; override;
    procedure InitSource(const observable: IObservable); override;
  end;

  TEditBinding = class(TBinding<TInputElement>)
  protected
    procedure HandleChange(Sender: TObject);
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    procedure InitTarget; override;
  end;

  TLabelBinding = class(TBinding<TLabelElement>)
  protected
    procedure HandleChange(Sender: TObject);
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    procedure InitTarget; override;
  end;

  TTextAreaBinding = class(TBinding<TTextAreaElement>)
  protected
    procedure HandleChange(Sender: TObject);
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    procedure InitTarget; override;
  end;

  TSelectItemsBinding = class(TBinding<TSelectElement>)
  private
    FOptionsText: string;
  protected
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    property OptionsText: string read FOptionsText;
  public
    constructor Create(const target: TElement; const source: IObservable;
      const optText: string); reintroduce;
  end;

  TSelectBinding = class(TBinding<TSelectElement>)
  protected
    procedure HandleChange(Sender: TObject);
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    procedure InitTarget; override;
  end;

  TMultiSelectBinding = class(TBinding<TSelectElement>)
  private
    FOptionsText: string;
  protected
    procedure HandleChange(Sender: TObject);
    function InitGetValue(const observable: IObservable): TFunc<TValue>; override;
    procedure InitTarget; override;
    property OptionsText: string read FOptionsText;
  public
    constructor Create(const target: TElement; const source: IObservable;
      const optText: string); reintroduce;
  end;


function GetBindingClass(const targetType: TElementType; const expression: string): TBindingClass;


implementation

//------------------------------------------------------------------------------
function FindSelectedNode(e: TSelectElement): TDOMNode;
var
  node: TDOMNode;
begin
  result := nil;

  for node in e.Nodes do
    if (node.HasAttribute('selected')) and (SameText(node.Attr['selected'], 'true')) then
    begin
      result := node;
      break;
    end;
end;
//------------------------------------------------------------------------------
//-- Compared to the VCL, HTML5 restricts us to a fairly limited number of
//-- possible binding classes.
function GetBindingClass(const targetType: TElementType; const expression: string): TBindingClass;
begin
  result := nil;
  case targetType of
    etEditBox: if SameText(expression, 'value') then result := TEditBinding;
    etLabel: if SameText(expression, 'text') then result := TLabelBinding;
    etMemo: if SameText(expression, 'value') then result := TTextAreaBinding;
    etButton: if SameText(expression, 'click') then result := TButtonBinding;
    etComboBox: begin
      if SameText(expression, 'value') then result := TSelectBinding
      else if SameText(expression, 'options') then result := TSelectItemsBinding;
    end;
    etListBox: begin
      if SameText(expression, 'value') then result := TSelectBinding  // -- Should only be present if multiple = false.
      else if SameText(expression, 'options') then result := TSelectItemsBinding
      else if SameText(expression, 'selectedOptions') then result := TMultiSelectBinding;  // -- multiple = true.
    end;
  end;
end;

var
  ctx: TRttiContext;


type
  // -- TBaseInputElement has a Disabled property rather than VCL-style Enabled.
  TBaseInputElementHelper = class helper for TBaseInputElement
  private
    function GetEnabled: Boolean;
    procedure SetEnabled(const value: Boolean);
  public
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;


{$REGION 'TInputElementHelper'}

//------------------------------------------------------------------------------
function TBaseInputElementHelper.GetEnabled: Boolean;
var
  s: string;
begin
  result := not Disabled;
  //s := Attr['disabled'];
  //result := SameText(s, 'false');
end;
//------------------------------------------------------------------------------
procedure TBaseInputElementHelper.SetEnabled(const value: Boolean);
begin
  Disabled := not Value;

  if Disabled then
  begin
    SetAttribute('disabled', 'true');
    //self.Document.Repaint;
  end
  else
  begin
    self.Attributes.ClearAttr('disabled');
    //self.Document.RecalcStyles;
    //self.Document.Repaint;
  end;
end;

{$ENDREGION}


{$REGION 'TBinding'}

//------------------------------------------------------------------------------
constructor TBinding.Create(const target: TElement;
  const source: IObservable);
begin
  //inherited Create(target);
  fTarget := target;
  InitSource(source);
  InitTarget;
end;
//------------------------------------------------------------------------------
function TBinding.InitGetValue(const observable: IObservable): TFunc<TValue>;
begin
  Result :=
    function: TValue
    begin
      Result := observable.Value;
    end;
end;
//------------------------------------------------------------------------------
procedure TBinding.InitSource(const observable: IObservable);
begin
  fSource := TDependentObservable.Create(
    InitGetValue(observable),
    procedure(const value: TValue)
    begin
      observable.Value := value;
    end);
end;

procedure TBinding.InitTarget;
begin
end;

{$ENDREGION}


{$REGION 'TBinding<T>'}

//------------------------------------------------------------------------------
constructor TBinding<T>.Create(const target: T; const source: IObservable);
begin
  inherited Create(target, source);
end;
//------------------------------------------------------------------------------
function TBinding<T>.GetTarget: T;
begin
  Result := T(inherited Target);
end;

{$ENDREGION}


{$REGION 'TInputElementBinding'}

//------------------------------------------------------------------------------
constructor TInputElementBinding.Create(const target: TElement;
  const source: IObservable; const propertyName: string);
begin
  // -- Just hardcode this since we have a limited number of properties in HTML anyway.
  if (target is TInputElement) and SameText(propertyName, 'enabled') then
    fProperty := ctx.GetType(TypeInfo(TBaseInputElementHelper)).GetProperty(propertyName)
  else
    fProperty := ctx.GetType((target as TInputElement).ClassInfo).GetProperty(propertyName);
  Assert(Assigned(fProperty));
  inherited Create(target as TInputElement, source);
end;
//------------------------------------------------------------------------------
function TInputElementBinding.InitGetValue(
  const observable: IObservable): TFunc<TValue>;
begin
  Result :=
    function: TValue
    var
      v: TValue;
    begin
      v := observable.Value;
      // some hardcoded custom value conversion for now
      if (fProperty.PropertyType.Handle = TypeInfo(Boolean)) and v.IsObject then
        fProperty.SetValue(Target, v.AsObject <> nil)
      else
        fProperty.SetValue(Target, v);
    end;
end;

{$ENDREGION}


{$REGION 'TButtonBinding'}

//------------------------------------------------------------------------------
procedure TButtonBinding.HandleClick(Sender: TObject);
begin
  if Target.HasAttribute('disabled') then exit;

  Source.Value;
end;
//------------------------------------------------------------------------------
procedure TButtonBinding.InitTarget;
begin
  Target.OnClick := HandleClick;
end;
//------------------------------------------------------------------------------
procedure TButtonBinding.InitSource(const observable: IObservable);
begin
  fSource := observable;
end;

{$ENDREGION}


{$REGION 'TEditBinding'}

//------------------------------------------------------------------------------
procedure TEditBinding.HandleChange(Sender: TObject);
begin
  Source.Value := Target.Attr['value'];
end;
//------------------------------------------------------------------------------
procedure TEditBinding.InitTarget;
begin
  // -- OnStateChanged is a new event added to DHTML TElement.
  Target.OnStateChanged := HandleChange;
end;
//------------------------------------------------------------------------------
function TEditBinding.InitGetValue(const observable: IObservable): TFunc<TValue>;
begin
  Result :=
    function: TValue
    begin
      Target.SetAttribute('value', observable.Value.ToString);
    end;
end;

{$ENDREGION}


{$REGION 'TLabelBinding'}

{ TLabelBinding }

//------------------------------------------------------------------------------
procedure TLabelBinding.HandleChange(Sender: TObject);
begin
  Source.Value := Target.InnerHTML;
end;
//------------------------------------------------------------------------------
function TLabelBinding.InitGetValue(
  const observable: IObservable): TFunc<TValue>;
begin
  result :=
    function: TValue
    begin
      Target.InnerHTML := observable.Value.ToString;
    end;
end;
//------------------------------------------------------------------------------
procedure TLabelBinding.InitTarget;
begin
  Target.OnStateChanged := HandleChange;
end;

{$ENDREGION}


{$REGION 'TSelectItemsBinding'}

{ TSelectItemsBinding }

//------------------------------------------------------------------------------
constructor TSelectItemsBinding.Create(const target: TElement;
  const source: IObservable; const optText: string);
begin
  FOptionsText := optText;
  inherited Create(target as TSelectElement, source);
end;
//------------------------------------------------------------------------------
function TSelectItemsBinding.InitGetValue(
  const observable: IObservable): TFunc<TValue>;
begin
  result :=
    function: TValue
    var
      i: integer;
      ix: integer;
      selectedItem: string;
      arrValues: TArray<string>;
      sValues: TList<string>;
      oValues: TList<TObject>;
      t: TSelectElement;
      s: string;
      p: pointer;
      v: TValue;
      pType: PTypeInfo;
      typName: string;
      objProp: TRttiProperty;
      obj: TObject;
    begin
      t := target as TSelectElement;
      ix := t.ItemIndex;
      selectedItem := t.GetItem(ix);

      try
        t.InnerHTML := '';
        if observable.Value.IsArray then
        begin
          { TODO : Other array types. }
          if observable.Value.TryAsType<TArray<string>>(arrValues) then
          begin
            for i := Low(arrValues) to High(arrValues) do
              t.AddString(arrValues[i]);
          end
          else
          begin
            if (observable.Value.GetArrayLength > 0) and (observable.Value.GetArrayElement(0).IsObject) then
            begin
              for i := 0 to observable.Value.GetArrayLength - 1 do
              begin
                try
                  obj := observable.Value.GetArrayElement(i).AsObject;
                  if Assigned(obj) then
                    objProp := ctx.GetType(obj.ClassInfo).GetProperty(FOptionsText);
                  if Assigned(objProp) then
                    t.AddObject(objProp.GetValue(obj).ToString, obj);
                except
                  on E: Exception do
                  begin
                    MessageDlg('Unassigned object in observable array: ' + E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
                    exit;
                  end;
                end;
              end;
            end;
          end;
        end
        else          // -- Try TList<>....
        begin
          v := observable.Value;
          if v.TypeInfo.Kind = tkClass then
          begin
            typName := v.TypeInfo.Name;
            if SameText(typName, 'TList<System.String>') then
            begin
              sValues := TList<string>(observable.Value.AsObject);
              for s in sValues do
                t.AddString(s);
            end
            else if ContainsText(typName, 'TObjectList') then
            begin
              oValues := TList<TObject>(observable.Value.AsObject);

              for obj in oValues do
              begin
                objProp := ctx.GetType(obj.ClassInfo).GetProperty(FOptionsText);
                if Assigned(objProp) then
                  t.AddObject(objProp.GetValue(obj).ToString, obj);
              end;
            end;
          end;
        end;
      finally
        t.SetSelectedItem(selectedItem);
      end;
    end;
end;

{$ENDREGION}


{$REGION 'TSelectBinding'}

//------------------------------------------------------------------------------
procedure TSelectBinding.HandleChange(Sender: TObject);
var
  ix: integer;
  t: TSelectElement;
  s: string;
  sValues: TArray<string>;
  objValues: TArray<TObject>;
  obj: TObject;
  arrSelected: TStringDynArray;
  v: TValue;
begin
  t := Target as TSelectElement;
  s := t.Value;

  // -- It's possible for the user to specify multi-select in the control
  // -- but not specify a selectedOptions binding. In that case just use
  // -- the last item selected.
  // -- If multiselect = true then we'll have s = 'string1,string2',...etc.
  if t.SelectCount > 1 then
  begin
    arrSelected := SplitString(s, ',');
    s := arrSelected[t.SelectCount - 1];
  end;

  obj := t.ObjectFromValue(s);
  if assigned(obj) then
    Source.Value := obj
  else
    Source.Value := s;
end;
//------------------------------------------------------------------------------
procedure TSelectBinding.InitTarget;
begin
  Target.OnStateChanged := HandleChange;
end;
//------------------------------------------------------------------------------
//-- To be used with a TSelectElement where multiple = false.
function TSelectBinding.InitGetValue(const observable: IObservable): TFunc<TValue>;
begin
  result :=
    function: TValue
    var
      value: TValue;
      t: TSelectElement;
    begin
      value := observable.Value;
      t := target as TSelectElement;
      if value.IsObject then
        t.Value := t.ValueFromObject(value.AsObject)
      else
        t.Value := value.ToString;
    end;
end;

{$ENDREGION}


{$REGION 'TMultiSelectBinding'}

{ TMultiSelectBinding }

//------------------------------------------------------------------------------
constructor TMultiSelectBinding.Create(const target: TElement;
  const source: IObservable; const optText: string);
begin
  FOptionsText := optText;
  inherited Create(target as TSelectElement, source);
end;
//------------------------------------------------------------------------------
procedure TMultiSelectBinding.HandleChange(Sender: TObject);
var
  i: integer;
  ix: integer;
  isx:integer;
  t: TSelectElement;
  sValues: TArray<string>;
  oValues: TArray<TObject>;
  v: TValue;
  arrSelected: TStringDynArray;
  obj: TObject;
  s: string;
  ti: PTypeInfo;
begin
  // -- We update the observable array in the viewmodel that reflects the
  // -- selected items. Any control bound to this array will then be updated.
  // -- Note that TList<> is not relevant here since it's not observable.

  t := Target as TSelectElement;
  s := t.Value;

  if t.SelectCount > 0 then
  begin
    arrSelected := SplitString(s, ',');
    obj := t.ObjectFromValue(arrSelected[0]);
    if assigned(obj) then      // -- Build an array of objects.
    begin
      SetLength(oValues, t.SelectCount);
      ix := 0;
      for s in arrSelected do
      begin
        obj := t.ObjectFromValue(s);
        oValues[ix] := obj;
        ix := ix + 1;
      end;

      { TODO : How to get correct typeinfo from Source.Value? TypeInfo(TArray<TObject>) doesn't work - gives an empty v. }
      //TValue.Make(@oValues, TypeInfo(TArray<TObject>), v);   <--- Doesn't work - returns an empty array in TValue.
      //ti :=
      TValue.Make(@oValues, ti, v);
      Source.Value := v;
    end
    else                       // -- Build an array of strings.
    begin
      { TODO : TMultiSelectBinding.HandleChange - Implement more source types. }
      SetLength(sValues, t.SelectCount);
      ix := 0;
      for i := 0 to t.SelectCount - 1 do
      begin
        isx := t.SelectedItemIndex[i];
        sValues[ix] := t.GetItem(isx);
        ix := ix + 1;
      end;

      {for s in arrSelected do
      begin
        sValues[ix] := s;
        ix := ix + 1;
      end;}

      TValue.Make(@sValues, TypeInfo(TArray<string>), v);
      Source.Value := v;
    end;
  end
  else
    Source.Value := nil;
end;
//------------------------------------------------------------------------------
function TMultiSelectBinding.InitGetValue(
  const observable: IObservable): TFunc<TValue>;
begin
  result :=
    function: TValue
    var
      value: TValue;
      t: TSelectElement;
    begin
      value := observable.Value;
      t := target as TSelectElement;
      if value.IsObject then
        t.Value := t.ValueFromObject(value.AsObject)
      else
        t.Value := value.ToString;
    end;
end;
//------------------------------------------------------------------------------
procedure TMultiSelectBinding.InitTarget;
begin
  Target.OnStateChanged := HandleChange;
end;

{$ENDREGION}


{$REGION 'TTextAreaBinding'}

{ TTextAreaBinding }

{ TODO : TTextAreaBinding - use attribute rather than the control. TTextAreaElement Bug? }
//------------------------------------------------------------------------------
procedure TTextAreaBinding.HandleChange(Sender: TObject);
begin
  Source.Value := (Target as TTextAreaElement).Control.Lines.Text;
  //Source.Value := Target.Attr['value'];
end;
//------------------------------------------------------------------------------
function TTextAreaBinding.InitGetValue(
  const observable: IObservable): TFunc<TValue>;
begin
  result :=
    function: TValue
    begin
      (Target as TTextAreaElement).Control.Lines.Text := observable.Value.ToString;
      //Target.SetAttribute('value', observable.Value.ToString);
    end;
end;
//------------------------------------------------------------------------------
procedure TTextAreaBinding.InitTarget;
begin
  Target.OnStateChanged := HandleChange;
end;

{$ENDREGION}




end.
