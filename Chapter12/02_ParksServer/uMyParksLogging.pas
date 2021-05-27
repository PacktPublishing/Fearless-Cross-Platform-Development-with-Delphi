unit uMyParksLogging;

interface

uses
  LoggerPro,
  LoggerPro.FileAppender,
  LoggerPro.ConsoleAppender;

var
  Log: ILogWriter;

implementation

initialization
  Log := BuildLogWriter([TLoggerProFileAppender.Create,
                         TLoggerProConsoleAppender.Create]);
end.
