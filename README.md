## KnockoutOP: HTML-based MVVM for Delphi

KnockoutOP combines two superb libraries from the [Delphi](https://www.embarcadero.com/products/delphi) ecosystem, [Knockoff](https://bitbucket.org/sglienke/knockoff) MVVM and  [DelphiHTMLComponents](https://delphihtmlcomponents.com/), to provide an HTML/CSS-based approach to MVVM in Delphi. It can currently best be described as a proof-of-concept and is some way from being production quality.

#### Delphi HTML Components (DHTML)
##### :warning: Important: The current codebase relies on modified versions of two of the DelphiHTMLComponents units, complicated by the fact that the originals used are not part of an official DHTML release. This will be addressed in the near future but for now the code is for inspection-purposes only.

#### Knockoff
The only file required from Knockoff is Knockoff.Binding.pas.

### Basic Bindings
Basic bindings are currently available for the following:

| HTML | VCL Equivalent      | 
| -------------| -----------      |
|`<label>`      | TLabel     |
|`<button>` or `<input type="button">` with the latter for forms     | TButton        |
|`<input type="text">`       | TEdit       |
|`<input type="checkbox">`      | TCheckBox        |
|`<input type="radio">`    | TRadioButton      |
|`<select>` with size unspecified | TComboBox     |
|`<select>` with size specified  | TListBox     |
|`<select>` with size specified and "multiple" | TListBox with multi-select     |
|`<textarea>`      | TMemo     |
|`<div>` | TPanel     |
|Content-editable `<div>` (with Options.eoEnterSoftBreak)      | TRichEdit (via HTML)    |


### Todo

##### Features
- Grids (Note that there is a powerful table component in DHTML and this is being evaluated)
- Treeview
- Integration with Spring4D?

##### Code
- Improve some of the RTTI code
- Tests: Need to decide how best to test the UI.
- More demos

### Prerequisites
This library has been developed and tested with **Delphi 10.4.2 Sydney** - I have not tried or tested any other versions so far.

#### Libraries/Units dependencies
See above: Knockoff and DelphiHTMLComponents.


