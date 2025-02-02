' --- LOAD PLAYER SHAPES AND GENERAL ASSETS ---

' USED VIDEO PAGES:
'
'     0 - VISIBLE VIDEO PAGE
'     1 - MAIN FRAME BUFFER
'  2-20 - STAGE AND ANIMATIONS
' 21-24 - TEMPORARY THINGS
' 25-28 - PLAYER 1 SHAPES
' 29-32 - PLAYER 2 SHAPES
'    33 - GENERAL OBJECTS 2
'    34 - PLAYERS COLLISION (FOR ENEMY ATTACKS)
'    35 - PLAYER 1 ATTACKS
'    36 - PLAYER 2 ATTACKS
'    37 - FONTS
'    38 - GENERAL OBJECTS

' LOAD GENERAL ASSETS

SUB LoadAssets
 PAGE WRITE 37: CLS: LOAD PNG ".\IMAGES\OBJECTS\FONTS.PNG",,,1
 PAGE WRITE 38: CLS: LOAD PNG ".\IMAGES\OBJECTS\OBJECTS.PNG",,,1
 PAGE WRITE 33: CLS: LOAD PNG ".\IMAGES\OBJECTS\OBJECTS_2.PNG",,,1
END SUB


' LOAD PLAYER'S SHAPE PAGES "WHO" (1=GUY,2=CODY,3=HAGGAR) TO PLAYER "PL" (1-2)

SUB LoadPlayer(Who,PL)
 LOCAL P
 P=(PL-1)*4
 SELECT CASE Who
  'GUY
  CASE 1:
   PAGE WRITE 25+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - GUY\GGRAPJUMP.PNG",,,1
   PAGE WRITE 26+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - GUY\GSPECHURT.PNG",,,1
   PAGE WRITE 27+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - GUY\GPUNCH.PNG",,,1
   PAGE WRITE 28+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - GUY\GWALKING.PNG",,,1
  'CODY
  CASE 2:
   PAGE WRITE 25+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - CODY\CGRAPJUMP.PNG",,,1
   PAGE WRITE 26+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - CODY\CSPECHURT.PNG",,,1
   PAGE WRITE 27+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - CODY\CPUNCH.PNG",,,1
   PAGE WRITE 28+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - CODY\CWALKING.PNG",,,1
  'HAGGAR
  CASE 3:
   PAGE WRITE 25+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - HAGGAR\HGRAPJUMP.PNG",,,1
   PAGE WRITE 26+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - HAGGAR\HSPECHURT.PNG",,,1
   PAGE WRITE 27+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - HAGGAR\HPUNCH.PNG",,,1
   PAGE WRITE 28+P: CLS: LOAD PNG ".\IMAGES\MAIN CHAR - HAGGAR\HWALKING.PNG",,,1
 END SELECT
END SUB
