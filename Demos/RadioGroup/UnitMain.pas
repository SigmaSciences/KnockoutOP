unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,

  htmlcomp,

  Knockoff.Observable,
  KnockoutOP.Binding,
  KnockoutOP.HTML;

type
  TRadioGroupViewModel = class(TComponent)
  private
    FContactType: Observable<string>;
    FContactNotification: Observable<string>;
  public
    constructor Create; reintroduce;
    property ContactType: Observable<string> read FContactType;
    property ContactNotification: Observable<string> read FContactNotification;
  end;


  TMainForm = class(TForm)
    RadioGroupView: THtPanel;
    Panel10: TPanel;
    btnBind: TButton;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FRadioGroupViewModel: TRadioGroupViewModel;
    FRadioGroupView: THTMLView;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TRadioGroupViewModel }

constructor TRadioGroupViewModel.Create;
begin
  FContactType := TObservable<string>.Create('email');
  FContactNotification := TDependentObservable<string>.Create(
    function: string
    begin
      result := 'We will contact you by ' + FContactType;
    end);
end;

procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FRadioGroupView, FRadioGroupViewModel);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FRadioGroupViewModel := TRadioGroupViewModel.Create;
  FRadioGroupView := THTMLView.Create(RadioGroupView);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FRadioGroupView.Free;
  FRadioGroupViewModel.Free;
end;

end.
