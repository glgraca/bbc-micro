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
  190  \Copy address of Z to &50,&51
  200  CLC
  210 LDA &4B4
  220 ADC #&3
  230 STA &50
  240 LDA &4B5
  250 ADC #&0
  260 STA &51
  270 \Copy address of X to &52, &53
  280 CLC
  290 LDA &4B0
  300 ADC #&3
  310 STA &52
  320 LDA &4B1
  330 ADC #&0
  340 STA &53
  350 \Copy address of Y to &54, &55
  360 CLC
  370 LDA &4B2
  380 ADC #&3
  390 STA &54
  400 LDA &4B3
  410 ADC #&0
  420 STA &55
  430 \Load X
  440 OPT FNMOVW(&52,&4B)
  450 JSR aunp
  460 JSR asign
  470 STA &60
  480 \Load Y
  490 OPT FNMOVW(&54,&4B)
  500 JSR aunp
  510 JSR asign
  520 STA &61
  530 LDA &60
  540 BNE arctan \X!=0
  550 LDY #&0
  560 LDX #&5
  570 LDA &61
  580 BPL dohalfpi \Y>0
  590.dominushalfpi \Y<0
  600 LDA minushalfpi,Y
  610 STA (&50),Y
  620 INY
  630 DEX
  640 BNE dominushalfpi
  650 RTS
  660 .dohalfpi \Y>0
  670 LDA halfpi,Y
  680 STA (&50),Y
  690 INY
  700 DEX
  710 BNE dohalfpi
  720 RTS
  730 .arctan \X!=0
  740 OPT FNMOVW(&52,&4B) \point to x
  750 JSR aunp \fwa=x
  760 OPT FNMOVW(&54,&4B) \point to y
  770 JSR adiv \fwa=y/x
  780 JSR atn  \fwa=atn(y/x)
  790 LDA &60
  800 BPL setz \x>=0
  810 JSR bcopya
  820 LDA &61
  830 BPL addpi \y>=0
  840.subpi
  850 LDA #minuspi MOD &100
  860 STA &4B
  870 LDA #minuspi DIV &100
  880 STA &4C
  890 JMP doadd
  900.addpi
  910 LDA #pluspi MOD &100
  920 STA &4B
  930 LDA #pluspi DIV &100
  940 STA &4C
  950.doadd
  960 JSR aunp
  970 JSR aplusb
  980.setz
  990 OPT FNMOVW(&50,&4B)
 1000 JSR apack
 1010 RTS:]
 1020 NEXT pass%
 1030 X=-1
 1040 Y=1
 1050 CALL ATAN2
 1060 PRINT Z
 1070 END
 1080 DEF FNEQUF(Z)
 1090 I% = &3 + ?&4B4 + &100*?&4B5
 1100 FOR J% = &1 TO &5
 1110 ?P% = ?I%
 1120 P% = P% + &1
 1130 I% = I% + &1
 1140 NEXT
 1150 =pass%
 1160 DEF FNMOVW(F%,T%)
 1170 [
 1180 OPT pass%
 1190 LDA F%
 1200 STA T%
 1210 LDA F%+&1
 1220 STA T%+&1
 1230 ]
 1240 =pass%
