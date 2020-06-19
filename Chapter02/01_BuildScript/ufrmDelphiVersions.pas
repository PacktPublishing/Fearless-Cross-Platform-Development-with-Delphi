unit ufrmDelphiVersions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfrmDelphiVersions = class(TForm)
    lblIntro: TLabel;
    lbDefs: TListBox;
    pnlBottom: TPanel;
    Label2: TLabel;
    edtAboutLink: TEdit;
    Label3: TLabel;
    edtClassLink: TEdit;
    btnCopyAboutLink: TSpeedButton;
    btnCopyClassLink: TSpeedButton;
    Label1: TLabel;
    edtDirectivesLink: TEdit;
    btnCopyDirectivesLink: TSpeedButton;
    Label4: TLabel;
    edtVersionsLink: TEdit;
    btnCopyVersionsLink: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnCopyAboutLinkClick(Sender: TObject);
    procedure btnCopyClassLinkClick(Sender: TObject);
    procedure btnCopyDirectivesLinkClick(Sender: TObject);
    procedure btnCopyVersionsLinkClick(Sender: TObject);
  end;

var
  frmDelphiVersions: TfrmDelphiVersions;

implementation

{$R *.dfm}

uses
  Clipbrd,
  uConditionalList;

procedure ShowCompilerDefine(const CompDefined: string);
begin
  frmDelphiVersions.lbDefs.Items.Add(CompDefined);
end;


procedure TfrmDelphiVersions.btnCopyAboutLinkClick(Sender: TObject);
begin
  Clipboard.AsText := edtAboutLink.Text;
  ShowMessage('"About" Link copied.');
end;

procedure TfrmDelphiVersions.btnCopyClassLinkClick(Sender: TObject);
begin
  Clipboard.AsText := edtClassLink.Text;
  ShowMessage('"Classification" Link copied.');
end;

procedure TfrmDelphiVersions.btnCopyDirectivesLinkClick(Sender: TObject);
begin
  Clipboard.AsText := edtDirectivesLink.Text;
  ShowMessage('"Directives" Link copied.');
end;

procedure TfrmDelphiVersions.btnCopyVersionsLinkClick(Sender: TObject);
begin
  Clipboard.AsText := edtVersionsLink.Text;
  ShowMessage('"Versions" Link copied.');
end;

procedure TfrmDelphiVersions.FormActivate(Sender: TObject);
begin
  GetConditionalDefines(ShowCompilerDefine);
  SetupReferenceLinks;

  lblIntro.Caption := IntroText;
  edtAboutLink.Text := IntroLink1;
  edtClassLink.Text := IntroLink2;
  edtDirectivesLink.Text := DirectivesLink;
  edtVersionsLink.Text := VersionsLink;
end;

end.
