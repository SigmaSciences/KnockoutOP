## KnockoutOP: HTML-based MVVM for Delphi

KnockoutOP combines two superb libraries from the [Delphi](https://www.embarcadero.com/products/delphi) ecosystem, [Knockoff](https://bitbucket.org/sglienke/knockoff) MVVM and  [DelphiHTMLComponents](https://delphihtmlcomponents.com/), to provide an HTML/CSS-based approach to MVVM in Delphi. It can currently best be described as a proof-of-concept and is some way from being production quality.

#### Delphi HTML Components (DHTML)
##### :warning: Important: The current codebase relies on modified versions of two of the DelphiHTMLComponents units, complicated by the fact that the originals used are not part of an official DHTML release. This will be addressed in the near future but for now the code is for inspection-purposes only.

#### Knockoff
The only file required from Knockoff is Knockoff.Observable.pas.

### Basic Element Bindings
Basic bindings are currently available for the following elements:

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


### HTML User Interfaces

Applications such as Visual Studio Code demonstrate what's achievable using HTML/CSS/Javascript for the UI, but typically depend on the heavyweight Electron framework. Being able to integrate a fully HTML/CSS compliant UI in Delphi (via MVVM) provides a number of advantages:

- Unified styling across VCL and FMX apps
- Styling and UIs can be built by web developers
- End users can apply (and even develop) custom styles
- UIs can be built using modern vector tools such as [Figma](https://www.figma.com/)
- The limited number of HTML elements in turn limits the number of different bindings we need to develop
- CSS isn't restricted to appearance - we can also use it to define some aspects of interactivity

An enormous amount can be achieved using just HTML and CSS without the need for Javascript. In fact there is a growing trend of "just enough Javascript and no more", with CSS being used to do more UI interactivity. Of course, for more sophisticated components we can't avoid scripting and for DHTML we have two options:

- Use the built-in Pascal scripter
- Use Delphi code to manipulate the DOM directly

At some point in the future we might get Javascript integrated into DHTML and then we would see an explosion of options for Delphi developers.

### Knockout.js Bindings

[Knockout.js](https://knockoutjs.com/index.html) was very popular for web application development but in recent years has been regarded as legacy technology. There's nothing fundamentally wrong with it, but rather there have appeared alternative frameworks that provide additional functionality (e.g. routing) as well as data binding. These frameworks tend to be "all-or-nothing" and there's a certain attraction in building a more flexible framework that doesn't lead to lock-in. In Delphi app development of course the fundamental architecture is completely different and a Knockout-style MVVM could be very useful. When we also consider using Knockout.js in one of the Delphi web frameworks, e.g. [Quartex](https://www.patreon.com/quartexnow) or [TMS Web Core](https://www.tmssoftware.com/site/tmswebcore.asp), we can see the possibility of a common UI codebase across desktop, mobile and web.

The syntax used to declare a binding in KnockoutOP is the same as that for Knockout.js, for example the value binding for a text input:

`<input type="text" id="surname" data-bind="value: UserSurname">`

This binds the contents of the text input element to the value of the UserSurname member in the viewmodel. The following table shows the current status of the binding support in KnockoutOP for a subset of Knockout.js bindings:

| Binding | Implemented      | 
| -------------| -----------      |
|  visible       | ❌️               |
|  text       | ✔️               |
|  html       | ❌️               |
|  class/css       | ❌️               |
|  style       | ❌️               |
|  attr       | ❌️               |
|  click       | ✔️               |
|  event       | ❌️               |
|  enabled/disabled       | ✔️               |
|  value       | ✔️               |
|  checked       | ✔️               |
|  options       | ✔️               |
|  selectedOptions       | ✔️               |


### Todo

#### Bindings
- TListView
- Treeview

#### Code
- Improve some of the RTTI code
- Tests: Need to decide how best to test the UI primitives
- More demos
- Integration with Spring4D?
- Investigate possibility of common UI codebase for desktop and web

### Prerequisites
This library has been developed and tested with **Delphi 10.4.2 Sydney** - I have not tried or tested any other versions so far.

#### Libraries/Units dependencies
See above: Knockoff and DelphiHTMLComponents.


