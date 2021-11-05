unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections,

  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  htmlcomp,

  Knockoff.Observable,
  KnockoutOP.Binding,
  KnockoutOP.HTML;

type
  TCarsViewModel = class(TComponent)
  private
    FSelectedCar: Observable<string>;
    FAvailableCarTypes: TList<string>;
    function GetAvailableCarTypes: TList<string>;
    function GetSelectedCar: Observable<string>;
  public
    constructor Create;
    destructor Destroy; override;
    property AvailableCarTypes: TList<string> read GetAvailableCarTypes;
    property SelectedCar: Observable<string> read GetSelectedCar;
  end;


  TMainForm = class(TForm)
    Panel4: TPanel;
    btnBind: TButton;
    CarsListView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCarsListView: THTMLView;
    FCarsViewModel: TCarsViewModel;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FCarsListView, FCarsViewModel);
end;


{ TCarsViewModel }

constructor TCarsViewModel.Create;
begin
  FAvailableCarTypes := TList<string>.Create;

  FAvailableCarTypes.Add('Volvo');
  FAvailableCarTypes.Add('Mercedes');
  FAvailableCarTypes.Add('Audi');
  FAvailableCarTypes.Add('Saab');

  FSelectedCar := TObservable<string>.Create('Audi');
end;

destructor TCarsViewModel.Destroy;
begin
  FAvailableCarTypes.Free;
  inherited;
end;

function TCarsViewModel.GetAvailableCarTypes: TList<string>;
begin
  result := FAvailableCarTypes;
end;

function TCarsViewModel.GetSelectedCar: Observable<string>;
begin
  result := FSelectedCar;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCarsListView := THTMLView.Create(CarsListView);
  FCarsViewModel := TCarsViewModel.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FCarsListView.Free;
end;

end.
