unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList,
  DBGrids,
  ColorSpeedButton,
  ExtendedNotebook,
  IniFiles,
  SQLite3DS, DB,
  LazFileUtils,
  lclIntf,
  ustrfuncs,
  laz2_DOM,
  laz2_XMLRead;

type

  { TForm1 }

  TForm1 = class(TForm)
    actExit: TAction;
    actCustomerFileImport: TAction;
    ActionList1: TActionList;
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
    cmbThemes: TComboBox;
    ContactsDataSource: TDataSource;
    DBGrid1: TDBGrid;
    ExtendedNotebook1: TExtendedNotebook;
    Image6: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OpenDialog1: TOpenDialog;
    pnlClient: TPanel;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    ContactsDataset: TSqlite3Dataset;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    procedure actCustomerFileImportExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure cmbThemesChange(Sender: TObject);
    procedure ColorSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    ConfigDir : String;
    Ini : TMemIniFile;
    ApplColors : Array[1..5] of TColor;
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
  aSpeedButton.StateNormal.Color := aColor;
  aSpeedButton.StateHover.Color  := ApplColors[3];
  aSpeedButton.StateActive.Color := ApplColors[4];

  aSpeedButton.Font.Color        := GetContrastColorBlackOrWhite(aColor);
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
end;

procedure TForm1.Label11Click(Sender: TObject);
begin
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ContactsDataset.Append;
  ContactsDataset.FieldByName('KdNr').AsFloat := 1000000 + Random(32000);
  ContactsDataset.FieldByName('Kampagne').AsString := 'Test-Kampagne';
  ContactsDataset.FieldByName('Name').AsString := 'Fritz Kirch';
  ContactsDataset.FieldByName('Email').AsString := 'xxx@yyy.com';
  ContactsDataset.FieldByName('Telefon').AsString := '0911-307300';
  ContactsDataset.Post;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ContactsDataset.ApplyUpdates;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if ContactsDataset.RecordCount > 0 then
     ContactsDataset.Delete;
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  close;
end;

procedure TForm1.actCustomerFileImportExecute(Sender: TObject);
var
  doc : TXMLDocument;
  child : TDOMNode;
begin
  //
  ShowMessage('Hier startet in Kürze der Datenimport');
  if OpenDialog1.Execute then
  begin
  // Read in xml file from disk
    try
      ReadXMLFile(Doc, OpenDialog1.FileName);
      Child := Doc.DocumentElement.FirstChild;
      while Assigned(Child) do
      begin
        ContactsDataset.Append;
        ContactsDataset.FieldByName('KdNr').AsFloat := 1000000 + StrToInt(TDOMElement(Child).GetAttribute('id'));
        ContactsDataset.FieldByName('Kampagne').AsString := 'Test-Kampagne';
        ContactsDataset.FieldByName('Name').AsString := TDOMElement(Child).GetAttribute('firmenname');
        ContactsDataset.FieldByName('Email').AsString := TDOMElement(Child).GetAttribute('email');
        ContactsDataset.FieldByName('Telefon').AsString := format('(%s) %s',[ TDOMElement(Child).GetAttribute('vorwahl'),
                                                             TDOMElement(Child).GetAttribute('telefon')]);
        ContactsDataset.Post;
        Child := Child.NextSibling;
      end;
    finally
      doc.free;
    end;
  end;

end;

procedure TForm1.cmbThemesChange(Sender: TObject);
var
  i : integer;
  s, ss, sTheme : String;
  farbarray : TStrArray;
  rgbwerte  : TStrArray;
begin
  sTheme := cmbThemes.Items[cmbThemes.ItemIndex];
  s := ini.ReadString('Farbschemata',sTheme,'');
  if s = '' then exit;
  farbarray := ustrfuncs.Split(s,'|');
  for i := 1 to 5 do
  begin
    rgbwerte := ustrfuncs.Split( farbarray[i-1],',');
    ApplColors[i] := rgbToColor(StrToInt(rgbwerte[0]),
                                StrToInt(rgbwerte[1]),
                                StrToInt(rgbwerte[2]));
  end;
  Ini.WriteString('Application','ColorTheme', sTheme);
  pnlLeft.Color := ApplColors[1];
  Colorize(ColorSpeedButton1);
  Colorize(ColorSpeedButton2);
  Colorize(ColorSpeedButton3);
  Colorize(ColorSpeedButton4);
  Colorize(ColorSpeedButton5);
  Colorize(ColorSpeedButton6);
  Colorize(ColorSpeedButton7);
  Colorize(ColorSpeedButton8);
  pnlTop.Color := ApplColors[1];
  Colorize(ColorSpeedButton9);
  Colorize(ColorSpeedButton10);

  DBGrid1.FixedColor:= ApplColors[1];
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
  i : integer;
  fname : String;
  SL : TStringList;
begin
  ConfigDir := GetAppConfigDir(False);
  fname := ConfigDir+'Application.ini';
  Ini := TMemInifile.Create(fname, TEncoding.UTF8);
  Ini.WriteString('Application','Username','Fritz Kirch');
  pnlLeft.Color := StringToColor(Ini.ReadString('Farben','PanelLeft','clBlack'));
  pnlTop.Color  := StringToColor(Ini.ReadString('Farben','PanelTop','clWhite'));

  SL := TStringList.Create;
  Ini.ReadSection('Farbschemata',SL);
  cmbThemes.Clear;
  for i := 0 to SL.count - 1 do
      cmbThemes.Items.Add(SL[i]);

  cmbThemes.Text := ini.ReadString('Application','ColorTheme','');
  cmbThemesChange(cmbThemes);

//  ShowMessage(fname);
  ExtendedNotebook1.ActivePageIndex :=0;
  ExtendedNotebook1.ShowTabs :=False;
  ExtendedNotebook1.TabPosition := tpLeft;

  ForceDirectoriesUTF8(GetAppConfigDirUTF8(False));
  with ContactsDataset do
  begin
    FileName := IncludeTrailingPathDelimiter(GetAppConfigDirUTF8(False))+'data.db';
    if not TableExists then
    begin
      FieldDefs.Clear;
      FieldDefs.Add('Id', ftAutoInc);
      FieldDefs.Add('Kampagne', ftString);
      FieldDefs.Add('KdNr', ftString);
      FieldDefs.Add('Name', ftString);
      FieldDefs.Add('Email', ftString);
      FieldDefs.Add('Telefon', ftString);
      CreateTable;
    end;
    Open;
  end;
end;


end.

