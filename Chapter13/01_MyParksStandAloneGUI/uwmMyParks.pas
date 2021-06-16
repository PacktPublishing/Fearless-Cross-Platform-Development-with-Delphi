unit uwmMyParks;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, Web.DSProd,
  FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI, Web.DBWeb;

type
  TwmMyParks = class(TWebModule)
    ppAbout: TPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    dstpMyParks: TDataSetTableProducer;
    ppGetParkQuery: TPageProducer;
    ppShowParkFromCoords: TPageProducer;
    ppPageHeader: TPageProducer;
    ppPageFooter: TPageProducer;
    ppMenu: TPageProducer;
    ppParkList: TPageProducer;
    procedure ppStandardHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
    procedure ppShowParkFromCoordsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
    procedure wmMyParkswaiShowParkFromCoordsAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure ppPageHeaderHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FPageTitle: string;
    FLongitude, FLatitude: Double;
    FParkName: string;
    function CheckFooter(const TagString: string): string;
    function CheckAppName(const TagString: string): string;
    function GetMenu(CurrPageProducer: TPageProducer): string;
  end;

var
  WebModuleClass: TComponentClass = TwmMyParks;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  LoggerPro,
  LoggerPro.FileAppender,
  uMyParksLogging,
  udmParksDB;

{$R *.dfm}

const
  APP_NAME = 'My Parks';
  LOG_TAG  = 'web';


function TwmMyParks.CheckAppName(const TagString: string): string;
begin
  if SameText(TagString, 'AppName') then begin
    Log.Debug('CheckAppName: replacing AppName with: ' + APP_NAME, LOG_TAG);
    Result := APP_NAME;
  end else
    Result := EmptyStr;
end;

procedure TwmMyParks.ppPageHeaderHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
  var ReplaceText: string);
begin
  Log.Debug('Page Header; Tag: ' + TagString, LOG_TAG);

  ReplaceText := CheckAppName(TagString);
  if ReplaceText.IsEmpty then
    if SameText(TagString, 'PageTitle') then
      ReplaceText := FPageTitle
    else
      ReplaceText := EmptyStr;
end;

function TwmMyParks.CheckFooter(const TagString: string): string;
begin
  Log.Debug('Page Footer; Tag: ' + TagString, LOG_TAG);

  if SameText(TagString, 'Footer') then
    Result := ppPageFooter.Content
  else
    Result := EmptyStr;
end;

function TwmMyParks.GetMenu(CurrPageProducer: TPageProducer): string;
const
  UL_START     = '<ul class="nav nav-pills">';
  LI_START     = '<li class="nav-item">';
  ABOUT_FMT    = '<a class="nav-link %s" href="about">About</a>';
  PARKLIST_FMT = '<a class="nav-link %s" href="parklist">List Parks</a>';
  GETPARK_FMT  = '<a class="nav-link %s" href="getpark">Get Park Name</a>';
  LI_END       = '</li>';
  UL_END       = '</ul>';

  function NavLink(FormatText: string; Test: Boolean): string; inline;
  begin
    Result := LI_START + Format(FormatText, [IfThen(Test, 'active', '')]) + LI_END;
  end;

begin
  Log.Debug('Creating Menu for: ' + CurrPageProducer.Name, LOG_TAG);

  Result :=
    UL_START +
    NavLink(ABOUT_FMT,   CurrPageProducer = ppAbout) +
    NavLink(GETPARK_FMT, CurrPageProducer = ppGetParkQuery) +
    NavLink(PARKLIST_FMT, CurrPageProducer = ppParkList) +
    UL_END;
end;

procedure TwmMyParks.ppStandardHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  Log.Debug('Standard HTML; Tag: ' + TagString, LOG_TAG);

  if SameText(TagString, 'Header') then begin
    if (TagParams.Count = 1) then begin
      FPageTitle := TagParams.Values['PageTitle'];
      ReplaceText := ppPageHeader.Content;
    end;
  end else if SameText(TagString, 'Menu') then
    ReplaceText := GetMenu(Sender as TPageProducer)
  else if SameText(TagString, 'Footer') then
    ReplaceText := ppPageFooter.Content;

  // only for Park List
  if ReplaceText.IsEmpty and SameText(TagString, 'parklist') then
    ReplaceText := dstpMyParks.Content;
end;

procedure TwmMyParks.ppShowParkFromCoordsHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  Log.Debug('ShowParkFromCoords; Tag: ' + TagString, LOG_TAG);

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
  Log.Debug('ShowParkFromCoords; Request: ' + Request.ToString, LOG_TAG);

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
  Log := BuildLogWriter([TLoggerProFileAppender.Create]);
  Log.Info('web module created', LOG_TAG);
end;

procedure TwmMyParks.WebModuleDestroy(Sender: TObject);
begin
  Log.Info('web module freed', LOG_TAG);
end;

end.
