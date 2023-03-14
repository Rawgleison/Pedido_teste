unit unt.Helpers.JSON;

interface

uses
  System.JSON;

type
  TMyClass = class helper for TJSONObject
  private
    { private declarations }
  protected
    { protected declarations }
  public
    function ContainsKey(AKey: String): Boolean;

  published
    { published declarations }
  end;

implementation

{ TMyClass }

function TMyClass.ContainsKey(AKey: String): Boolean;
var
  i: Integer;
  key: string;
begin
  Result := False;
  for i := 0 to self.Count - 1 do
  begin
    key := self.Pairs[i].JsonString.Value;
    if key = AKey then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

end.
