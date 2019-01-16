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
  101 .bcopya JMP &A21E
  102 .aplusb JMP &A505
  110 \constants
  120 .pluspi OPT FNEQUF(PI)
  130 .minuspi OPT FNEQUF(-PI)
  140 .minushalfpi OPT FNEQUF(-PI/2)
  150 .halfpi OPT FNEQUF(PI/2)
  160 .ATAN2
  170  \Copy address of Z to &50,&51
  180  CLC
  190 LDA &4B4
  200 ADC #&3
  210 STA &50
  220 LDA &4B5
  230 ADC #&0
  240 STA &51
  250 \Copy address of X to &52, &53
  260 CLC
  270 LDA &4B0
  280 ADC #&3
  290 STA &52
  300 LDA &4B1
  310 ADC #&0
  320 STA &53
  330 \Copy address of Y to &54, &55
  340 CLC
  350 LDA &4B2
  360 ADC #&3
  370 STA &54
  380 LDA &4B3
  390 ADC #&0
  400 STA &55
  410 \Load X
  420 LDA &52
  430 STA &4B
  440 LDA &53
  450 STA &4C
  460 JSR aunp
  470 JSR asign
  480 STA &60
  490 \Load Y
  500 LDA &54
  510 STA &4B
  520 LDA &55
  530 STA &4C
  540 JSR aunp
  550 JSR asign
  560 STA &61
  570 LDA &60
  580 BNE arctan \X!=0
  590 LDY #&0
  600 LDX #&5
  610 LDA &61
  620 BPL dohalfpi \Y>0
  630.dominushalfpi \Y<0
  640 LDA minushalfpi,Y
  650 STA (&50),Y
  660 INY
  670 DEX
  680 BNE dominushalfpi
  690 RTS
  700 .dohalfpi \Y>0
  710 LDA halfpi,Y
  720 STA (&50),Y
  730 INY
  740 DEX
  750 BNE dohalfpi
  760 RTS
  770 .arctan \X!=0
  780 LDA &52
  790 STA &4B
  800 LDA &53
  810 STA &4C
  820 JSR aunp \fwa=x
  830 LDA &54
  840 STA &4B
  850 LDA &55
  860 STA &4C  \point to y
  870 JSR adiv \fwa=y/x
  880 JSR atn  \fwa=atn(y/x)
  890 LDA &60
  900 BPL setz \x>=0
  901 JSR bcopya
  910 LDA &61
  920 BPL addpi \y>=0
  930.subpi
  940 LDA #minuspi MOD &100
  950 STA &4B
  960 LDA #minuspi DIV &100
  970 STA &4C
  980 JMP doadd
  990.addpi
 1000 LDA #pluspi MOD &100
 1010 STA &4B
 1020 LDA #pluspi DIV &100
 1030 STA &4C
 1040.doadd
 1041 JSR aunp
 1050 JSR aplusb
 1051.setz
 1060 LDA &50
 1070 STA &4B
 1080 LDA &51
 1090 STA &4C
 1100 JSR apack
 1120 RTS:]
 1130 NEXT pass%
 1140 X=-1
 1150 Y=1
 1160 CALL ATAN2
 1170 PRINT Z
 1180 END
 1190 DEF FNEQUF(Z)
 1200 I% = &3 + ?&4B4 + &100*?&4B5
 1210 FOR J% = &1 TO &5
 1220 ?P% = ?I%
 1230 P% = P% + &1
 1240 I% = I% + &1
 1250 NEXT
 1260 = pass%
