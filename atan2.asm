   10 DIM mc% 1000
   20 FOR pass% = 0 TO 2 STEP 2
   30 P% = mc% 
   40 [OPT pass%
   50 .adiv   JMP &A6AD
   60 .apack  JMP &A38D
   70 .aplus  JMP &A500
   80 .asign  JMP &A1DA
   90 .atn    JMP &A90A
  100 .aunp   JMP &A3B5
  110 .bcopya JMP &A21E
  120 .aplusb JMP &A505
  130 \constants
  140 .pluspi OPT FNEQUF(PI)
  150 .minuspi OPT FNEQUF(-PI)
  160 .minushalfpi OPT FNEQUF(-PI/2)
  170 .halfpi OPT FNEQUF(PI/2)
  180 .ATAN2
  190 OPT FNMOVF(&4B4,&50) \Copy address of Z to &50,&51
  200 OPT FNMOVF(&4B0,&52) \Copy address of X to &52,&53
  210 OPT FNMOVF(&4B2,&54) \Copy address of Y to &54,&55
  220 OPT FNMOVW(&52,&4B) \Load X
  230 JSR aunp
  240 JSR asign
  250 STA &60
  260 OPT FNMOVW(&54,&4B) \Load Y
  270 JSR aunp
  280 JSR asign
  290 STA &61
  300 LDA &60
  310 BNE arctan \X!=0
  320 LDY #&0
  330 LDX #&5
  340 LDA &61
  350 BPL dohalfpi \Y>0
  360.dominushalfpi \Y<0
  370 LDA minushalfpi,Y
  380 STA (&50),Y
  390 INY
  400 DEX
  410 BNE dominushalfpi
  420 RTS
  430 .dohalfpi \Y>0
  440 LDA halfpi,Y
  450 STA (&50),Y
  460 INY
  470 DEX
  480 BNE dohalfpi
  490 RTS
  500 .arctan \X!=0
  510 OPT FNMOVW(&52,&4B) \point to x
  520 JSR aunp \fwa=x
  530 OPT FNMOVW(&54,&4B) \point to y
  540 JSR adiv \fwa=y/x
  550 JSR atn  \fwa=atn(y/x)
  560 LDA &60
  570 BPL setz \x>=0
  580 JSR bcopya
  590 LDA &61
  600 BPL addpi \y>=0
  610.subpi
  620 OPT FNSETW(minuspi, &4B)
  630 JMP doadd
  640.addpi
  650 OPT FNSETW(pluspi, &4B)
  660.doadd
  670 JSR aunp
  680 JSR aplusb
  690.setz
  700 OPT FNMOVW(&50,&4B)
  710 JSR apack
  720 RTS:]
  730 NEXT pass%
  740 X=-1
  750 Y=1
  760 CALL ATAN2
  770 PRINT Z
  780 END
  790 DEF FNEQUF(Z)
  800 I% = &3 + ?&4B4 + &100*?&4B5
  810 FOR J% = &1 TO &5
  820 ?P% = ?I%
  830 P% = P% + &1
  840 I% = I% + &1
  850 NEXT
  860 =pass%
  870 DEF FNMOVW(F%,T%)
  880 [
  890 OPT pass%
  900 LDA F%
  910 STA T%
  920 LDA F%+&1
  930 STA T%+&1
  940 ]
  950 =pass%
  960 DEF FNSETW(V%,T%)
  970 [
  980 OPT pass%
  990 LDA #V% MOD &100
 1000 STA T%
 1010 LDA #V% DIV &100
 1020 STA T%+&1
 1030 ]
 1040 =pass%
 1050 DEF FNMOVF(F%,T%)
 1060 [
 1070 OPT pass%
 1080 CLC
 1090 LDA F%
 1100 ADC #&3
 1110 STA T%
 1120 LDA F%+&1
 1130 ADC #&0
 1140 STA T%+&1
 1150 ]
 1160 =pass%
