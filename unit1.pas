unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList, ExtendedNotebook, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    ColorDialog1: TColorDialog;
    ExtendedNotebook1: TExtendedNotebook;
    Image1: TImage;
    Image10: TImage;
    Image12: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnlClient: TPanel;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    procedure actExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
  private
    ConfigDir : String;
    Ini : TIniFile;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  ucolorfuncs;

{ TForm1 }

procedure TForm1.Label1MouseEnter(Sender: TObject);
var
  Farbe : TColor;
begin
  Farbe := TPanel(TWinControl(Sender).Parent).Parent.Color;
  if Helligkeit(Farbe) <= 128 then
    TPanel(TWinControl(Sender).Parent).Color:= Heller(Farbe,30)
  else
    TPanel(TWinControl(Sender).Parent).Color:= Dunkler(Farbe,30)
end;

procedure TForm1.Label1MouseLeave(Sender: TObject);
begin
  TPanel(TWinControl(Sender).Parent).ParentColor := True;
//  TPanel(TWinControl(Sender).Parent).Color :=
//         TPanel(TWinControl(Sender).Parent).Parent.Color
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  if pnlLeft.Width > 48 then
  begin
    pnlLeft.Width := 48;
    pnlLeft.ShowHint:=True;
  end
  else
  begin
    pnlLeft.Width := 205;
    pnlLeft.ShowHint:=False;
  end;
end;

procedure TForm1.Label10Click(Sender: TObject);
begin
  ColorDialog1.Color := pnlLeft.Color;
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    pnlLeft.Color := ColorDialog1.Color;
    pnlLeft.Invalidate;
  end;
end;

procedure TForm1.Label11Click(Sender: TObject);
begin
  ColorDialog1.Color := pnlTop.Color;
  if ColorDialog1.Execute then
  begin
    Shape2.Brush.Color := ColorDialog1.Color;
    pnlTop.Color := ColorDialog1.Color;
    pnlTop.Invalidate;
  end;

end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Ini.WriteString('Farben','PanelLeft',ColorToString(pnlLeft.Color));
  Ini.WriteString('Farben','PanelTop' ,ColorToString(pnlTop.Color));
  Ini.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  fname : String;
begin
  ConfigDir := GetAppConfigDir(False);
  fname := ConfigDir+'Application.ini';
  Ini := TInifile.Create(fname);
  Ini.WriteString('Application','Username','Fritz Kirch');
  pnlLeft.Color := StringToColor(Ini.ReadString('Farben','PanelLeft','clBlack'));
  pnlTop.Color  := StringToColor(Ini.ReadString('Farben','PanelTop','clWhite'));
  Shape1.Brush.Color := pnlLeft.Color;
  Shape2.Brush.Color := pnlTop.Color;
  ShowMessage(fname);
end;


end.

