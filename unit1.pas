unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
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
    procedure Image6Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label1MouseEnter(Sender: TObject);
begin
  TPanel(TWinControl(Sender).Parent).Color:= rgbToColor(255,0,0);
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

procedure TForm1.Label1MouseLeave(Sender: TObject);
begin
  TPanel(TWinControl(Sender).Parent).Color :=
         TPanel(TWinControl(Sender).Parent).Parent.Color
end;

end.

