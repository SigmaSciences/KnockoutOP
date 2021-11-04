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
  TCellPhoneViewModel = class(TComponent)
  private
    FCellPhoneNumber: Observable<string>;
    FHasCellPhone: Observable<boolean>;
    function GetCellPhoneNumber: Observable<string>;
    function GetHasCellPhone: Observable<boolean>;
  public
    constructor Create;
    procedure HandleButtonClick;
    procedure HandleButton3Click;
    procedure HandleFormButtonClick;
    property CellPhoneNumber: Observable<string> read GetCellPhoneNumber;
    property HasCellPhone: Observable<boolean> read GetHasCellPhone;
  end;

  TMainForm = class(TForm)
    Panel1: TPanel;
    btnBind: TButton;
    btnSetNumber: TButton;
    btnHasCellPhone: TButton;
    btnNoCellPhone: TButton;
    CellPhoneView: THtPanel;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSetNumberClick(Sender: TObject);
    procedure btnHasCellPhoneClick(Sender: TObject);
    procedure btnNoCellPhoneClick(Sender: TObject);
  private
    { Private declarations }
    FCellPhoneView: THTMLView;
    FCellPhoneViewModel: TCellPhoneViewModel;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TCellPhoneViewModel }

//------------------------------------------------------------------------------
constructor TCellPhoneViewModel.Create;
begin
  FCellPhoneNumber := TObservable<string>.Create('+44 7896 123456');
  FHasCellPhone := TObservable<boolean>.Create(false);
end;
//------------------------------------------------------------------------------
function TCellPhoneViewModel.GetCellPhoneNumber: Observable<string>;
begin
  result := FCellPhoneNumber;
end;
//------------------------------------------------------------------------------
function TCellPhoneViewModel.GetHasCellPhone: Observable<boolean>;
begin
  result := FHasCellPhone;
end;
//------------------------------------------------------------------------------
procedure TCellPhoneViewModel.HandleButton3Click;
begin
  showmessage('HandleButton3Click');
end;
//------------------------------------------------------------------------------
procedure TCellPhoneViewModel.HandleButtonClick;
begin
  showmessage('HandleButtonClick');
end;
//------------------------------------------------------------------------------
procedure TCellPhoneViewModel.HandleFormButtonClick;
begin
  showmessage('HandleFormButtonClick');
end;




//------------------------------------------------------------------------------
procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FCellPhoneView, FCellPhoneViewModel);
end;

procedure TMainForm.btnHasCellPhoneClick(Sender: TObject);
begin
  FCellPhoneViewModel.HasCellPhone(true);
end;

procedure TMainForm.btnNoCellPhoneClick(Sender: TObject);
begin
  FCellPhoneViewModel.HasCellPhone(false);
end;

procedure TMainForm.btnSetNumberClick(Sender: TObject);
begin
  FCellPhoneViewModel.CellPhoneNumber('+44 7777 999999');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCellPhoneView := THTMLView.Create(CellPhoneView);
  FCellPhoneViewModel := TCellPhoneViewModel.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FCellPhoneView.Free;
end;

end.
