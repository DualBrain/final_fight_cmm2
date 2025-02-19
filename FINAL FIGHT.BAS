' *****************************************************
' *                                                   *
' *            FINAL FIGHT CMM2 EDITION               *
' *     REPROGRAMMED BY MAURO XAVIER (MXN) - 2021     *
' *                                                   *
' * YOU CAN USE THIS PROGRAM AS YOU WISH, WITHOUT ANY *
' *  WARRANY OF ANY KIND, WHATEVER THE CIRCUNSTANCES  *
' *                                                   *
' *     THE GAME NAME, LOGO, GRAPHICS, MUSIC AND      *
' *      SOUND EFFECTS ARE PROPERTY OF CAPCOM(c)      *
' *                                                   *
' *****************************************************

'DETECT THE GENERATION OF THE COLOUR MAXIMITE 2
IF RIGHT$(MM.INFO$(DEVICE),2)="G2" THEN CMG2=1 ELSE CMG2=0

IF MM.INFO(VERSION)<5.07 THEN
 CLS
 PRINT "You need at least the firmware version 5.07 or better to run this program."
ENDIF

OPTION CONSOLE SCREEN

TIMER=0
DEBUG=0
VSYNC=0
NOINTRO=0

'STARTING ATTRIBUTES

VMODE  =384 'RESOLUTION
DEPTH  =  8 'COLOUR DEPTH
GLEVEL =  1 'GAME LEVEL
LIVES  =  2 'LIVES
EXLIFE =  0 'EXTRA LIFE ON THE FIRST 100000 PTS ONLY
BGM    =  1 'ENABLE BACKGROUND MUSIC
MAXPL  =  1 'START WITH ONE PLAYER

'HIGHSCORE TABLE --- IMPLEMENT THIS IN THE FUTURE
HIGHSCORE = 20000
PLHIGH$   = "NIN"

'ADJUST IF ISN'T CMM2 G2
IF CMG2=0 THEN VMODE=320: DEPTH=8

'REMOVE VSYNC WHEN IN 400 PIXELS WIDE MODE
IF VMODE=400 THEN VSYNC=0: DEPTH=8

'ENEMIES ROUTINES
#INCLUDE "ENEMY 1 - BRED - JAKE - DUG.INC"
#INCLUDE "ENEMY 2 - J - TWO P.INC"
#INCLUDE "ENEMY 3 - AXL - SLASH.INC"
#INCLUDE "ENEMY 4 - HOLLY WOOD - EL GADO.INC"
#INCLUDE "ENEMY 5 - HOLLY WOOD RED.INC"
#INCLUDE "ENEMY 6 - BILL - ORIBER - WONG.INC"
#INCLUDE "ENEMY 7 - POISON - ROXY.INC"
#INCLUDE "ENEMY 8 - ANDORE.INC"
#INCLUDE "ENEMY R1 - DAMND.INC"
'INCLUDE "ENEMY R2 - SODOM.INC"
'INCLUDE "ENEMY R3 - EDI E.INC"
'INCLUDE "ENEMY R4 - ROLENTO.INC"
'INCLUDE "ENEMY R5 - ABIGAIL.INC"
'INCLUDE "ENEMY R6 - BELGER.INC"
#INCLUDE "ENEMY RULES.INC"
#INCLUDE "ENEMY SHAPES.INC"
#INCLUDE "ENEMY SPAWN.INC"

'LOGO / GAME INTRO ANIMATION
#INCLUDE "GAME INTRO.INC"
#INCLUDE "GAME MENU.INC"
#INCLUDE "MXN LOGO.INC"

'LOAD FONTS, GENERAL OBJECTS AND PLAYERS
#INCLUDE "LOAD ASSETS.INC"

'FONT MANAGEMENT
#INCLUDE "FONTS.INC"

'RESOURCE MANAGEMENT
#INCLUDE "NES CLASSIC.INC"
#INCLUDE "SOUND MANAGER.INC"

'OBJECT MANAGEMENT
#INCLUDE "OBJECT MANAGER.INC"
#INCLUDE "OBJECT SHAPES.INC"

'PLAYER MANAGEMENT
#INCLUDE "PLAYER ANIMATION.INC"
#INCLUDE "PLAYER CONTROL.INC"
#INCLUDE "PLAYER SELECTION.INC"
#INCLUDE "PLAYER SHAPES.INC"

'GENERAL EVENT MANAGEMENT
#INCLUDE "GENERAL EVENTS.INC"

'LOAD ROUND / SECTIONS / DEFINITIONS
#INCLUDE "LOAD ROUND.INC"

'ROUND 1: SLUMS
#INCLUDE "ROUND 1 CUTSCENES.INC"
#INCLUDE "ROUND 1 EVENTS.INC"

'ROUND 2: SUBWAY
#INCLUDE "ROUND 2 CUTSCENES.INC"
#INCLUDE "ROUND 2 EVENTS.INC"

'BONUS 1: BREAK CAR
'INCLUDE "BONUS 1 CUTSCENES.INC"
'INCLUDE "BONUS 1 EVENTS.INC"

'ROUND 3: WEST SIDE
'INCLUDE "ROUND 3 CUTSCENES.INC"
'INCLUDE "ROUND 3 EVENTS.INC"

'ROUND 4: INDUSTRIAL AREA
'INCLUDE "ROUND 4 CUTSCENES.INC"
'INCLUDE "ROUND 4 EVENTS.INC"

'BONUS 2: BREAK GLASS
'INCLUDE "BONUS 2 CUTSCENES.INC"
'INCLUDE "BONUS 2 EVENTS.INC"

'ROUND 5: BAY AREA
'INCLUDE "ROUND 5 CUTSCENES.INC"
'INCLUDE "ROUND 5 EVENTS.INC"

'ROUND 6: UPTOWN
'INCLUDE "ROUND 6 CUTSCENES.INC"
'INCLUDE "ROUND 6 EVENTS.INC"

'GAME ENDING
'INCLUDE "GAME ENDING.INC"

'GAME CREDITS
'INCLUDE "GAME CREDITS.INC"

'CONTINUE / GAME OVER
'INCLUDE "GAME OVER.INC"

' CONSTANTS ---------------------------------------------------------------------------------------

' PLAYERS
CONST         GUY = 1,         CODY = 2,          HAGGAR = 3

' WEAPONS
CONST    KATANA = 150,      KNIFE = 160,          PIPE = 170

' ENEMIES 
CONST       BRED =  4,        JAKE =  5,            DUG =  6
CONST          J =  7,       TWO_P =  8
CONST        AXL =  9,       SLASH = 10
CONST HOLLY_WOOD = 11  ,   EL_GADO = 12, HOLLY_WOOD_RED = 13
CONST  BILL_BULL = 14,    G_ORIBER = 15,       WONG_WHO = 16
CONST     POISON = 17,        ROXY = 18
CONST  ANDORE_JR = 19,      ANDORE = 20,  ANDORE_FATHER = 21, ANDORE_UNCLE = 22, ANDORE_GRANPA = 23

' BOSSES
CONST      DAMND = 80, DAMND_INTRO = 81
CONST      SODOM = 82
CONST      EDI_E = 83
CONST    ROLENTO = 84
CONST    ABIGAIL = 85
CONST     BELGER = 86

' KEYBOARD CONSTANTS
CONST K_ESC=27,K_SPC=32,K_N2=50,K_N4=52,K_N6=54,K_N8=56,K_P=80,K_U=128,K_D=129,K_L=130,K_R=131
CONST K_Z=90,K_X=88

' PLAYER'S VARIABLES --------------------------------------------------------------------

' COORDINATES (CURRENT / PREVIOUS) / HIT SHAPE COORDINATES / SHOW HIT OBJECT
DIM X(3),Y(3),XANT(3),YANT(3),XH(3),YH(3),SHOWHIT(3)
' SPEED / FLIP SIDE / ANIMATION NUMBER / PREVIOUS FLIP SIDE / PREVIOUS ANIMATION
DIM SPD(3),SIDE(3),AN(3),SIDEANT(3),ANANT(3)
' ANIMATION SPEED AND DELAY / WAIT(?) / WAIT HIT / SCORE
DIM AniSpd(3),AniDelay(3),Wait(3),PLWait(3),SCORE(3)
' PLAYER HURTED? / COMBO WHEN PLAYER HURTED / WHO HURTED THE PLAYER?
DIM Phurted(3),HCombo(3),WhoE(3)
' IT'S MOVING TO LEFT OR RIGHT? / UP OR DOWN? / PILE DRIVING? / CARRING A WEAPON?
DIM MVLR(3), MVUD(3), PILE(3), WEAPON(3)
' PUNCH / KICK / COMBO / GRAPPLE / ITEM ON THE FLOOR ABOVE THE PLAYER / PLAYER BURNING?
DIM FreePunch(3),Punch(3),Kick(3),Combo(3),Grap(3),Item(3),Burned(3)
' JUMP / JUMP SPEED X,Y / SPECIAL ATTACK FLAG
DIM Jump(3),JumpX(3),JumpY(3),Special(3)
' ENERGY / ENEMY HIT AVATAR / HITTING SOMETHING? / GRAPPLED ENEMY NUMBER / LIFES
DIM Energy(3), Hit(3), Hitting(3), GrapE(3), PLIVE(3)
' TYPE OF PLAYER:
' 1-GUY / 2-CODY / 3-HAGGAR
DIM PlType(3)
' RESULT ON THE COLLISION PAGES
DIM COLLIDE(3)
' START PARAMETERS: SPECIAL / ATTACK / DEFENSE / JUMP / GRAPPLE / SPEED
DIM PS_SPC(3), PS_ATK(3), PS_DEF(3), PS_JMP(3), PS_GRP(3), PS_SPD(3)

' ENEMIES VARIABLES / ENTITIES / OBJECTS ------------------------------------------------

EMAX=24
'  4 TO  9 - ENEMIES (MAX  6 ENEMIES ON THE SCREEN)
' 10 TO 24 - OBJECTS (MAX 15 OBJECTS ON THE SCREEN)

' COORDINATES
DIM EX(EMAX)
' SIZE OF THE JUMP / JUMP SPEED / THROWED FLAG / WAIT HIT
DIM EY(EMAX),ESJMP(EMAX),ETR(EMAX),EWAIT(EMAX)
' SPEED / ENEMY FLIP SIDE / ENEMY TYPE / HIT COMBO COUNTER / WHO HITTED IT
DIM ESPD(EMAX),ESIDE(EMAX),EType(EMAX),ECOMBO(EMAX),EHIT(EMAX)
' SPEED X/Y / IS ENEMY WALKING BACK? (-1) / WALKING BACK HORIZONTALLY / SHADOW?
DIM ESPDX(EMAX),ESPDY(EMAX),EBACK(EMAX),EBACKX(EMAX),ESHAD(EMAX)
' ANIMATION NUMBER / ANIMATION SPEED / ANIMATION DELAY / ATTACK DISTANCE
DIM EAN(EMAX),EAniSpd(EMAX),EAniDelay(EMAX), EDIST(EMAX)
' CURRENT ENERGY / MAX ENERGY / MOVING FLAG / STATUS / FREEZE WHEN HURTED / ENEMY BURNING?
DIM EEnergy(EMAX),EEnMax(EMAX),EMV(EMAX),EHURT(EMAX),EBURNED(EMAX)
DIM STE(EMAX) AS INTEGER
' START PARAMETERS: SPEED / POWER / DEFENSE / SCORE POINTS / ITENS INSIDE BROKEN THINGS
DIM ES_SPD(EMAX),ES_POW(EMAX),ES_DEF(EMAX),ESCORE(EMAX),EITEM(EMAX)


' STAGE MAXIMUM SIZE
DIM SMXA,SMXB,SMYA,SMYB

' HIT EVENTS ----------------------------------------------------------------------------
HMAX=9
' COORDINATES
DIM XHit(HMAX),YHit(HMAX)
' ACTION SHAPE / END SHAPE / ANIMATION SPEED / SIDE HIT
DIM AHit(HMAX),EnHit(HMAX),SPHit(HMAX),SDHit(HMAX)

' STAGE EVENTS ------------------------------------------------------
DIM Event(50)

' INDEX OF ALL ENTITIES AND "Z-AXIS" --------------------------------
DIM Index(EMAX) AS INTEGER
' REAL Y AXIS TO USE IN COLLISIONS / PSEUDO Z-BUFFERING
DIM RealY(EMAX), ZBUF(EMAX)

RESTART:

'OPENNING MUST BE IN 16-BIT DEPTH
IF NOINTRO=0 THEN
 MODE 7,16
 GameLogic=0

 CLS RGB(255,255,255): PAUSE 10: MXN_Logo 
 LoadIntro
 GameIntro

 'DEFAULT PLAYERS
 PLType(1)=GUY
 PLType(2)=CODY


 SHOWTITLE:

 CLS

 GameLogic=0

 GameTitle

 'WAIT TO NOT LOAD ASSETS WHILE PLAYING THE MP3
 DO WHILE MM.INFO(SOUND)="MP3"
 LOOP

 LoadAssets

 PAGE WRITE 0
 PrintS(220,2,0,"CMM2 EDITION")

 PrintS(52,220,1,"#CAPCOM CO`,LTD` 1989 1990")
 PrintS(52,230,0," REPROGRAMMED BY MXN 2021")

 DO ' -- TITLE SCREEN -----------------------------------------------
  IF TIMER MOD 800<=400 THEN
   PrintS(110,190,0,"PRESS SPACE")
  ELSE
   BOX 76,190,200,8,,0,0
  ENDIF

  IF KEYDOWN(1)=32 THEN EXIT DO
 LOOP

 GameMenu

 IF YOP=0 THEN GOTO SHOWTITLE

ENDIF 'END OPENNING INTRO

'SET VIDEO MODE
IF CMG2 THEN
 SELECT CASE VMODE
  CASE 320: MODE  7,DEPTH: RX=  1: RXX=  0
  CASE 384: MODE 17,DEPTH: RX=1.2: RXX= 64
  CASE 400: MODE 13,DEPTH: RX=1.2: RXX= 64: FOR T=1 TO 38: PAGE RESIZE T,384,240: NEXT T
 END SELECT
ELSE
 MODE 7,8: RX=1: RXX=0
ENDIF

IF NOINTRO THEN Round=2 ELSE Round=1
Section=1: LoadRound

'ALWAYS NEED TO BE LOADED THE FIRST SECTION TO TEST ANY OTHER SECTION
IF NOINTRO THEN Round=2: Section=3: LoadRound

IF NOINTRO THEN
 IF ROUND=1 THEN OSDX=20
 MAXPL=1
 PLType(1)=GUY
 PLType(2)=HAGGAR
 'WEAPON(1)=PIPE
ENDIF

'LOAD GENERAL ASSETS
LoadAssets

PAGE WRITE 0
PrintS(MM.HRES\2-43,MM.VRES\2-8,0,"LOADING```")

FRAMEBUFFER CREATE 1600,1200
FRAMEBUFFER WRITE

IF CMG2=0 THEN
 LOAD BMP ".\IMAGES\MAIN FRAMEBUFFER.BMP"
ELSE
 'LOAD PNG IMAGE ON CMM2 G2 - FASTER
 LOAD PNG ".\IMAGES\MAIN FRAMEBUFFER.PNG"
ENDIF

'SECOND PLAYER OUT OF THE SCREEN IF ISN'T ENABLED
X(2)=-1000: RealY(2)=-1000: Energy(2)=-100


'START VARIABLES FOR EACH PLAYER
FOR PL=1 TO MAXPL

 SELECT CASE PlType(PL)
  CASE GUY:
   PS_SPC(PL)=1: PS_ATK(PL)=1: PS_DEF(PL)=1: PS_JMP(PL)=3: PS_GRP(PL)=2: PS_SPD(PL)=5
  CASE CODY:
   PS_SPC(PL)=2: PS_ATK(PL)=2: PS_DEF(PL)=2: PS_JMP(PL)=2: PS_GRP(PL)=2: PS_SPD(PL)=4
  CASE HAGGAR:
   PS_SPC(PL)=3: PS_ATK(PL)=3: PS_DEF(PL)=3: PS_JMP(PL)=1: PS_GRP(PL)=3: PS_SPD(PL)=4
 END SELECT

 'PLAYER GAME LOGIC VARIABLES
 SPD(PL)=PS_SPD(PL)
 Grap(PL)=0: GrapE(PL)=0
 SIDE(PL)=4:Punch(PL)=0:Jump(PL)=0:JumpX(PL)=0
 Special(PL)=0: PLIVE(PL)=LIVES
 AniSpd(PL)=4:AniDelay(PL)=0:Wait(PL)=0:PHurted(PL)=0
 Energy(PL)=115: SCORE(PL)=0
 X(PL)=60-PL*20-(NOINTRO=0)*75:RealY(PL)=155+PL*40:Y(PL)=0
 TCTYPE(PL)=CtrlType(PL): PLIVE(PL)=LIVES
 CtrlType(PL)=-1

 LoadPlayer(PlType(PL),PL)

NEXT PL

PAGE WRITE 1

IF ROUND=1 THEN
 PLAY STOP
 PLAY MODFILE ".\SFX\SFX - ROUND 1.MOD",22050
ENDIF

GameLogic=1: GoNext=0: GoSection=0

IF NOINTRO=1 THEN
 IF Round=1 THEN
  PLAY_WAV "The Slums": OSDX=10
 ELSE
  OSDX=2210
 ENDIF
ELSE
 OSDX=2230
ENDIF

'CLEAR BUFFER FOR THE CLASSIC MINI CONTROLLER
FOR T=1 TO 2
 IF CtrlType(T)=1 THEN Classic_Mini_Read(CtrlExist(1))
NEXT T

TIMER=0
STIME=30: GTIME=0: GOGO=0: ANTSCROLL=Scroll

StageScrollEvent(0,0)


DO WHILE GameLogic=1

 IF OSDX<620 THEN PAGE WRITE 35: CLS RGB(0,0,0) ' CLEAR PLAYER 1 COLLISION PAGE
 PAGE WRITE 36: CLS RGB(0,0,0) ' CLEAR PLAYER 2 COLLISION PAGE

 PAGE WRITE 1 ' SET MAIN VIDEO PAGE - FRAMEBUFFER

 'GENERIC SWITCHER
 SB=(SB=0)
 IF SB=1 THEN SW=(SW=0): IF SW=1 THEN SWW=(SWW=0)

 'RESET WHICH SIDE THE SCREEN IS SCROLLING
 ScrSide=0
 PLSCR=0

' ** PLAYER'S LOGIC **

FOR PL=1 TO MAXPL ' --------------------------------------------------------------------------

 IF PLive(PL)<0 THEN EXIT FOR

 IF PLWAIT(PL)>0 THEN INC PLWAIT(PL),-1

 IF PLWAIT(PL)=0 THEN

 ' PLAYER'S LOGIC
 IF SIDEANT(PL)<>SIDE(PL) THEN Combo(PL)=0 'RESET COMBO ATTACK IF PLAYER CHANGE POSITION
 INC HCombo(PL),-1: if HCombo(PL)<0 then HCombo(PL)=0 'ENEMY COMBO

 ' PREVIOUS X,Y AND SIDE OF THE PLAYER
 XANT(PL)=X(PL):YANT(PL)=RealY(PL): SIDEANT(PL)=SIDE(PL)
 IF OSDX=0 THEN MV=0

 ' READ BUTTONS -------------------------------------------------------------------------

 IF OSDX=0 THEN KSHIFT=0: KCTRL=0: KALT=0

 ' READ BUTTONS FROM THE CONTROLLERS
 SELECT CASE CtrlType(PL)
  CASE 0: Read_Keyboard_Buttons    'KEYBOARD SHIFT + CTRL + ALT
  CASE 1: Read_NES_Classic_Buttons 'CLASSIC NES/SNES MINI
  CASE 2: Read_Wii_Classic_Buttons 'WII CLASSIC CONTROLLER
 END SELECT

 ' END READING BUTTONS ------------------------------------------------------------------


 'IF THE PLAYER ISN'T GRAPPLING AN ENEMY, PUNCHING, JUMPING, KICKING OR IS HURTED THEN HE CAN MOVE
 'HAGGAR CAN GRAPPLE AND MOVE AT THE SAME TIME
 if (Punch(PL)<=2-(WEAPON(PL)>0) or Grap(PL)>0) and Jump(PL)=0 and Kick(PL)=0 and PHurted(PL)=0 then
  MVLR(PL)=0
  MVUD(PL)=0

  'CONTROL - MOVE: READ DIRECTIONALS / PAD

  'MOVE WHEN ENEMY GRAPPLED ONLY IF IT'S HAGGAR ELSE
  'DON'T MOVE IF GRAPPLING, PUNCHING OR KICKING
  SELECT CASE CtrlType(PL)
   CASE 0: Read_Keyboard_Directional    'KEYBOARD DIRECTIONAL KEYS
   CASE 1: Read_NES_Classic_Directional 'CLASSIC NES/SNES MINI
   CASE 2: Read_Wii_Classic_Directional 'WII CLASSIC CONTROLLER
  END SELECT

  'CONTROL - SPECIAL BUTTON
  IF ((KCTRL AND KSHIFT) OR KALT) THEN Player_Special_Button

  INC Hitting(PL),-1 'RESET HITTING STATUS
  IF Hitting(PL)<0 THEN Hitting(PL)=0: IF Grap(PL)=0 THEN Combo(PL)=0

  'CONTROL - PUNCH BUTTON
  IF KSHIFT THEN Player_Punch_Button

  'CONTROL - JUMP BUTTON
  IF KCTRL THEN Player_Jump_Button

 ELSE 'NOT PUNCHING, JUMPING OR KICKING -------------------------------------------------

  'GRAVITY
  IF (Jump(PL)>1 AND Jump(PL)<99) or (PHurted(PL)>2 and PHurted(PL)<=15) THEN
   INC X(PL),JumpX(PL): INC JumpY(PL)
  ELSE
   INC JumpY(PL),2
  ENDIF

  INC Y(PL),JumpY(PL)
 
  'GET UP FASTER IF HURTED WHEN PRESSING BUTTONS
  IF (PHurted(PL)=8 OR Phurted(PL)=9) THEN
   IF MVUD(PL)=0 AND (KSHIFT OR KCTRL OR KALT) THEN MVUD(PL)=1: INC AniDelay(PL),3
   IF NOT(KSHIFT OR KCTRL OR KALT) THEN MVUD(PL)=0 
  ENDIF

  'CUT PLAYER MOVES WHEN HURTED
  IF PHurted(PL)>0 THEN Combo(PL)=0: Punch(PL)=0: Grap(PL)=0: GrapE(PL)=0
  
 ENDIF 
 'END OF CONTROL: ISN'T GRAPPLE AN ENEMY, PUNCH, JUMP, KICK OR IS HURTED ----------------


 ' FIX TO NOT DO TURBO PUNCH
 FreePunch(PL)=1
 IF KSHIFT THEN FreePunch(PL)=0

 IF KEYDOWN(1)=K_ESC THEN ExitGame

 'VERTICAL LIMIT
 IF RealY(PL)<SMYA THEN RealY(PL)=SMYA
 IF RealY(PL)>SMYB THEN RealY(PL)=SMYB
 IF Y(PL)>0 THEN
  Y(PL)=0
  'RESET PILE DRIVER WHEN TOUCH THE GROUND AND HURT THE ENEMY
  IF AN(PL)=32 AND PlType(PL)=HAGGAR THEN
   T=GrapE(PL): SHAKE=10
   INC EEnergy(T),-EEnergy(T)\2-10+ES_DEF(T): Jump(PL)=36: AniDelay(PL)=999
   INC Score(PL),1000
   STE(T)=60
   ESPDX(T)=(SIDE(PL)=4)*6-(SIDE(PL)=5)*6: RealY(T)=RealY(PL)
   EAniDelay(T)=0:EAniSpd(T)=0: ESJMP(T)=-6
   Grap(PL)=0: GrapE(PL)=0: Kick(PL)=0: Punch(PL)=1
   'ENEMY DEAD ON PILE DRIVER?
   IF EEnergy(T)>-99 AND EEnergy(T)<0 THEN
    EAN(T)=21: STE(T)=52: ESJMP(T)=-10: EY(T)=0: INC RealY(T),4
    ESPDX(T)=(SIDE(PL)=4)*5-(SIDE(PL)=5)*5
    EEnergy(T)=-99: PLAY_SAMPLE 10+(EType(T)=POISON OR EType(T)=ROXY)*16,4,,255 'DEAD SOUND
    INC SCORE(EHIT(T)),ESCORE(T) 'INC PLAYER SCORE
   ENDIF
  ENDIF
 ENDIF

 'ALL SCREEN LIMITS ARE VALID ONLY WHEN IN NOT ROUND INTRODUCTIONS --------------------------------

 IF OSDX=0 THEN 

  IF ((PUNCH(PL)>0 AND MV=1) AND NOT(PlType(PL)=3 AND Grap(PL)>0 AND Grap(PL)<22)) OR (PlType(PL)=3 AND AN(PL)=24) THEN X(PL)=XANT(PL):RealY(PL)=YANT(PL)
  IF XANT(PL)=X(PL) AND YANT(PL)=RealY(PL) THEN MV=0

  'MAJOR HORIZONTAL SCREEN LIMIT 
  IF X(PL)< 20 THEN X(PL)= 20
  IF X(PL)> MM.HRES-20 THEN X(PL)=MM.HRES-20

  'CALL THE SCREEN SCROLL ONLY UNTIL REACH THE END OF THE ROUND
  IF X(PL)>MM.HRES-155 AND ScrX<LIMRD THEN   
   ScrSide=ABS(SPD(PL)): PLSCR=PL
   IF X(3-PL)<=35 AND MAXPL=2 THEN
    ScrSide=0
   ELSE
    IF ScrollLock=0 THEN INC X(PL),-ABS(SPD(PL))
   ENDIF
  ENDIF

  'CALL THE SCREEN SCROLL TO LEFT WHEN THE OPTION IS TURNED ON
  'IF X(PL)<90 AND ScrX>LIMLD AND LEFTLIM=1 THEN
  ' ScrSide=-ABS(SPD(PL)): PLSCR=PL
  ' IF X(3-PL)>=MM.HRES-35 AND MAXPL=2 THEN
  '  ScrSide=0
  ' ELSE
  '  IF ScrollLock=0 THEN INC X(PL),ABS(SPD(PL)) ELSE ScrollLock=-1
  ' ENDIF
  'ENDIF

  'STAGE / ROUND LIMIT
  IF X(PL)>R_SCR THEN X(PL)=R_SCR: ScrSide=0
  IF X(PL)<L_SCR THEN X(PL)=L_SCR: ScrSide=0
 
  IF MV=0 AND AN(PL)<13 AND Grap(PL)=0 THEN AN(PL)=0

 ENDIF 'END OF OSDX=0 -----------------------------------------------------------------------------

 'FIX PLAYER ANIMATION IF ENEMY WAS KILLED WHEN GRAPPLED OR THROWED
 IF GrapE(PL)>0 THEN
  IF EEnergy(GrapE(PL))<=0 THEN
   GrapE(PL)=0: Grap(PL)=0: Combo(PL)=0
   Punch(PL)=1: AniDelay(PL)=0: AniSpd(PL)=1: Kick(PL)=0
  ENDIF
 ENDIF

 PILE(PL)=(AN(PL)=32 AND PlType(PL)=HAGGAR)*15
 
 INC AniDelay(PL)
 IF AniDelay(PL)>=AniSpd(PL) THEN
  AniDelay(PL)=0
  if MV=1 then INC AN(PL)

  'WALKING ANIMATION WHEN PLAYER ISN'T HAGGAR
  IF PlType(PL)<HAGGAR OR (PlType(PL)=HAGGAR AND Grap(PL)=0) THEN
   IF (AN(PL)>=0 AND AN(PL)<=12) THEN AniSpd(PL)=2
   IF AN(PL)>12 THEN AN(PL)=1
   IF Grap(PL)>0 THEN AN(PL)=Grap(PL)
  ELSEIF PlType(PL)=HAGGAR AND Grap(PL)>0 AND Grap(PL)<22 THEN 'IF IT'S HAGGAR AND HAVE GRAPPLED AN ENEMY
   IF (AN(PL)>=51 AND AN(PL)<=62) THEN AniSpd(PL)=2
   IF AN(PL)<51 THEN AN(PL)=51
   IF AN(PL)>62 THEN AN(PL)=51
  ENDIF

  'GET THE COORDINATES TO SET THE HIT SHAPE POSITION
  IF PHurted(PL)>0 THEN PutPlayer(X(PL),RealY(PL)+Y(PL),AN(PL),SIDE(PL),PlType(PL),PL,-1)
  PlayerAnimation(PL)
 ENDIF
 FixPlayerAnimation(PL)

 ENDIF ' END OF THE PLAYER WAIT ANIMATION FOR HITS --------------------------------------

 ' INSERT PLAYER COLLISION
 PutPlayer(X(PL),RealY(PL)+Y(PL)+PILE(PL),AN(PL),SIDE(PL),PlType(PL),PL,0)

 ' RESET COLLISION WITH ITEMS ABOVE THE PLAYER
 ITEM(PL)=0

' KEEP MINIMUM PLAYER ENERGY
 IF Energy(PL)<0 THEN Energy(PL)=0

NEXT PL '-------------------------------------------------------------------------------------

' DRAW THE COLLISION BOXES ON THE THROWED ENEMIES ---------------------------------------
 FOR TT=4 TO 9
  IF STE(TT)>0 AND ETR(TT)>0 THEN PutEnemy(EX(TT),RealY(TT)+EY(TT),EAN(TT),ESide(TT),EType(TT),TT,2) 
 NEXT TT

 IF OSDX=700 THEN PAGE WRITE 35: CLS &HFF0000

 ' CONTROL, COUNT AND GET INDEX OF ALL ENTITIES (ENEMIES AND OBJECTS) -------------------
 CNTE=0
 FOR TT=4 TO 9
  IF STE(TT)>0 THEN ControlEnemy(TT): INC CNTE
 NEXT TT
 CNTO=0
 FOR TT=10 TO EMAX
  IF STE(TT)>0 THEN ControlObject(TT): INC CNTO
 NEXT TT

 'INSERT REAL Y TO Z-BUFFER
 MATH ADD RealY(),0,ZBUF()

 'SORT SHAPES
 SORT ZBUF(),Index()

 PAGE WRITE 34: CLS RGB(0,0,0) ' CLEAR GENERAL  COLLISION PAGE

 'DRAW ALL SHAPES
 FOR T=1 TO EMAX
  IND=Index(T)
  IF ZBUF(IND)=999 THEN CONTINUE FOR
  SELECT CASE IND
   CASE <4: 'PLAYERS
    IF Energy(IND)>=0 THEN
     PutPlayer(X(IND)+(AN(PL)=39)*SW*2,RealY(IND)+Y(IND)+PILE(IND),AN(IND),SIDE(IND),PlType(IND),IND,1-(PHurted(IND)>72)*SB)
    ENDIF
   CASE 4 TO 9: 'DRAW ACTIVE ENEMIES    
    IF STE(IND)>0 THEN
     C_A=EX(IND)+((EAN(IND)=21 OR EAN(IND)=22) AND STE(IND)<120)*SW*2
     C_B=RealY(IND)+EY(IND)+( (GrapE(1)=IND AND PILE(1)) OR (GrapE(2)=IND AND PILE(2)) )*15
     C_C=EAN(IND)+((EBURNED(IND)>0) AND (EAN(IND)=23))*(56+EBURNED(IND))
     PutEnemy(C_A,C_B,C_C,ESide(IND),EType(IND),IND,1)
    ENDIF
   CASE ELSE: 'OBJECTS
    IF STE(IND)>0 THEN IF EMV(IND)>=0 AND (1-(EMV(IND)=2)*SB) THEN PutObject(EX(IND),RealY(IND)+EY(IND),EAN(IND),ESIDE(IND))
  END SELECT
 NEXT T  

 ' INSERT HIT ANIMATION ABOVE ALL SHAPES
 HitAnimation

 ' SHAKE SCREEN
 IF SHAKE>0 THEN INC SHAKE,-1: PAGE SCROLL 1,0,SB

 FOR T=1 TO MAXPL
  ANANT(T)=AN(T) 
 NEXT T

 ' CALL ROUND INTRO ROUTINE
 IF OSDX>0 AND OSDX<5000 THEN EXECUTE "Round_"+STR$(Round)+"_Cutscenes(0)"  'STARTING
 IF OSDX>5000            THEN EXECUTE "Round_"+STR$(Round)+"_Cutscenes(1)"  'ENDING

 ' LOAD NEXT SECTION AND LOAD OTHER PARTS
 IF GoSection THEN
  PAGE WRITE 0: CLS 0
  GoSection=0: LoadRound: OSDX=2210
  EXECUTE "Round_"+STR$(Round)+"_Cutscenes(0)"  'STARTING NEW SECTION
 ENDIF

 ' LOAD NEXT ROUND RESOURCES
 IF GoNext THEN
  IF VMODE<400 THEN
   PAGE COPY 1 TO 0,B
  ELSE
   PAGE WRITE 0: BLIT 0,0,8,30,400,300,1,0: PAGE WRITE 1
  ENDIF
  GoNext=0: LoadRound: LoadAssets: OSDX=2210
  EXECUTE "Round_"+STR$(Round)+"_Cutscenes(0)"  'STARTING NEW STAGE
 ENDIF

 ' ONLY USED FOR THE SLUMS GALLERY
 IF Round=99 THEN
  IF Section=2 THEN
   T=RND*9000
   SELECT CASE TIMER MOD 12000
    CASE T TO T+1000, 3000 TO 4000, 7001 TO 8000: 
     IF SB THEN PAGE WRITE 1: BOX AND_PIXELS 0,0,320*RX,240,RGB(140,180,255)
    CASE 4001 TO 9000:
     PAGE WRITE 1: BOX AND_PIXELS 0,0,320*RX,240,RGB(140,180,255)
   END SELECT
  ENDIF
 ENDIF

 ' OSD --------------------------------------------------------------

 ' TIMER
 ANTTIME=GTIME 

 PutObject(MM.HRES\2,26-OSDP,99,4) 

 GTIME=((STIME+1)*10000-TIMER)\10000

 PrintFM(MM.HRES\2-13,27-OSDP,1,FORMAT$(GTIME,"%2.0f"))
 PrintFS(MM.HRES\2-15, 1-OSDP,0,FORMAT$(HIGHSCORE,"%7.0f"))
 PrintS (MM.HRES\2-47, 1-OSDP,0,PLHIGH$)

 ' GO! GO! GO!
 INC GOGO
 IF GOGO>250 AND ScrX<LIMRD-15 AND OSDX=0 AND LEFTLIM=0 THEN 
  GOGO=0
  IF ANTSCROLL=Scroll THEN InsertHit(MM.HRES-30,130,3)
  ANTSCROLL=Scroll
 ENDIF 

 ' HIT INFO / AVATAR / LIFES / HEALTH ---------------------------------------------------
 FOR PL=1 TO MAXPL

  II=(OSDP)*(-(PL=1)+(PL=2))

  ' SHOW HIT INFO
  I=(MM.HRES\2+15)*(PL-1)
  IF Hit(PL)>0 THEN
   IF EEnergy(Hit(PL))>0 THEN 'SHOW HEALTH IF ISN'T IN "DEADING" STATE  
    
    T=EEnMax(Hit(PL)): IF T>110 THEN T=110
    RBOX 25+I+II,36,T*RX+2,7,2,&HFFFFFF,&HFF0000  
    T=EEnergy(Hit(PL)): IF T>110 THEN T=110
    SELECT CASE EEnergy(Hit(PL))
     CASE >=300: EE=RGB(155,255,255)
     CASE >=260: EE=RGB(155,155,255)
     CASE >=210: EE=RGB(100,100,255)
     CASE >=160: EE=RGB(125,255,125)
     CASE >=110: EE=RGB( 75,255, 75)
     CASE ELSE : EE=RGB(255,255,  0)
    END SELECT
    IF T>0 THEN BOX 26+I,37,T*RX,5,0,,EE
    PutEnemy(30+I+II,43,99,4,EType(Hit(PL)),,1) 

   ELSE 'IF IT'S "DEADING" - SHOWS THE FLASHING HIT INFO
   
    IF STE(Hit(PL))>0 THEN  'FLASH FOR A WHILE

     IF SB THEN 
      T=EEnMax(Hit(PL)): IF T>110 THEN T=110
      Rbox 25+I+II,36,T*RX+2,7,2,&HFFFFFF,&HFF0000  
      PutEnemy(30+I+II,43,99,4,EType(Hit(PL)),,1) 
     ELSE
      LINE 9+I,28,22+I+II,41,1,&HFF0000
      LINE 9+I,41,22+I+II,28,1,&HFF0000
     ENDIF 

    ENDIF 'END FLASH

   ENDIF 'END "DEADING" VERIFICATION

  ELSE 'IF HIT IS NEGATIVE, THEN IT'S AN OBJECT

   'SHOW OBJECT AVATAR AND NAME
   IF SHOWHIT(PL)>0 THEN
    INC SHOWHIT(PL),-1
    PutObject(16+I+II,43,Hit(PL),4)
    PrintS(25+(PL-1)*(MM.HRES\2+16)+I+II,27,0,AVA$)
    'FLASHING AVATAR OF THE DESTRUCTABLE OBJECTS
    IF SB AND Hit(PL)>=-100 THEN
     LINE 9+I,28,22+I+II,41,1,&HFF0000
     LINE 9+I,41,22+I+II,28,1,&HFF0000
    ENDIF
   ENDIF

  ENDIF 'END SHOW HIT INFO

  'AVATAR AND HEALTH
  PutPlayer(32+(MM.HRES\2+15)*(PL-1)+II,26,99,4,PlType(PL),PL,1) 
  Rbox 25+(MM.HRES\2+15)*(PL-1)+II,19,112*RX,7,2,&HFFFFFF,&HFF0000
  T=Energy(PL): IF T>110 THEN T=110
  box  26+(MM.HRES\2+15)*(PL-1)+II,20,T*RX,5,0,,&HFFFF00
  'LIFES
  PrintS(55+(PL-1)*(MM.HRES\2+18)+II,10,1,"=")
  PrintS(65+(PL-1)*(MM.HRES\2+18)+II,10,1,STR$(PLIVE(PL)))
  PrintFS(81+(PL-1)*(MM.HRES\2+16)+II,10,0,FORMAT$(SCORE(PL),"%7.0f"))

 NEXT PL ' END OF HIT INFO / AVATAR / LIFES / HEALTH -------------------------------------

 '? scrx
 '? LIMRD

  ' DEBUG INFO ONLY
 IF DEBUG=1 THEN
  PRINTS(9,50,0,"FPS:"+STR$(FPS))
  PRINTS(9,59,0,"ENE:"+STR$(CNTE))
  PRINTS(9,68,0,"OBJ:"+STR$(CNTO))
  PRINTS(9,77,0,"SCR:"+STR$(ScrX))
 ENDIF

 FPS=1000\(TIMER-TI):TI=TIMER
 DO WHILE PAUSETIMER>TIMER
 LOOP

 IF OSDX<2210 OR OSDX>5000 THEN
  IF VSYNC=1 THEN
   PAGE COPY 1 TO 0,B
  ELSE
   IF VMODE<400 THEN
    PAGE COPY 1 TO 0,I
   ELSE
    PAGE WRITE 0: BLIT 0,0,8,30,400,300,1,0: PAGE WRITE 1
   ENDIF
  ENDIF
 ELSE IF OSDX=2210 THEN 'FADE IN WHEN STARTING A STAGE
  FadeIn
  PAGE WRITE 1
 ENDIF

 IF DEPTH=16 THEN
  PAUSETIMER=TIMER+26.66 '37.5 FPS - HALF 75 Hz - UNSTABLE FRAMERATE
 ELSE
  PAUSETIMER=TIMER+33.3333 '30 FPS
 ENDIF

 StageScrollEvent(ScrSide,PLSCR)

 'IF SB THEN INC TESTA
 'IF TESTA>57 THEN TESTA=50
 'IF TESTA<50 THEN TESTA=57
 'PutObject(200,230,TESTA,4)
 'TESTA=1
 'PutEnemy(200,230,TESTA,4,ANDORE,,1)

 'PAUSE 100
 
LOOP

' BYE BYE!
SUB ExitGame
 PAGE WRITE 0
 FONT #1
 PLAY STOP
 END
END SUB

