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
  TCheckboxViewModel = class(TComponent)
  private
    FCheckStatus: Observable<string>;
    FIsChecked: Observable<boolean>;
  public
    constructor Create;
    property CheckStatus: Observable<string> read FCheckStatus;
    property IsChecked: Observable<boolean> read FIsChecked;
  end;


  TMainForm = class(TForm)
    Panel10: TPanel;
    btnBind: TButton;
    CheckBoxView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCheckboxViewModel: TCheckboxViewModel;
    FCheckboxView: THTMLView;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FCheckboxView, FCheckboxViewModel);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCheckboxViewModel := TCheckboxViewModel.Create;
  FCheckboxView := THTMLView.Create(CheckboxView);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FCheckboxViewModel.Free;
  FCheckboxView.Free;
end;


{ TCheckboxViewModel }

constructor TCheckboxViewModel.Create;
begin
  FIsChecked := TObservable<boolean>.Create(true);
  FCheckStatus := TDependentObservable<string>.Create(
    function: string
    begin
      if FIsChecked then
        result := 'It''s checked'
      else
        result := 'It isn''t checked';
    end);
end;




end.
