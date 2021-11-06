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
  TMultiSelectViewModel = class(TComponent)
  private
    FSelectedCars: ObservableArray<string>;
    FAvailableCarTypes: TList<string>;
    function GetAvailableCarTypes: TList<string>;
  public
    constructor Create;
    destructor Destroy; override;
    property AvailableCarTypes: TList<string> read GetAvailableCarTypes;
    property SelectedCars: ObservableArray<string> read FSelectedCars;
  end;


  TMainForm = class(TForm)
    Panel5: TPanel;
    btnBind: TButton;
    MultiSelectView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMultiSelectViewModel: TMultiSelectViewModel;
    FMultiSelectView: THTMLView;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FMultiSelectView, FMultiSelectViewModel);
end;


{ TMultiSelectViewModel }

constructor TMultiSelectViewModel.Create;
begin
  FAvailableCarTypes := TList<string>.Create;
  FAvailableCarTypes.Add('Volvo');
  FAvailableCarTypes.Add('Mercedes');
  FAvailableCarTypes.Add('Audi');
  FAvailableCarTypes.Add('Saab');
  FAvailableCarTypes.Add('Honda');
  FAvailableCarTypes.Add('Tesla');

  FSelectedCars := Observable.CreateArray<string>(['Audi']);
end;

destructor TMultiSelectViewModel.Destroy;
begin
  FAvailableCarTypes.Free;
  inherited;
end;

function TMultiSelectViewModel.GetAvailableCarTypes: TList<string>;
begin
  result := FAvailableCarTypes;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FMultiSelectView := THTMLView.Create(MultiSelectView);
  FMultiSelectViewModel := TMultiSelectViewModel.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FMultiSelectView.Free;
end;

end.
