unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, htmlcomp,

  Knockoff.Observable,
  KnockoutOP.Binding,
  KnockoutOP.HTML;

type
  TOACarsViewModel = class(TComponent)
  private
    FSelectedCar: Observable<string>;
    FAvailableCarTypes: ObservableArray<string>;
    function GetAvailableCarTypes: ObservableArray<string>;
    function GetSelectedCar: Observable<string>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCar(const carName: string);
    property AvailableCarTypes: ObservableArray<string> read GetAvailableCarTypes;
    property SelectedCar: Observable<string> read GetSelectedCar;
  end;

  TMainForm = class(TForm)
    Panel2: TPanel;
    btnAddItem: TButton;
    btnBind: TButton;
    CarsView: THtPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBindClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
  private
    { Private declarations }
    FCarsView: THTMLView;
    FOACarsViewModel: TOACarsViewModel;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


{ TOACarsViewModel }

procedure TOACarsViewModel.AddCar(const carName: string);
begin
  FAvailableCarTypes.Add(carName);
end;
//------------------------------------------------------------------------------
constructor TOACarsViewModel.Create;
begin
  FAvailableCarTypes := Observable.CreateArray<string>([]);

  FAvailableCarTypes.Add('Volvo');
  FAvailableCarTypes.Add('Mercedes');
  FAvailableCarTypes.Add('Audi');
  FAvailableCarTypes.Add('Saab');

  FSelectedCar := TObservable<string>.Create('Audi');
end;
//------------------------------------------------------------------------------
destructor TOACarsViewModel.Destroy;
begin

  inherited;
end;
//------------------------------------------------------------------------------
function TOACarsViewModel.GetAvailableCarTypes: ObservableArray<string>;
begin
  result := FAvailableCarTypes;
end;
//------------------------------------------------------------------------------
function TOACarsViewModel.GetSelectedCar: Observable<string>;
begin
  result := FSelectedCar;
end;



//------------------------------------------------------------------------------
procedure TMainForm.btnAddItemClick(Sender: TObject);
begin
  FOACarsViewModel.AddCar('Tesla');
end;
//------------------------------------------------------------------------------
procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FCarsView, FOACarsViewModel);
end;
//------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCarsView := THTMLView.Create(CarsView);
  FOACarsViewModel := TOACarsViewModel.Create;
end;
//------------------------------------------------------------------------------
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FCarsView.Free;
end;

end.
