unit unt.Helpers.TCustomEdit;

interface

uses
  Vcl.StdCtrls, System.Classes;

type
  TCustomEditHelper = class helper for TCustomEdit
  private
    function GetTextStr: String;
    procedure SetTextStr(const Value: String);
  public
    function IsEmpty: Boolean;
  published
    property TextStr: String read GetTextStr write SetTextStr;
  end;

implementation

uses
  System.SysUtils;

{ TCustomEditHelper }

function TCustomEditHelper.GetTextStr: String;
begin
  Result := Self.Text;
end;

function TCustomEditHelper.IsEmpty: Boolean;
begin
  Result := Trim(Self.Text) = '';
end;

procedure TCustomEditHelper.SetTextStr(const Value: String);
begin
  Self.Text := Value;
end;

end.
