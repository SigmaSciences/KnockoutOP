{-------------------------------------------------------------------------------

Original file: Copyright (c) 2015 Stefan Glienke - All rights reserved.

Original file at: https://bitbucket.org/sglienke/knockoff (knockoff.binding.pas)

Portions Copyright (c) 2021 Sigma Sciences Ltd.

Originator: Robert L S Devine

Knockoff code adapted for use with DelphiHTMLComponents.

-------------------------------------------------------------------------------}

{******************************************************************************}
{                                                                              }
{     Licensed under the Apache License, Version 2.0 (the "License");          }
{     you may not use this file except in compliance with the License.         }
{     You may obtain a copy of the License at                                  }
{                                                                              }
{         http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                              }
{     Unless required by applicable law or agreed to in writing, software      }
{     distributed under the License is distributed on an "AS IS" BASIS,        }
{     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{     See the License for the specific language governing permissions and      }
{     limitations under the License.                                           }
{                                                                              }
{******************************************************************************}

{ TODO : Prevent duplicate strings in combo and list boxes. }


unit KnockoutOP.Binding;

interface

uses
  System.Classes,

  KnockoutOP.HTML,
  KnockoutOP.Binding.HTML,
  KnockoutOP.Intf;


procedure ApplyBindings(const view: THTMLView; const viewModel: TObject);

function Bind(const target: TElement; const targetType: TElementType; const targetExpression: string;
  const source: TObject; const sourceExpression: string; const optionsText: string): IBinding;


implementation

uses
  Generics.Collections,
  Rtti,
  System.StrUtils,
  System.SysUtils,
  System.Types,

  Knockoff.Observable;

var
  ctx: TRttiContext;

//------------------------------------------------------------------------------
procedure ApplyBindings(const view: THTMLView; const viewModel: TObject);
var
  bindNodeId: string;
  arrBindings: TStringDynArray;
  binding: string;
  targetName: string;
  sourceName: string;
  psn: integer;
  bnd: IBinding;
  optionsText: string;
  e: TElement;
  et: TElementType;
  s: string;
begin
  if not assigned(viewModel) then
    raise Exception.Create('ViewModel not assigned');

  if TComponent(viewModel).Owner = nil then
    view.InsertComponent(TComponent(viewModel));

  view.EnumerateDataBindNodes;
  if view.HasDataBinding then
  begin
    // -- The format is the same as in KnockoutJS, e.g. for an input element:
    // -- <input data-bind="value: cellphoneNumber, enable: hasCellphone" />
    for bindNodeId in view.DataBindNodes.Keys do
    begin
      e := view.DataBindNodes[bindNodeId].Element;
      et := view.DataBindNodes[bindNodeId].ElementType;
      optionsText := '';

      if e is TSelectElement then     // -- Check for optionsText.
        if e.HasAttribute('data-bind') then
        begin
          arrBindings := SplitString(view.DataBindNodes[bindNodeId].Bindings, ',');
          for s in arrBindings do
          begin
            if ContainsText(s, 'optionsText') then
            begin
              psn := Pos(':', s);
              optionsText := Trim(Copy(s, psn + 1, length(s) - psn));
              break;
            end;
          end;
        end;

      arrBindings := SplitString(view.DataBindNodes[bindNodeId].Bindings, ',');
      for binding in arrBindings do
      begin
        bnd := nil;
        psn := Pos(':', binding);
        targetName := Trim(Copy(binding, 1, psn - 1));
        if SameText('optionsText', targetName) then continue;
        sourceName := Trim(Copy(binding, psn + 1, length(binding) - psn));

        bnd := Bind(view.DataBindNodes[bindNodeId].Element, et, targetName, viewModel, sourceName, optionsText);

        if assigned(bnd) then
          view.AddBinding(bnd);
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
function CreateObservable(instance: TObject;
  const expression: string): IObservable;

  function CreateRootProp(const prop: TRttiProperty; const instance: TObject): IObservable;
  begin
    Result := TDependentObservable.Create(
      function: TValue
      begin
        Result := prop.GetValue(instance);
      end,
      procedure(const value: TValue)
      begin
        prop.SetValue(instance, value);
      end);
  end;

  function CreateSubProp(const prop: TRttiProperty; const observable: IObservable): IObservable;
  begin
    Result := TDependentObservable.Create(
      function: TValue
      var
        instance: TObject;
      begin
        instance := observable.Value.AsObject;
        if Assigned(instance) then
          Result := prop.GetValue(instance)
        else
          Result := nil;
      end,
      procedure(const value: TValue)
      var
        instance: TObject;
      begin
        instance := observable.Value.AsObject;
        if Assigned(instance) then
          prop.SetValue(instance, value);
      end);
  end;

var
  expressions: TStringDynArray;
  i: Integer;
  typ: TRttiType;
  prop: TRttiProperty;
begin
  Result := nil;
  expressions := SplitString(expression, '.');
  typ := ctx.GetType(instance.ClassInfo);
  for i := 0 to High(expressions) do
  begin
    prop := typ.GetProperty(expressions[i]);
    if Assigned(prop) then
    begin
      if StartsText('Observable<', prop.PropertyType.Name)
        or StartsText('ObservableArray<', prop.PropertyType.Name) then
      begin
        Result := prop.GetValue(instance).AsInterface as IObservable;
        typ := prop.PropertyType.BaseType.GetMethod('Invoke').ReturnType;
      end
      else
      begin
        if i = 0 then
          Result := CreateRootProp(prop, instance)
        else
          Result := CreateSubProp(prop, Result);
        typ := prop.PropertyType;
      end;

      if i < High(expressions) then
        instance := Result.Value.AsObject;
    end;
  end;
end;
//------------------------------------------------------------------------------
function Bind(const target: TElement; const targetType: TElementType; const targetExpression: string;
  const source: TObject; const sourceExpression: string; const optionsText: string): IBinding;
var
  observable: IObservable;
  typ: TRttiType;
  method: TRttiMethod;
  bindingClass: TBindingClass;
begin
  result := nil;
  observable := CreateObservable(source, sourceExpression);

  if not Assigned(observable) then
  begin
    typ := ctx.GetType(source.ClassInfo);
    method := typ.GetMethod(sourceExpression);
    if Assigned(method) then
      observable := TObservable.Create(
        function: TValue
        begin
          Result := method.Invoke(source, []);
        end);
  end;

  Assert(Assigned(observable), 'Expression not found: ' + sourceExpression);

  bindingClass := GetBindingClass(targetType, targetExpression);
  if Assigned(bindingClass) then
  begin
    if bindingClass = TSelectItemsBinding then
      result := TSelectItemsBinding.Create(target, observable, optionsText)
    else
      result := bindingClass.Create(target, observable);
  end
  else
    result := TInputElementBinding.Create(target, observable, targetExpression);
end;


end.
