unit ucolorfuncs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

function Dunkler(farbe: TColor; prozent: Byte): TColor;
function Heller(farbe: TColor; prozent: Byte): TColor;
function Helligkeit(farbe: TColor) : Integer;
function GetContrastColorBlackOrWhite(const AColor: TColor): TColor; //Dieser Funktion kann man eine beliebige Farbe übergeben 
                                                                     //und man bekommt entweder schwarz oder weiß zurückgegeben, 
                                                                     //je nachdem was besser zur Hintergrundfarbe passt.

implementation

function Dunkler(farbe: TColor; prozent: Byte): TColor;
var c: array [0..2] of Byte;
    i: Integer;
begin
 c[0]:= (farbe and $FF);
 c[1]:= (farbe and $FF00) shr 8;
 c[2]:= (farbe and $FF0000) shr 16;
 for i:= 0 to 2 do
 begin
   c[i]:= (c[i]* (100 - prozent)) div 100;
 end;
 Result:= c[0] + (c[1] shl 8) + (c[2] shl 16);
end;


function Heller(farbe: TColor; prozent: Byte): TColor;
var c: array [0..2] of Word;
    i: Integer;
begin
 c[0]:= (farbe and $FF);
 c[1]:= (farbe and $FF00) shr 8;
 c[2]:= (farbe and $FF0000) shr 16;
 for i:= 0 to 2 do begin
  c[i]:= (c[i]* (100 + prozent)) div 100;
  if c[i]>255 then c[i]:= 255;
 end;
 Result:= c[0] + (c[1] shl 8) + (c[2] shl 16);
end;

function Helligkeit(farbe: TColor) : Integer;
var
  r, g, b : Word;
begin
  result := 0;
  r := (farbe and $FF);
  g := (farbe and $FF00) shr 8;
  b := (farbe and $FF0000) shr 16;
  result := round(sqrt(0.299*r*r + 0.587*g*g + 0.114*b*b));
end;

function GetContrastColorBlackOrWhite(const AColor: TColor): TColor;
var
  R, G, B: single;
begin
  R := GetRValue(AColor) * 0.25;
  G := GetGValue(AColor) * 0.625;
  B := GetBValue(AColor) * 0.125;
 
  if (R + G + B) > 128 then begin
    result := clBlack;
  end else begin
    result := clWhite;
  end; 
  
end;
end.

