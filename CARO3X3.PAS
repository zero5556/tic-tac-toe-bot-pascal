{code write by zero5556}
uses crt;
const max=3;
      max_ply=2;
var x,y,vtx,vty:byte;
    m,b,ply,ec:longint;
    pw,cw,kt:boolean;
    key:char;
    board:array[-3..max+3,-3..max+3] of integer;

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

if board[x,y]<>0 then
begin
gotoxy(1,24);
write('error #2: this location already has X or O, press enter to exit:');
readln;
halt
end;

textcolor(white);
board[x,y]:=1;
gotoxy(x,y);
write('X');
end;

function evaluated(depth,x,y:byte):integer;
var point:integer;
begin
point:=0;
if (depth mod 2<>0) then
begin
if board[x+1,y+1]+board[x+2,y+2]=-2 then point:=point+10;
if board[x+1,y+1]=-1 then point:=point+2;
if board[x+1,y-1]+board[x+2,y-2]=-2 then point:=point+10;
if board[x+1,y-1]=-1 then point:=point+2;
if board[x-1,y+1]+board[x+2,y+2]=-2 then point:=point+10;
if board[x-1,y+1]=-1 then point:=point+2;
if board[x-1,y-1]+board[x-2,y-2]=-2 then point:=point+10;
if board[x-1,y-1]=-1 then point:=point+2;
if board[x+1,y]+board[x+2,y]=-2 then point:=point+10;
if board[x+1,y]=-1 then point:=point+2;
if board[x-1,y]+board[x-2,y]=-2 then point:=point+10;
if board[x-1,y]=-1 then point:=point+2;
if board[x,y+1]+board[x,y+2]=-2 then point:=point+10;
if board[x,y+1]=-1 then point:=point+2;
if board[x,y-1]+board[x,y-2]=-2 then point:=point+10;
if board[x,y-1]=-1 then point:=point+2;

if board[x+1,y+1]+board[x+2,y+2]=2 then point:=point+8;
if board[x+1,y+1]=1 then point:=point+1;
if board[x+1,y-1]+board[x+2,y-2]=2 then point:=point+8;
if board[x+1,y-1]=1 then point:=point+1;
if board[x-1,y+1]+board[x+2,y+2]=2 then point:=point+8;
if board[x-1,y+1]=1 then point:=point+1;
if board[x-1,y-1]+board[x-2,y-2]=2 then point:=point+8;
if board[x-1,y-1]=1 then point:=point+1;
if board[x+1,y]+board[x+2,y]=2 then point:=point+8;
if board[x+1,y]=1 then point:=point+1;
if board[x-1,y]+board[x-2,y]=2 then point:=point+8;
if board[x-1,y]=1 then point:=point+1;
if board[x,y+1]+board[x,y+2]=2 then point:=point+8;
if board[x,y+1]=1 then point:=point+1;
if board[x,y-1]+board[x,y-2]=2 then point:=point+8;
if board[x,y-1]=1 then point:=point+1;
end
else
begin
if board[x+1,y+1]+board[x+2,y+2]=2 then point:=point+10;
if board[x+1,y+1]=1 then point:=point+2;
if board[x+1,y-1]+board[x+2,y-2]=2 then point:=point+10;
if board[x+1,y-1]=1 then point:=point+2;
if board[x-1,y+1]+board[x+2,y+2]=2 then point:=point+10;
if board[x-1,y+1]=1 then point:=point+2;
if board[x-1,y-1]+board[x-2,y-2]=2 then point:=point+10;
if board[x-1,y-1]=1 then point:=point+2;
if board[x+1,y]+board[x+2,y]=2 then point:=point+10;
if board[x+1,y]=1 then point:=point+2;
if board[x-1,y]+board[x-2,y]=2 then point:=point+10;
if board[x-1,y]=1 then point:=point+2;
if board[x,y+1]+board[x,y+2]=2 then point:=point+10;
if board[x,y+1]=1 then point:=point+2;
if board[x,y-1]+board[x,y-2]=2 then point:=point+10;
if board[x,y-1]=1 then point:=point+2;

if board[x+1,y+1]+board[x+2,y+2]=-2 then point:=point+8;
if board[x+1,y+1]=-1 then point:=point+1;
if board[x+1,y-1]+board[x+2,y-2]=-2 then point:=point+8;
if board[x+1,y-1]=-1 then point:=point+1;
if board[x-1,y+1]+board[x+2,y+2]=-2 then point:=point+8;
if board[x-1,y+1]=-1 then point:=point+1;
if board[x-1,y-1]+board[x-2,y-2]=-2 then point:=point+8;
if board[x-1,y-1]=-1 then point:=point+1;
if board[x+1,y]+board[x+2,y]=-2 then point:=point+8;
if board[x+1,y]=-1 then point:=point+1;
if board[x-1,y]+board[x-2,y]=-2 then point:=point+8;
if board[x-1,y]=-1 then point:=point+1;
if board[x,y+1]+board[x,y+2]=-2 then point:=point+8;
if board[x,y+1]=-1 then point:=point+1;
if board[x,y-1]+board[x,y-2]=-2 then point:=point+8;
if board[x,y-1]=-1 then point:=point+1;
end;
evaluated:=point;
end;

procedure checkwin;
var x,y:byte;
begin
cw:=false; pw:=false;
for x:=1 to max do
for y:=1 to max do
begin
if (board[x,y]+board[x+1,y+1]+board[x+2,y+2]=-3) or
 (board[x,y]+board[x+1,y-1]+board[x+2,y-2]=-3) or
 (board[x,y]+board[x+1,y+1]+board[x-2,y+2]=-3) or
 (board[x,y]+board[x-1,y-1]+board[x-2,y-2]=-3) or
 (board[x,y]+board[x+1,y]+board[x+2,y]=-3) or
 (board[x,y]+board[x-1,y]+board[x-2,y]=-3) or
 (board[x,y]+board[x,y+1]+board[x,y+2]=-3) or
 (board[x,y]+board[x,y-1]+board[x,y-2]=-3) then cw:=true;

if (board[x,y]+board[x+1,y+1]+board[x+2,y+2]=3) or
 (board[x,y]+board[x+1,y-1]+board[x+2,y-2]=3) or
 (board[x,y]+board[x+1,y+1]+board[x-2,y+2]=3) or
 (board[x,y]+board[x-1,y-1]+board[x-2,y-2]=3) or
 (board[x,y]+board[x+1,y]+board[x+2,y]=3) or
 (board[x,y]+board[x-1,y]+board[x-2,y]=3) or
 (board[x,y]+board[x,y+1]+board[x,y+2]=3) or
 (board[x,y]+board[x,y-1]+board[x,y-2]=3) then pw:=true;
end;
end;

function eval:integer;
var x,y:byte;
    s:integer;
begin
s:=0;
for x:=1 to max do
 for y:=1 to max do
 if board[x,y]=0 then
 s:=s+evaluated(max_ply,x,y);
eval:=s;
end;

procedure printmap;
var x,y:byte;
begin
for x:=1 to max do
begin
 for y:=1 to max do
 begin
  if board[x,y]=0 then write('.') else
  if board[x,y]=1 then write('X') else
  if board[x,y]=-1 then write('O');
 end;
 writeln;
end;
writeln(m);
end;

function draw:boolean;
var d,x,y:integer;
begin
d:=0;
for x:=1 to max do
 for y:=1 to max do
 if board[x,y]<>0 then inc(d);
if d=max*max then draw:=true else draw:=false;
end;

function search(alpha,beta:integer; depth:byte):integer;
var best,value,x,y,d:integer;
begin
{clrscr;
printmap;
delay(1000);}
if depth=0 then search:=eval else
 begin
  best:=-10000;
  for x:=1 to max do
   for y:=1 to max do
   begin
   if (board[x,y]=0) and (best<beta) then
    begin
     if best>alpha then alpha:=best;
     inc(ec);
     if (depth mod 2<>0) then board[x,y]:=-1 else board[x,y]:=1;
     inc(ply);
     checkwin;
     if cw or pw or draw then value:=5000-ply else
     value:=-search(-beta,-alpha,depth-1);
     board[x,y]:=0;
     dec(ply);
     if value>best then
      begin
        best:=value;
        if ply=0 then
         begin
          vtx:=x;
          vty:=y;
         end;
      end;
    end;
   end; {for y}
   search:=best;
 end;
end;

procedure computer;
begin
ec:=0; ply:=0;
m:=search(-10000,10000,max_ply);
if board[vtx,vty]=0 then board[vtx,vty]:=-1 else
begin gotoxy(1,8); write('AI error'); readln; halt end;
gotoxy(vtx,vty);
write('O');
gotoxy(1,4);
writeln('ply:',max_ply,' nodes:',ec,' eval:',m,' x:',vtx,' y:',vty);
end;

procedure map;
begin
textcolor(white);
for x:=1 to max do
begin
for y:= 1 to max do
write('.'); write('|');
writeln
end;
End;


begin
clrscr;
fillchar(board,sizeof(board),0); cw:=false; pw:=false;
map;
while true do
 begin
  checkwin;
  if cw then begin gotoxy(1,8); write('computer win'); break end;
  if pw then begin gotoxy(1,8); write('player win'); break end;
  if draw then begin gotoxy(1,8); write('draw'); break end;
  enter;
  checkwin;
  if cw then begin gotoxy(1,8); write('computer win'); break end;
  if pw then begin gotoxy(1,8); write('player win'); break end;
  if draw then begin gotoxy(1,8); write('draw'); break end;
  computer;
 end;
readln;
end.
