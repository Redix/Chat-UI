unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,Boxes,
  FMX.Gestures, FMX.Ani, FMX.Edit;

type
  TFMain = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    btnAdd: TSpeedButton;
    ToolBarLabel: TLabel;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BottomToolBar: TToolBar;
    ScrollBox1: TScrollBox;
    PanBusca: TPanel;
    LabNameDet: TLabel;
    btnPrevious: TSpeedButton;
    Rectangle1: TRectangle;
    RectAnimation1: TRectAnimation;
    Rectangle2: TRectangle;
    RoundRect1: TRoundRect;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    EdtTexto: TEdit;
    RecHead: TRectangle;
    ImgPhotoDet: TImage;
    Circle1: TCircle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    RecFondo: TRectangle;
    CallSaludo: TCalloutRectangle;
    LabSaludo: TLabel;
    CallComentario: TCalloutRectangle;
    LabComent: TLabel;
    TabControl1: TTabControl;
    RecBottom: TRectangle;
    Img_bot: TImage;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure BtnDosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  Const
    MMaxArray = 20;
  private
    { Private declarations }
    MPos   : Word;
    VecBox : Array[1..MMaxArray] of TChatBox;
    Procedure AddBox(Nom,Coment,Imagen:String;Viewed:Boolean;Fecha:TDateTime;NroMsg:integer);
    Procedure ViewDat(Sender:TObject);
    Procedure LoadData;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.fmx}


{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TFMain.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      Begin
       // TCustomAction(Sender).Text :=  TabControl1.ActiveTab.Text+'..'+IntToStr(TabControl1.ActiveTab.Tag );
        If TabControl1.ActiveTab.Tag = 2 then
          Begin
            btnAdd.Visible      := False;
            btnPrevious.Visible := True;
          End
        Else
        Begin
            btnAdd.Visible      := True;
            btnPrevious.Visible := False;
          End;

      End
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure TFMain.ViewDat(Sender:TObject);
Var
  LPos    : Integer;
  LName   : String;
  LPhoto  : String;
  LComent : String;
  LHeight : Word;
begin
  // Load Data
    LPos    := TPanel(Sender).Tag;
    LName   := VecBox[LPos].LabName.Text;
    LPhoto  := VecBox[LPos].LabPath.Text;
    LComent := VecBox[LPos].LabComent.Text;
    LHeight := (((Length(LComent) div 30)+1)*19)+10;

  // Show data
    LabNameDet.Text       := LName;
    LabComent.Text        := LComent;
    CallComentario.Height := LHeight;
    ImgPhotoDet.Bitmap.LoadFromFile(LPhoto);

  // Update Status
    VecBox[LPos].Viewed;

  // Controls
    TabControl1.TabIndex := 1;
    btnAdd.Visible       := False;
    btnPrevious.Visible  := True;
end;

procedure TFMain.AddBox(Nom,Coment,Imagen: String;Viewed:Boolean;Fecha:TDateTime;NroMsg:integer);
Var
  LBox : TChatBox;
begin
 // Box
  LBox := TChatBox.Create(Self);
  LBox.DatBox(Nom,Coment,Imagen,Viewed,Fecha,NroMsg);
  LBox.Parent := PanBusca.Parent;
  if MPos < MMaxArray then
    Begin
        Inc(MPos);
        VecBox[MPos]               := LBox;
        VecBox[MPos].RecCenter.Tag := MPos;
        LBox.RecCenter.OnClick     := ViewDat;
    End;

end;

procedure TFMain.BtnDosClick(Sender: TObject);
Var
  lp : String;
begin
  VecBox[1].LabName.Text := 'loles';
{
  TabControl1.TabIndex :=1;
  btnAdd.Visible  := False;
  btnPrevious.Visible := True;
  }
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  La : Word;
begin
  // Free
    For La := 1 to MPos do
      VecBox[La].Free;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  // Defines the default active tab
    TabControl1.First(TTabTransition.None);




end;

procedure TFMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (TabControl1.TabIndex <> 0) then
  begin
    TabControl1.First;
    Key := 0;
  end;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  LoadData;
end;

procedure TFMain.Image1Click(Sender: TObject);
begin
  close;
end;

procedure TFMain.LoadData;
Var
  LArchi  : TextFile;
  LCad    : String;
  LNom    : String;
  LCom    : String;
  LFot    : String;
  LVie    : String;
  LFec    : String;
  LMes    : String;
  LErr    : Boolean;
  La,LPos : Word;
  LFecV   : TDateTime;
  LMesV   : Integer;
  LVieV   : Boolean;
begin
  // Verify id exist
    if Not FileExists('chat.txt') then
      Exit;

  // Open Files
    AssignFile(LArchi,'chat.txt');
    Reset(LArchi);
    while Not Eof(LArchi) do
      Begin
        // Read
          Readln(LArchi,LCad);

        // Init
          LPos := 0;
          LErr := False;
          LNom := '';
          LCom := '';
          LFot := '';
          LVie := '';
          LFec := '';
          LMes := '';

        // Recorrido
          For La := 1 to Length(LCad) do
            Begin
              if LCad[La] = ',' then
                Inc(LPos)
              Else
                Begin
                  case LPos of
                    0 : LNom := LNom+LCad[La];
                    1 : LCom := LCom+LCad[La];
                    2 : LFot := LFot+LCad[La];
                    3 : LVie := LVie+LCad[La];
                    4 : LFec := LFec+LCad[La];
                    5 : LMes := LMes+LCad[La];
                  end;
                End;
            End;

        // Validation
          if (LPos <> 5) then
            LErr := True;
          if (LVie.ToUpper <> 'TRUE') and (LVie.ToUpper <> 'FALSE') then
            LErr := True
          Else
            LVieV := LVie.ToUpper <> 'TRUE';
          Try
            LFecV := StrToDateTime(LFec);
            LMesV := StrToInt(LMes);
          Except
            LErr := True;
          End;
          if Not FileExists(LFot) then
            LErr := True;

        // Save To Array
          if Not LErr then
            AddBox(LNom,LCom,LFot,LVieV,LFecV,LMesV);
      End;
      AddBox('Raul Ontiveros','Hello Mekashron. Greetings from Bolivia','Images\raul.jpg',False,Now,100);

  // Close file
    CloseFile(LArchi);
end;

end.
