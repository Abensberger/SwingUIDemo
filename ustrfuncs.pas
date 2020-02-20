unit ustrfuncs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TStrArray = Array of String;

// **** STRING functions *****************************************************//
function strBefore(substr,source : String) : string;
function strAfter(substr,source : String) : string;
function contains(s:String; substring:string) : Boolean;
function Split(S: String; Delimiter: Char): TStrArray;

implementation

{******************************************************************************}
function contains(s:String; substring:string) : Boolean;
begin
  result := pos(substring,s) > 0;
end;

{******************************************************************************}
function StrBefore(substr,source : String) : string;
var p : integer;
begin
  p := pos(substr,source);
  if p <= 1 then
    result := ''
  else
    result := copy(source,1,p-1);
end;

{******************************************************************************}
function StrAfter(substr,source : String) : string;
var p : integer;
begin
  p := pos(substr,source);
  if p < 1 then
    result := ''
  else
    result := copy(source,p+length(substr),length(source));
end;

{******************************************************************************}
function Split(S: String; Delimiter: Char): TStrArray;
var C: Integer;
begin
  SetLength(Result,0);
  Repeat
    SetLength(Result, Length(Result)+ 1);
    C:= Pos(Delimiter, S);
    If C= 0 Then C:= Length(S)+ 1;
    Result[Length(Result)- 1]:= Copy(S, 1, C- 1);
    Delete(S, 1, C);
  Until Length(S)= 0;
end;


{******************************************************************************}

end.

