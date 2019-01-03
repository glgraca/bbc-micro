   10 REM MANDELBROT
   20 MODE 2
   30 DX=6/160 
   40 DY=6/256
   50 X=-3
   60 Y=-3
   70FOR I%=0 TO 1280 STEP 8
   80FOR J%=0 TO 1024 STEP 4
   90C%=FNMANDEL(X,Y,3)
  100 GCOL 0,C%
  110 PLOT 69, I%, J%
  120Y=Y+DY
  130NEXT J%
  140 Y=-3
  150X=X+DX
  160NEXT I%
  170END
  180DEF FNMANDEL(X,Y,P)
  190LOCAL C%
  200C%=0
  210LOCAL R,I,S,D,NR,NI,PP
  220 PP=0.5*P
  230REPEAT
  240 T=P*FNATAN2(I,R) 
  250S=R*R+I*I
  260IF S<>0 THEN D=S^PP ELSE D=0 
  270NR=D*COS(T)+X
  280NI=D*SIN(T)+Y
  290R=NR
  300I=NI
  310C%=C%+1
  320 UNTIL S>4 OR C%>50
  330 IF C%>50 THEN C%=0 ELSE C%=1+C% MOD 7  
  340=C%
  350DEF FNATAN2(Y,X)
  360LOCAL V
  370 IF X=0 THEN =SGN(Y)*PI/2 
  380LOCAL A
  390A=ATN(Y/X)
  400IF X>0 THEN V=A ELSE IF Y>0 THEN V=A+PI ELSE V=A-PI
  410=V