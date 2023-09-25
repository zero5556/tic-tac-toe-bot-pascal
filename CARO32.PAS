{code write by zero5556}
uses crt;
const max=3;
      max_ply=8;
      INF=9999;
var x,y:byte;
    m,ec:longint;
    kt:boolean;
    key:char;
    board:array[1..max,1..max] of char;

procedure enter;
begin
kt:=true;
x:=1; y:=1;
textcolor(white);
gotoxy(1,5);
writeln('------');
writeln('move the cursor with the a,s,w,d keys on your computer and');
writeln('press enter to move.');
gotoxy(x,y);
repeat
key:=readkey;

case key of
#97:if x>1 then dec(x) else x:=max;
#119:if y>1 then dec(y) else y:=max;
#100:if x<max then inc(x) else x:=1;
#115:if y<max then inc(y) else y:=1;
#113:halt;
#81:halt;
end;
gotoxy(x,y);
until key=#13;

if board[x,y]<>' ' then
begin
gotoxy(1,24);
write('error #2: this location already has X or O, press enter to exit:');
readln;
halt
end;

textcolor(white);
board[x,y]:='X';
gotoxy(x,y);
write(board[x,y]);
end;

function checkwin(p:char):boolean;
var x:byte;
begin
for x:=1 to max do
begin
 if (board[x,1]=p) and (board[x,2]=p) and (board[x,3]=p) then
  begin
   checkwin:=true;
   exit;
  end;

 if (board[1,x]=p) and (board[2,x]=p) and (board[3,x]=p) then
  begin
   checkwin:=true;
   exit;
  end;
end;

if (board[1,1]=p) and (board[2,2]=p) and (board[3,3]=p) then
 begin
  checkwin:=true;
  exit;
 end;

if (board[1,3]=p) and (board[2,2]=p) and (board[3,1]=p) then
 begin
  checkwin:=true;
  exit;
 end;
checkwin:=false;
end;

function evaluated:integer;
var point,i,j:integer;
begin
 if checkwin('X') then evaluated:=1
 else if checkwin('O') then evaluated:=-1
 else evaluated:=0;
end;

function draw:boolean;
var x,y:integer;
begin
for x:=1 to max do
 for y:=1 to max do
 if board[x,y]=' ' then
  begin
   draw:=false;
   exit;
  end;
  draw:=true;
end;

function minimax(depth:byte;maxp:boolean):integer;
var score,v,i,j:integer;
begin
if depth=max_ply then
  minimax:=evaluated
else if draw then
 minimax:=0
else if checkwin('X') then minimax:=1
else if checkwin('O') then minimax:=-1
else if maxp then
 begin
  score:=-INF;
  for i:=1 to max do
   for j:=1 to max do
   if board[i,j]=' ' then
    begin
     board[i,j]:='X';
     v:=minimax(depth+1,false);
     if v>score then score:=v;
     board[i,j]:=' ';
    end;
   minimax:=score;
 end
 else
 begin
  score:=INF;
  for i:=1 to max do
   for j:=1 to max do
   if board[i,j]=' ' then
    begin
     inc(ec);
     board[i,j]:='O';
     v:=minimax(depth+1,true);
     if v<score then score:=v;
     board[i,j]:=' ';
    end;
   minimax:=score;
 end;
end;

procedure computer;
var i,j,mx,my:byte;
    best,value:integer;
begin
ec:=0;
best:=INF;
for i:=1 to max do
 for j:=1 to max do
 if (board[i,j]=' ') then
  begin
   board[i,j]:='O';
   value:=minimax(0,true);
   board[i,j]:=' ';
   if value<best then
    begin
     best:=value;
     mx:=i;
     my:=j;
    end;
  end;

board[mx,my]:='O';
gotoxy(mx,my);
write(board[mx,my]);
gotoxy(1,4);
writeln('nodes:',ec,' eval:',best,' x:',mx,' y:',my);
end;

procedure map;
begin
textcolor(white);
for x:=1 to max do
begin
for y:= 1 to max do
write(board[x,y]); write('|');
writeln
end;
End;

procedure infor;
begin
clrscr;
writeln('code write by zero5556');
writeln('AI:Zero 2.0');
writeln('update: minimax algothirm');
readln;
clrscr;
end;

begin
clrscr;
infor;
fillchar(board,sizeof(board),' ');
map;
while true do
 begin
  if checkwin('O') then begin gotoxy(1,8); write('computer win'); break end;
  if checkwin('X') then begin gotoxy(1,8); write('player win'); break end;
  if draw then begin gotoxy(1,8); write('draw'); break end;
  enter;
  if checkwin('O') then begin gotoxy(1,8); write('computer win'); break end;
  if checkwin('X') then begin gotoxy(1,8); write('player win'); break end;
  if draw then begin gotoxy(1,8); write('draw'); break end;
  computer;
 end;
readln;
end.