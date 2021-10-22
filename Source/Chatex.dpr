program Chatex;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {FMain},
  Boxes in 'Class\Boxes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
