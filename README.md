## KnockoutOP: HTML-based MVVM for Delphi

KnockoutOP combines two superb libraries from the [Delphi](https://www.embarcadero.com/products/delphi) ecosystem, [Knockoff](https://bitbucket.org/sglienke/knockoff) MVVM and  [DelphiHTMLComponents](https://delphihtmlcomponents.com/), to provide an HTML/CSS-based approach to MVVM in Delphi. It can currently best be described as a proof-of-concept and is some way from being production quality.

#### Delphi HTML Components (DHTML)
KnockoutOP uses the **THtPanel** from the DHTML component set. **Note that DHTML is a commercial component set**.

##### :warning: Important: The current codebase relies on modified versions of two of the DelphiHTMLComponents units, complicated by the fact that the originals used are not part of an official DHTML release. Patches are available in the DHTML folder.

#### Knockoff
The only unmodified file required from Knockoff is **Knockoff.Observable.pas**. Heavily modified versions of the other Knockoff files used have been renamed as KnockoutOP and are in the Source folder.

Details on the idea behind Knockoff observables can be found [**here**](https://delphisorcery.blogspot.com/2015/06/anonymous-method-overloading.html).

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

Applications such as Visual Studio Code demonstrate what's achievable using HTML/CSS/Javascript for a desktop UI, but typically depend on the heavyweight Electron framework. Being able to integrate a fully HTML/CSS compliant UI in Delphi (via MVVM) provides a number of advantages:

- Unified styling across VCL and FMX apps
- Styling and UIs can be built by web developers
- End users can apply (and even develop) custom styles
- UIs can be built using modern vector tools such as [Figma](https://www.figma.com/)
- The limited number of HTML elements in turn limits the number of different MVVM bindings we need to develop
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

### Architecture Options

The simplest approach to using KnockoutOP is to compose your UI from multiple instances of THtPanel, each containing HTML dedicated to a particular task. For example, we are currently working on a toolbar and a statusbar based on this approach. This has some similarities to Web Components based on a shadow DOM, where each THtPanel has it's own DOM and hence independent styling if required.

Future work will include investigation of full HTML-based UIs, but this is likely to be a larger project. For both this and the panel-based UIs we are currently investigating CSS-based components with no, or at least very little, Javascript. Small amounts of Javascript could conceivably be ported to DHTML PascalScript.


### Todo

#### Tests

Initial work has focused on proving that the concept is worth pursuing. There's still a bit of work to do in this respect but the aim is to start building tests as soon as that's achieved. Current thinking is to use file-based outputs tested against a known correct file, although I'm open to suggestions (and contributions!). Until the tests get sorted out it's best to contact me directly rather than use pull requests.

You can contact me on gmail.com using the username found in the commit history. 

#### Component Bindings
- ListView
- Treeview (based on TListView)
- Fieldset (TGroupBox)

#### Code
- Improve some of the RTTI code
- Integration with Spring4D?
- Investigate possibility of common UI codebase for desktop and web

#### Demos
- More demos
- Pure-CSS controls (e.g. a CSS tab control demo)

### Prerequisites
This library has been developed and tested with **Delphi 10.4.2 Sydney** - I have not tried or tested any other versions so far.

#### Libraries/Units dependencies
See above: Knockoff and DelphiHTMLComponents.


