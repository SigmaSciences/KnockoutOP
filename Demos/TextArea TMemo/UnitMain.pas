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
  TTextEditViewModel = class(TComponent)
  private
    FUserText: Observable<string>;
    FUpperCaseText: Observable<string>;
    function GetUserText: Observable<string>;
  public
    constructor Create;
    property UpperCaseText: Observable<string> read FUpperCaseText;
    property UserText: Observable<string> read GetUserText;
  end;

  TMainForm = class(TForm)
    Panel10: TPanel;
    btnBind: TButton;
    TextEditView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTextEditViewModel: TTextEditViewModel;
    FTextEditView: THTMLView;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}




procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FTextEditView, FTextEditViewModel);
end;


{ TTextEditViewModel }

constructor TTextEditViewModel.Create;
begin
  FUserText := TObservable<string>.Create('abcdefg');
  FUpperCaseText := TDependentObservable<string>.Create(
    function: string
    begin
      Result := UpperCase(FUserText);
    end);
end;

function TTextEditViewModel.GetUserText: Observable<string>;
begin
  result := FUserText;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FTextEditViewModel := TTextEditViewModel.Create;
  FTextEditView := THTMLView.Create(TextEditView);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FTextEditView.Free;
  FTextEditViewModel.Free;
end;

end.
