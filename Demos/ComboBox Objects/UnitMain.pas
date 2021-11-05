unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  htmlcomp,

  Knockoff.Observable,
  KnockoutOP.Binding,
  KnockoutOP.HTML, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTicket = class
  private
    FName: string;
    FPrice: Currency;
  public
    constructor Create(const name: string; price: Currency);
    property Name: string read FName write FName;
    property Price: Currency read FPrice write FPrice;
  end;

  TTicketViewModel = class(TComponent)
  private
    FChosenTicket: Observable<TTicket>;
    //FTickets: TList<TTicket>;
    FTickets: ObservableArray<TTicket>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddTicket(const name: string; price: Currency);
    property ChosenTicket: Observable<TTicket> read FChosenTicket;
    //property Tickets: TList<TTicket> read FTickets;
    property Tickets: ObservableArray<TTicket> read FTickets;
  end;

  TMainForm = class(TForm)
    Panel5: TPanel;
    btnBind: TButton;
    btnAddTicket: TButton;
    TicketsView: THtPanel;
    Memo1: TMemo;
    procedure btnBindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddTicketClick(Sender: TObject);
  private
    { Private declarations }
    FTicketView: THTMLView;
    FTicketViewModel: TTicketViewModel;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}



{ TTicket }

constructor TTicket.Create(const name: string; price: Currency);
begin
  FName := name;
  FPrice := price;
end;



{ TTicketViewModel }

procedure TTicketViewModel.AddTicket(const name: string; price: Currency);
var
  ticket: TTicket;
begin
  ticket := TTicket.Create(name, price);
  FTickets.Add(ticket);
end;

constructor TTicketViewModel.Create;
var
  ticket: TTicket;
begin
  FTickets := Observable.CreateArray<TTicket>([]);
  //FTickets := TList<TTicket>.Create;

  { TODO : Exception in TObservable<T>.GetValue if FTickets is empty. }
  ticket := TTicket.Create('Economy', 199.95);
  FTickets.Add(ticket);
  ticket := TTicket.Create('Business', 449.22);
  FTickets.Add(ticket);
  ticket := TTicket.Create('First Class', 1199.99);
  FTickets.Add(ticket);

  FChosenTicket := TObservable<TTicket>.Create(ticket);
end;

destructor TTicketViewModel.Destroy;
var
  i: integer;
begin
  //FTickets.Free;      // -- For TList<>.
  for i := 0 to FTickets.Length - 1 do
    FTickets[i].Free;
end;

procedure TMainForm.btnAddTicketClick(Sender: TObject);
begin
  FTicketViewModel.AddTicket('Super Economy', 99.00);
end;

procedure TMainForm.btnBindClick(Sender: TObject);
begin
  ApplyBindings(FTicketView, FTicketViewModel);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FTicketView := THTMLView.Create(TicketsView);
  FTicketViewModel := TTicketViewModel.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FTicketView.Free;
end;

end.
