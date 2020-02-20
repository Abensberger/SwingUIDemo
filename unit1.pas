unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList, BGRASpeedButton, BGRAResizeSpeedButton, BCButton,
  ColorSpeedButton, ExtendedNotebook, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    ColorDialog1: TColorDialog;
    ColorSpeedButton1: TColorSpeedButton;
    ColorSpeedButton10: TColorSpeedButton;
    ColorSpeedButton2: TColorSpeedButton;
    ColorSpeedButton3: TColorSpeedButton;
    ColorSpeedButton4: TColorSpeedButton;
    ColorSpeedButton5: TColorSpeedButton;
    ColorSpeedButton6: TColorSpeedButton;
    ColorSpeedButton7: TColorSpeedButton;
    ColorSpeedButton8: TColorSpeedButton;
    ColorSpeedButton9: TColorSpeedButton;
    ExtendedNotebook1: TExtendedNotebook;
    Image6: TImage;
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
    procedure actExitExecute(Sender: TObject);
    procedure ColorSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
  private
    ConfigDir : String;
    Ini : TIniFile;
    procedure Colorize(aSpeedButton:TColorSpeedButton);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  ucolorfuncs;

{ TForm1 }


procedure TForm1.Colorize(aSpeedButton: TColorSpeedButton);
var aColor : TColor;
begin
  aColor := TPanel(aSpeedButton.Parent).Color;
  if Helligkeit(aColor) > 128 then
  begin
    aSpeedButton.StateNormal.Color := aColor;
    aSpeedButton.StateHover.Color  := ucolorfuncs.Dunkler(aColor,20);
    aSpeedButton.StateActive.Color := ucolorfuncs.Dunkler(aColor,40);
//    aSpeedButton.Font.Color        := clBlack;
  end
  else
  begin
    aSpeedButton.StateNormal.Color := aColor;
    aSpeedButton.StateHover.Color  := ucolorfuncs.Heller(aColor,25);
    aSpeedButton.StateActive.Color := ucolorfuncs.Heller(aColor,50);
//    aSpeedButton.Font.Color        := clWhite;
  end;


end;

procedure TForm1.Image6Click(Sender: TObject);
var
  bCollapse : Boolean;
begin
  bCollapse := pnlLeft.Width > pnlLeft.Constraints.MinWidth;
  if bCollapse then
    pnlLeft.Width := pnlLeft.Constraints.MinWidth
  else
    pnlLeft.Width := pnlLeft.Constraints.MaxWidth;
  pnlLeft.ShowHint := bCollapse;
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
  Colorize(ColorSpeedButton1);
  Colorize(ColorSpeedButton2);
  Colorize(ColorSpeedButton3);
  Colorize(ColorSpeedButton4);
  Colorize(ColorSpeedButton5);
  Colorize(ColorSpeedButton6);
  Colorize(ColorSpeedButton7);
  Colorize(ColorSpeedButton8);
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
  Colorize(ColorSpeedButton9);
  Colorize(ColorSpeedButton10);
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  close;
end;

procedure TForm1.ColorSpeedButton1Click(Sender: TObject);
begin
  ExtendedNotebook1.ActivePageIndex:= TColorSpeedButton(Sender).Tag-1;
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
//  ShowMessage(fname);
  Colorize(ColorSpeedButton1);
  Colorize(ColorSpeedButton2);
  Colorize(ColorSpeedButton3);
  Colorize(ColorSpeedButton4);
  Colorize(ColorSpeedButton5);
  Colorize(ColorSpeedButton6);
  Colorize(ColorSpeedButton7);
  Colorize(ColorSpeedButton8);
  Colorize(ColorSpeedButton9);
  Colorize(ColorSpeedButton10);
  ExtendedNotebook1.ActivePageIndex:=0;
  ExtendedNotebook1.ShowTabs:=False;
end;


end.

