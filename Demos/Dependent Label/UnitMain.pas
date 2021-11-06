unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  htmlcomp,

  Knockoff.Observable,
  KnockoutOP.Binding,
  KnockoutOP.HTML;

type
  // -- Adapted from KnockOff MVVM demo.
  TDependentLabelViewModel = class(TComponent)
  private
    FLastName: Observable<string>;
    FFullName: Observable<string>;
    FFirstName: Observable<string>;
    function GetLastName: string;
    procedure SetLastName(const Value: string);
  public
    constructor Create(const firstName, lastName: string);
    property LastName: string read GetLastName write SetLastName;
    property FirstName: Observable<string> read FFirstName;
    property FullName: Observable<string> read FFullName;
  end;


  TMainForm = class(TForm)
    Panel10: TPanel;
    btnBind: TButton;
    DependentLabelView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDependentLabelView: THTMLView;
    FDependentLabelViewModel: TDependentLabelViewModel;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FDependentLabelView, FDependentLabelViewModel);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FDependentLabelView := THTMLView.Create(DependentLabelView);
  FDependentLabelViewModel := TDependentLabelViewModel.Create('Joe', 'Bloggs');
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FDependentLabelView.Free;
  FDependentLabelViewModel.Free;
end;


{ TDependentLabelViewModel }

constructor TDependentLabelViewModel.Create(const firstName, lastName: string);
begin
  FLastName := TObservable<string>.Create(lastName);
  FFirstName := TObservable<string>.Create(firstName);
  FFullName := TDependentObservable<string>.Create(
    function: string
    begin
      Result := FFirstName + ' ' + FLastName;
    end);
end;

function TDependentLabelViewModel.GetLastName: string;
begin
  Result := FLastName;
end;

procedure TDependentLabelViewModel.SetLastName(const Value: string);
begin
  FLastName(value);
end;



end.
