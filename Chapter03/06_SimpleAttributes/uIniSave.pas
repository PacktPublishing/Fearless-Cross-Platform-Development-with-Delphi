unit uIniSave;

interface

uses
  System.Rtti, System.TypInfo;

type
  IniSaveClassAttribute = class(TCustomAttribute)
  private
    FTheClassName: string;
  published
    property TheClassName: string read FTheClassName write FTheClassName;
  end;

  IniIgnoreAttribute = class(TCustomAttribute);

  IniDefaultAttribute = class(TCustomAttribute)
  private
    FDefaultValue: string;
  public
    constructor Create(const NewDefaultValue: string);
  published
    property DefaultValue: string read FDefaultValue write FDefaultValue;
  end;

  TIniSave = class
  private
    class procedure SetValue(AData: string; var AValue: TValue);
    class function GetValue(var AValue: TValue): string;
    class function GetClassName(MyObj: TRttiObject; const MyObjName: string): IniSaveClassAttribute;
    class function GetPropIgnoreAttribute(MyObj: TRttiObject): IniIgnoreAttribute;
    class function GetDefaultAttributeValue(MyObj: TRttiObject): string;
  public
    class procedure Load(FileName: string; MyObj: TObject);
    class procedure Save(FileName: string; MyObj: TObject);
  end;


implementation

uses
  System.SysUtils, System.IniFiles;

{ IniDefaultAttribute }

constructor IniDefaultAttribute.Create(const NewDefaultValue: string);
begin
  FDefaultValue := NewDefaultValue;
end;

{ TIniSave }

class function TIniSave.GetClassName(MyObj: TRttiObject; const MyObjName: string): IniSaveClassAttribute;
var
  Attr: TCustomAttribute;
begin
  Result := nil;

  // check to make sure the class attribute is applied to this object
  for Attr in MyObj.GetAttributes do
    if Attr is IniSaveClassAttribute then begin
      // it is, so create the class attribute
      Result := IniSaveClassAttribute.Create;
      // and grab the name of the class
      Result.TheClassName := MyObjName;
      Break;
    end;
end;

class function TIniSave.GetDefaultAttributeValue(MyObj: TRttiObject): string;
{ check to see if the IniDefaultAttribute is assigned; if so, return the default string }
var
  Attr: TCustomAttribute;
begin
  Result := EmptyStr;

  for Attr in MyObj.GetAttributes do
    if Attr is IniDefaultAttribute then begin
      Result := IniDefaultAttribute(Attr).DefaultValue;
      Break;
    end;
end;

class function TIniSave.GetPropIgnoreAttribute(MyObj: TRttiObject): IniIgnoreAttribute;
{ check to see if the IniIgnoreAttribute is assigned }
var
  Attr: TCustomAttribute;
begin
  Result := nil;

  for Attr in MyObj.GetAttributes do
    if Attr is IniIgnoreAttribute then begin
      Result := IniIgnoreAttribute(Attr);
      Break;
    end;
end;

class function TIniSave.GetValue(var AValue: TValue): string;
begin
  if AValue.Kind in [tkWChar, tkLString, tkWString, tkString, tkChar, tkUString,
                     tkInteger, tkInt64, tkFloat, tkEnumeration, tkSet] then
    Result := AValue.ToString;
end;

class procedure TIniSave.Load(FileName: string; MyObj: TObject);
var
  LRttiContext : TRttiContext;
  LMyObjType : TRttiType;
  LMyProp: TRttiProperty;
  LIniClass: IniSaveClassAttribute;
  LIniPropIgnore: IniIgnoreAttribute;
  LData: string;
  LDefaultData: string;
  LValue: TValue;
  LIniFile: TIniFile;
begin
  LRttiContext := TRttiContext.Create;
  try
    LIniFile := TIniFile.Create(FileName);
    try
      LMyObjType := LRttiContext.GetType(MyObj.ClassInfo);

      LIniClass := GetClassName(LMyObjType, MyObj.ClassName);
      if Assigned(LIniClass) then begin
        // look at all the properties of the class
        for LMyProp in LMyObjType.GetProperties do begin
          // check to see if this property is ignored in the class
          LIniPropIgnore := GetPropIgnoreAttribute(LMyProp);
          if not Assigned(LIniPropIgnore) then begin
            // not ignored, check to see if there's a default value
            LDefaultData := GetDefaultAttributeValue(LMyProp);

            // finally, read the data using the property name as the IniFile value name with the Class name as the section
            LData := LIniFile.ReadString(LIniClass.TheClassName, LMyProp.Name, LDefaultData);
          end;

          if Length(LData) > 0 then begin
            LValue := LMyProp.GetValue(MyObj);
            SetValue(LData, LValue);
            if LMyProp.IsWritable then
              LMyProp.SetValue(MyObj, LValue);
          end;
        end;
      end;
    finally
      LIniFile.Free;
    end;
  finally
    LRttiContext.Free;
  end;
end;

class procedure TIniSave.Save(FileName: string; MyObj: TObject);
var
  LRttiContext: TRttiContext;
  LMyObjType: TRttiType;
  LMyProp: TRttiProperty;
  LIniClassAttr: IniSaveClassAttribute;
  LInIgnoreAttr: IniIgnoreAttribute;
  LValue : TValue;
  LIniFile: TIniFile;
  LData : String;
begin
  LRttiContext := TRttiContext.Create;
  try
    LIniFile := TIniFile.Create(FileName);
    try
      LMyObjType := LRttiContext.GetType(MyObj.ClassInfo);

      LIniClassAttr := GetClassName(LMyObjType, MyObj.ClassName);
      if Assigned(LIniClassAttr) then
        // look at all the properties of the object
        for LMyProp in LMyObjType.GetProperties do begin
          // check to see if this property is ignored
          LInIgnoreAttr := GetPropIgnoreAttribute(LMyProp);

          if not Assigned(LInIgnoreAttr) then begin
            // not ignored, get the property value and write it out using property name as value name
            LValue := LMyProp.GetValue(MyObj);
            LData := GetValue(LValue);

            LIniFile.WriteString(LIniClassAttr.TheClassName, LMyProp.Name, LData);
          end;
        end;
    finally
      LIniFile.Free;
    end;
  finally
    LRttiContext.Free;
  end;
end;

class procedure TIniSave.SetValue(AData: string; var AValue: TValue);
var
  I: Integer;
  x: Double;
begin
  case AValue.Kind of
    tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:
      AValue := AData;
    tkInteger, tkInt64: begin
      if not TryStrToInt(AData, i) then
        i := 0;
      AValue := i;
    end;
    tkFloat: begin
      if not TryStrToFloat(AData, x) then
        x := 0.0;
      AValue := x;
    end;
    tkEnumeration:
      AValue := TValue.FromOrdinal(aValue.TypeInfo,GetEnumValue(aValue.TypeInfo,aData));
    tkSet: begin
      i :=  StringToSet(AValue.TypeInfo, AData);
      TValue.Make(@i, AValue.TypeInfo, AValue);
    end;
  end;
end;

end.
