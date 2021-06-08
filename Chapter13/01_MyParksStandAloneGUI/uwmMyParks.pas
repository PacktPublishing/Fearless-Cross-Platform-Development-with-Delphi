unit uwmMyParks;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, Web.DSProd, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, Web.DBWeb;

type
  TwmMyParks = class(TWebModule)
    ppAbout: TPageProducer;
    ppMainPage: TPageProducer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    dstpMyParks: TDataSetTableProducer;
    procedure ppAboutHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
  end;

var
  WebModuleClass: TComponentClass = TwmMyParks;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  udmParksDB;

{$R *.dfm}

const
  APP_NAME = 'My Parks';

procedure TwmMyParks.ppAboutHTMLTag(Sender: TObject; Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'AppName') then
    ReplaceText := APP_NAME;
end;

end.
