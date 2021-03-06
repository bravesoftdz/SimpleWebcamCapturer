unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vfw, VFrames, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfMain = class(TForm)
    liveImage: TImage;
    gbLivePreview: TGroupBox;
    gbPreviewOptions: TGroupBox;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnImageOptions: TButton;
    btnVideoOptions: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbListDevices: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnImageOptionsClick(Sender: TObject);
    procedure btnVideoOptionsClick(Sender: TObject);
  private
    a_Video: TVideoImage;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.btnConnectClick(Sender: TObject);
begin
  a_Video.VideoStart(cbListDevices.Items[cbListDevices.ItemIndex]);
end;

procedure TfMain.btnDisconnectClick(Sender: TObject);
begin
  a_Video.VideoStop;
end;

procedure TfMain.btnImageOptionsClick(Sender: TObject);
begin
  a_Video.ShowProperty;
end;

procedure TfMain.btnVideoOptionsClick(Sender: TObject);
begin
  a_Video.ShowProperty_Stream;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(a_Video);
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  v_ListOfDevices: TStringList;
begin
  a_Video := TVideoImage.Create;
  v_ListOfDevices := TStringList.Create;
  try
    try
      a_Video.SetDisplayCanvas(liveImage.Canvas);
      a_Video.GetListOfDevices(v_ListOfDevices);
      cbListDevices.Items.Assign(v_ListOfDevices);
    except
      on E: Exception do
      begin
        ShowMessage('Error: ' + E.Message);
        Close;
      end;
    end;
  finally
    v_ListOfDevices.Free;
  end;
end;

end.
