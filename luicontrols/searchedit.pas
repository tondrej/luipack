unit SearchEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, StdCtrls, LMessages, LCLProc, Graphics;

type

  { TSearchEdit }

  TSearchEdit = class (TCustomEdit)
  private
    FIsEmpty: Boolean;
    FEmptyText: String;
    procedure SetEmptyText(const AValue: String);
  protected
    function RealGetText: TCaption; virtual;
    procedure RealSetText(const Value: TCaption); virtual;
    procedure TextChanged; override;
    procedure WMSetFocus(var Message: TLMSetFocus); message LM_SETFOCUS;
    procedure WMKillFocus(var Message: TLMKillFocus); message LM_KILLFOCUS;
  public
  published
    property EmptyText: String read FEmptyText write SetEmptyText;
    property IsEmpty: Boolean read FIsEmpty;
  end;

implementation

{ TSearchEdit }

procedure TSearchEdit.SetEmptyText(const AValue: String);
begin
  if FEmptyText=AValue then exit;
  FEmptyText:=AValue;
end;

function TSearchEdit.RealGetText: TCaption;
var
  VisibleText: String;
begin
  VisibleText := inherited RealGetText;
  if FIsEmpty and (VisibleText = FEmptyText) then
    Result := ''
  else
    Result := VisibleText;
end;

procedure TSearchEdit.RealSetText(const Value: TCaption);
begin
  DebugLn('RealSetText: ',Value);
end;

procedure TSearchEdit.TextChanged;
begin
  DebugLn('TextChanged: ',Text);
  DebugLn('FIsEmpty: ',BoolToStr(FIsEmpty, True));
  FIsEmpty := Trim(RealGetText) = '';
  inherited TextChanged;
end;

procedure TSearchEdit.WMSetFocus(var Message: TLMSetFocus);
begin
  inherited WMSetFocus(Message);
  if FIsEmpty then
  begin
    Font.Color := clWindowText;
    inherited RealSetText('');
  end;
end;

procedure TSearchEdit.WMKillFocus(var Message: TLMKillFocus);
begin
  inherited WMKillFocus(Message);
  if FIsEmpty then
  begin
    Font.Color := clGray;
    inherited RealSetText(FEmptyText);
  end;
end;

end.
