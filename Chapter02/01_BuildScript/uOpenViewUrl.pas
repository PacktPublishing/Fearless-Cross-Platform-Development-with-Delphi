unit uOpenViewUrl;
{ from:
  https://stackoverflow.com/questions/7443264/how-to-open-an-url-with-the-default-browser-with-firemonkey-cross-platform-appli/7453797
  https://www.developpeur-pascal.fr/p/_2000-ouvrir-un-site-web-dans-le-navigateur-par-defaut-depuis-une-application-firemonkey.html
}
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  {$IF Defined(IOS)}
  macapi.helpers, iOSapi.Foundation, FMX.helpers.iOS;
  {$ELSEIF Defined(ANDROID)}
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net, Androidapi.JNI.App, Androidapi.helpers;
  {$ELSEIF Defined(MACOS) OR Defined(LINUX64)}
  Posix.Stdlib;
  {$ELSEIF Defined(MSWINDOWS)}
  Winapi.ShellAPI, Winapi.Windows;
  {$ENDIF}

procedure OpenURL(const URL: string);


implementation

procedure OpenURL(const URL: string);
{$IF Defined(ANDROID)}
var
  Intent: JIntent;
{$ENDIF}
begin
{$IF Defined(ANDROID)}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(URL));
  tandroidhelper.Activity.startActivity(Intent);
  // SharedActivity.startActivity(Intent);
{$ELSEIF Defined(MSWINDOWS)}
  ShellExecute(0, 'OPEN', PWideChar(URL), nil, nil, SW_SHOWNORMAL);
{$ELSEIF Defined(IOS)}
  SharedApplication.OpenURL(StrToNSUrl(URL));
{$ELSEIF Defined(MACOS) OR Defined(LINUX64)}
  _system(PAnsiChar('open ' + AnsiString(URL)));
{$ENDIF}
end;

end.