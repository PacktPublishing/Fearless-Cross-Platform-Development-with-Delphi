unit uwmMyParks;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, Web.DSProd, FireDAC.UI.Intf,
  {$IFDEF LINUX} FireDAC.ConsoleUI.Wait, {$ELSE} FireDAC.VCLUI.Wait, FireDAC.Comp.UI, {$ENDIF}
  FireDAC.Stan.Intf, Web.DBWeb;

type
  TwmMyParks = class(TWebModule)
    ppAbout: TPageProducer;
    ppGetParkQuery: TPageProducer;
    ppShowParkFromCoords: TPageProducer;
    ppPageHeader: TPageProducer;
    ppPageFooter: TPageProducer;
    ppMenu: TPageProducer;
    ppParkList: TPageProducer;
    dstpMyParks: TDataSetTableProducer;
    procedure WebModuleCreate(Sender: TObject);
    procedure ppStandardHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure ppShowParkFromCoordsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure wmMyParkswaiShowParkFromCoordsAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure ppPageHeaderHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleDestroy(Sender: TObject);
    procedure ppPageFooterHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    FPageTitle: string;
    FLongitude, FLatitude: Double;
    FParkName: string;
    function CheckRequestTags(const TagString: string): string;
    function CheckFooter(const TagString: string): string;
    function CheckAppName(const TagString: string): string;
    function GetMenu(CurrPageProducer: TPageProducer): string;
    function GetParkList: string;
  end;

var
  WebModuleClass: TComponentClass = TwmMyParks;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.IOUtils,
  LoggerPro,
  LoggerPro.FileAppender,
  udmParksDB,
  uMyParksLogging;

{$R *.dfm}

const
  {$IFDEF MSWINDOWS}
  APP_NAME = 'My Parks - Apache Windows';
  {$ELSE}
  APP_NAME = 'My Parks - Apache Linux';
  {$ENDIF}

  LOG_TAG  = 'web';


function TwmMyParks.CheckAppName(const TagString: string): string;
begin
  if SameText(TagString, 'AppName') then
    Result := APP_NAME
  else
    Result := EmptyStr;
end;

procedure TwmMyParks.ppPageFooterHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  Replacetext := CheckRequestTags(TagString);
end;

procedure TwmMyParks.ppPageHeaderHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
  var ReplaceText: string);
begin
  ReplaceText := CheckAppName(TagString);
  if ReplaceText.IsEmpty then
    if SameText(TagString, 'PageTitle') then
      ReplaceText := FPageTitle
    else
      ReplaceText := EmptyStr;
end;

function TwmMyParks.CheckFooter(const TagString: string): string;
begin
  if SameText(TagString, 'Footer') then
    Result := ppPageFooter.Content
  else
    Result := EmptyStr;
end;

function TwmMyParks.CheckRequestTags(const TagString: string): string;
begin
  if SameText(TagString, 'Method') then
    Result := Request.Method
  else if SameText(TagString, 'ProtocolVersion') then
    Result := Request.ProtocolVersion
  else if SameText(TagString, 'URL') then
    Result := Request.URL
  else if SameText(TagString, 'Query') then
    Result := Request.Query
  else if SameText(TagString, 'PathInfo') then
    Result := Request.PathInfo
  else if SameText(TagString, 'PathTranslated') then
    Result := Request.PathTranslated
  else if SameText(TagString, 'Authorization') then
    Result := Request.Authorization
  else if SameText(TagString, 'Accept') then
    Result := Request.Accept
  else if SameText(TagString, 'From') then
    Result := Request.From
  else if SameText(TagString, 'Host') then
    Result := Request.Host
  else if SameText(TagString, 'Referrer') then
    Result := Request.Referer
  else if SameText(TagString, 'UserAgent') then
    Result := Request.UserAgent
  else if SameText(TagString, 'ContentType') then
    Result := Request.ContentType
  else if SameText(TagString, 'Content') then
    Result := Request.Content
  else if SameText(TagString, 'Connection') then
    Result := Request.Connection
  else if SameText(TagString, 'Title') then
    Result := Request.Title
  else if SameText(TagString, 'RemoteAddr') then
    Result := Request.RemoteAddr
  else if SameText(TagString, 'RemoteHost') then
    Result := Request.RemoteHost
  else if SameText(TagString, 'ScriptName') then
    Result := Request.ScriptName
  else if SameText(TagString, 'InternalPathInfo') then
    Result := Request.InternalPathInfo
  else if SameText(TagString, 'RemoteIP') then
    Result := Request.RemoteIP;
end;

function TwmMyParks.GetMenu(CurrPageProducer: TPageProducer): string;
const
  UL_START     = '<ul class="nav nav-pills">';
  LI_START     = '<li class="nav-item">';
  ABOUT_FMT    = '<a class="nav-link %s" href="%s/about">About</a>';
  GETPARK_FMT  = '<a class="nav-link %s" href="%s/getpark">Get Park Name</a>';
  PARKLIST_FMT = '<a class="nav-link %s" href="%s/parklist">Park List</a>';
  LI_END       = '</li>';
  UL_END       = '</ul>';

  function NavLink(FormatText, BaseURL: string; Test: Boolean): string; inline;
  begin
    Result := LI_START + Format(FormatText, [IfThen(Test, 'active', ''), BaseURL]) + LI_END;
  end;

begin
  Result :=
    UL_START +
    NavLink(ABOUT_FMT,    Request.ScriptName, CurrPageProducer = ppAbout) +
    NavLink(GETPARK_FMT,  Request.ScriptName, CurrPageProducer = ppGetParkQuery) +
    NavLink(PARKLIST_FMT, Request.ScriptName, CurrPageProducer = ppParkList) +
    UL_END;
end;

function TwmMyParks.GetParkList: string;
begin
{$IFDEF LINUX}
  Result := '<p>DataSets, such as the Park List, are not available on Linux due to a need for a wait cursor.</p>';
{$ELSE}
  Log.Debug('getting park list', LOG_TAG);
  try
    Result := dstpMyParks.Content;
  except
    on e:Exception do
      Log.Error(e.Message, LOG_TAG);
  end;
  Log.Debug('parks are closed', LOG_TAG);
{$ENDIF}
end;

procedure TwmMyParks.ppStandardHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'Header') then begin
    if (TagParams.Count = 1) then begin
      FPageTitle := TagParams.Values['PageTitle'];
      ReplaceText := ppPageHeader.Content;
    end;
  end else if SameText(TagString, 'Menu') then
    ReplaceText := GetMenu(Sender as TPageProducer)
  else if SameText(TagString, 'Footer') then
    ReplaceText := ppPageFooter.Content
  else if SameText(TagString, 'parklist') then
    ReplaceText := GetParkList
  else
    Replacetext := CheckRequestTags(TagString);
end;

procedure TwmMyParks.ppShowParkFromCoordsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'Header') then begin
    if (TagParams.Count = 1) then begin
      FPageTitle := TagParams.Values['PageTitle'];
      ReplaceText := ppPageHeader.Content;
    end;
  end else if SameText(TagString, 'Menu') then
    ReplaceText := GetMenu(Sender as TPageProducer)
  else
    ReplaceText := CheckFooter(TagString);

  if ReplaceText.IsEmpty then
    if SameText(TagString, 'longitude') then
      ReplaceText := FLongitude.ToString
    else if SameText(TagString, 'latitude') then
      ReplaceText := FLatitude.ToString
    else if SameText(TagString, 'ParkName') then
      ReplaceText := FParkName;
end;

procedure TwmMyParks.wmMyParkswaiShowParkFromCoordsAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.QueryFields.Count = 2 then begin
    var long, lat: Double;
    if TryStrToFloat(Request.QueryFields.Values['long'] , long) and
       TryStrToFloat(Request.QueryFields.Values['lat'], lat) then begin
      FLongitude := long;
      FLatitude := lat;
      var ParkInfo := dmParksDB.LookupParkByLocation(FLongitude, FLatitude);
      FParkName := ParkInfo.ParkName;
    end;
  end;

  Response.Content := ppShowParkFromCoords.Content;
end;

procedure TwmMyParks.WebModuleCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  Log := BuildLogWriter([TLoggerProFileAppender.Create]);
{$ELSE}
  Log := BuildLogWriter([TLoggerProFileAppender.Create(5, 1000,
                TPath.Combine(WebApplicationDirectory, 'logs'))]);
{$ENDIF}
  Log.Info('web module created', LOG_TAG);
end;

procedure TwmMyParks.WebModuleDestroy(Sender: TObject);
begin
  Log.Info('web module shutting down', LOG_TAG);
end;

end.
