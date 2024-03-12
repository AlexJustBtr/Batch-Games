@echo off
title RPG Game
setlocal enabledelayedexpansion

:menu
cls
echo.
echo.
echo 0000   0000    000     //\\     000      0    00   00  000000                                  
echo 0   0  0   0  0   0   //\\     0   0   0  0   0 0 0 0  0                              
echo 0   0  0   0  0        //\\    0      0    0  0  0  0  0                             
echo 0000   0000   0  00   //\\     0  00  000000  0     0  0000                             
echo 0  0   0      0   0    //\\    0   0  0    0  0     0  0                             
echo 0   0  0       000    //\\      000   0    0  0     0  000000                                
echo.
echo.
echo 1) begin
echo 2) exit 
echo.
echo.
set /p c=Enter:

if "%c%" == "1" goto new
if "%c%" == "2" goto menu
goto menu

:new
set maxhp=100
set hp=100
set playerdmg=7
set playerxp=500
set xpneeded=50
set Level=1
set Goblinbodycount=0
set Elfbodycount=0
set spiderbodycount=0
set scorpionbodycount=0
set Yetibodycount=0
set money=10
set p=false
set p2=false
set Wkb=false
set wnc=false
set current=Fist
set current2=Fist
set WkbPurchased=false
set wncPurchased=false
set bombs=0
goto home

:home
cls

if "!Current!" == "Fist" set /a playerdmg=7
if "!Current!" == "KnuckleBusters" set /a playerdmg=12
if "!Current!" == "NunChucks" set /a playerdmg=17

if "!Current2!" == "Fist" set /a playerdmg+=7
if "!Current2!" == "KnuckleBusters" set /a playerdmg+=12
if "!Current2!" == "NunChucks" set /a playerdmg+=17

echo.
echo	Level:%Level%
echo	HP: %hp%		$%money%
echo	Damage: %playerdmg%		Weapon:	%current%, %Current2%
echo.
echo 1) Enter the wild
echo 2) Village
echo 3) Inventory
echo 4) Level Up
echo 5) Exit
echo.
set /p c=Enter:

if "!c!" == "1" goto Worlds
if "!c!" == "2" goto Village
if "!c!" == "3" goto Inventory
if "!c!" == "4" goto lvlup
if "!c!" == "5" goto menu
goto home

::## LEVEL UP ########################################
:lvlup
cls
echo.
echo	Hp:%maxhp%	Dmg:%playerdmg%
echo.
echo	Level:%Level%	Exp:%playerxp%/%xpneeded%
echo.
echo.
echo 1) Level Up
echo 2) Back
echo.
echo.
set /p c=Enter:

if "!c!" == "1" goto lvlup1


if "!c!" == "2" goto home

:lvlup1
if %playerxp% geq %xpneeded% (
    set /a Level+=1
    set /a maxhp+=5
    set /a playerdmg+=1
    set /a playerxp-=%xpneeded%
    set /a xpneeded+=50
)
goto lvlup
::## INVENTORY #######################################
:Inventory
cls
echo.
echo 1) Left Hand
echo 2) Right Hand
echo 3) Back
echo.
set /p c=Enter:

if "!c!" == "1" == goto leftInventory
if "!c!" == "2" == goto rightInventory
if "!c!" == "3" == goto home

:leftInventory
cls
echo Current weapon:    [%Current%]
echo.
echo Bombs: %bombs%
echo.
echo Weapons:
echo.
echo 1) Fist
if "!WkbPurchased!" == "true" echo 2) KnuckleBusters
if "!wncPurchased!" == "true" echo 3) NunChucks
echo.
echo.
echo Equip weapon
echo.
echo "b" to go back.
echo.
set /p c=Enter:
if "!c!" == "1" set Current=Fist
if "!c!" == "2" set Current=KnuckleBusters
if "!c!" == "3" set Current=NunChucks
if "!c!" == "b" goto home
echo.
pause
goto home

:rightInventory
cls
echo Current weapon:    [%Current2%]
echo.
echo Bombs: %bombs%
echo.
echo Weapons:
echo.
echo 1) Fist
if "!WkbPurchased!" == "true" echo 2) KnuckleBusters
if "!wncPurchased!" == "true" echo 3) NunChucks
echo.
echo.
echo Equip weapon
echo.
echo "b" to go back.
echo.
set /p c=Enter:
if "!c!" == "1" set Current2=Fist
if "!c!" == "2" set Current2=KnuckleBusters
if "!c!" == "3" set Current2=NunChucks
if "!c!" == "b" goto home
echo.
pause
goto home

::## SHOP ############################################

:Village
cls
echo What would you like to go bum?
echo.
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo.
echo 1) Healing
echo 2) Armory
echo 3) Tacticals
echo 4) Home
echo.
set /p c=Enter:

if "!c!" == "1" goto shophp
if "!c!" == "2" goto shoparm
if "!C!" == "3" goto shopbombs
if "!c!" == "4" goto home

:shophp
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo Well hello there, im the village's local witchdoctor.. For a fee i can heal you, you know?
echo I've kindof lost my touch at this but i promise that u might not die, ok? Its $5 by the way.
echo.
echo [Y,N]
echo.
set /p c=Enter:

if "!c!" == "y" goto healing
if "!c!" == "n" goto village

:Healing
if %hp% == %maxhp% (
	goto healfailed
	)
else (	
set /a money-=5
set /a hp=maxhp
goto village
)

:healfailed
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo.
echo Oops seem like i did some damage, should've told me that you were healthy.
echo Hmph, and I'll be taking an extra $5
echo.
set /a money-=10
set /a hp-=20
pause
goto Village

:shoparm
cls
echo.                                                                                                         
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo 1) Knuckle Busters ($10x2)
echo 2) NunChucks ($20x2)
echo 3) Back
echo.
echo.
set /p c=Enter:

if "!c!" == "1" (
    if "!WkbPurchased!" == "true" (
        goto shoparm
    ) else (
        goto purchase.KB
    )   
)
if "!c!" == "2" (
    if "!wncPurchased!" == "true" (
        goto shoparm
    ) else (
        goto purchase.NC
    )
)
if "!c!" == "3" goto village

:purchase.KB
    set WkbPurchased=true
    set /a money-=20
    goto shoparm

:purchase.NC
    set wncPurchased=true
    set /a money-=40
    goto shoparm

:shopbombs
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo 1) Bomb ($15)
echo 2) Back
echo.
set /p c=Enter:

if "!c!" == "1" (
    if %money% geq 15 (
        set /a bombs+=1
        set /a money-=15
    ) else (
	cls
        echo Insufficient funds
        pause
    )
    goto shopbombs
)
if "!c!" == "2" goto village

::## ENCOUNTERS ######################################

:Worlds
cls
echo.
echo Just choose your path man
echo.
echo.
echo 1) Forest
echo 2) Cave
echo 3) Mountain
echo 4) Home
echo.
echo.
set /p c=Enter:

if "!c!" == "1" goto forest
if "!c!" == "2" goto cave
if "!c!" == "3" goto mountain
if "!c!" == "4" goto home
goto worlds

:Forest
cls
echo.
echo There are two path infront of you
echo.
echo 1) Goblin Village
echo 2) Elf Hideout
echo.
echo.
set /p c=Enter:

if "!c!" == "1" goto forestprecombat1
if "!c!" == "2" goto forestprecombat2


:forestprecombat1
set goblinhp=30
set Goblindmg=2
if !Goblinbodycount! geq 1 if !Goblinbodycount! leq 5 ( 
	set /a Goblinhp+=10
	set /a Goblindmg+=2
	)
if !Goblinbodycount! geq 6 ( 
	set /a Goblinhp+=20
	set /a Goblindmg+=4
	)


:Forestencounter1
cls
echo.
echo You:%hp%
echo Goblin:%Goblinhp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto Forestattack1
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto Worlds
goto Forestencounter1

:Forestattack1

set /a hp-=!Goblindmg!
set /a Goblinhp-=!playerdmg!
if !Goblinhp! leq 0 (
	cls
	set /a money+=4
	set /a Goblinbodycount+=1
	set /a playerxp+=5
	goto Forestcontinue1
	)
if !hp! leq 0 (
	goto death
	)
goto Forestencounter1

:usebomb
if %bombs% gtr 0 (
    set /a Goblinhp-=30
    set /a bombs-=1)
)
if !Goblinhp! leq 0 (
	cls
	set /a money+=4
	set /a Goblinbodycount+=1
	set /a playerxp+=5
	goto Forestcontinue1
	)
    goto Forestencounter1

:Forestcontinue1
echo.
echo Wow you. you killed it? Ok
echo You found $4 and gained 5xp
echo. 
pause
goto Forestprecombat1

:forestprecombat2
cls
set Elfhp=50
set Elfdmg=4
if !Elfbodycount! geq 1 if !Elfbodycount! leq 5 ( 
	set /a Elfhp+=10
	set /a Elfdmg+=2
	)
if !Elfbodycount! geq 6 ( 
	set /a Elfhp+=20
	set /a Elfdmg+=4
	)


:Forestencounter2
cls
echo.
echo You:%hp%
echo Elf:%Elfhp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto Forestattack2
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto Worlds
goto forestencounter2

:Forestattack2

set /a hp-=!Elfdmg!
set /a Elfhp-=!playerdmg!
if !Elfhp! leq 0 (
	cls
	set /a money+=8
	set /a Elfbodycount+=1
	set /a playerxp+=10
	goto forestcontinue2
	)
if !hp! leq 0 (
	goto death
	)
goto Forestencounter2

:usebomb
if %bombs% gtr 0 (
    set /a Elfhp-=30
    set /a bombs-=1)
)
if !Elfhp! leq 0 (
	cls
	set /a money+=8
	set /a Elfbodycount+=1
	set /a playerxp+=10
	goto Forestcontinue2
	)
    goto Forestencounter2

:Forestcontinue2
echo.
echo Wow you. you killed it? Ok
echo You found $8 and gained 10xp
echo. 
pause
goto Forestprecombat2

:cave
cls
echo.
echo You come across a cave with two entrances, left seems to be infested with spiders and on the right are a few scorpions
echo.
echo 1) Spider Nest
echo 2) Lingering Scorpions 
echo.
echo.
set /p c=Enter:

if "!c!" == "1" goto caveprecombat1
if "!c!" == "2" goto Caveprecombat2

:caveprecombat1
set Spiderhp=30
set Spiderdmg=2
if !Spiderbodycount! geq 1 if !Spiderbodycount! leq 5 ( 
	set /a Spiderhp+=10
	set /a Spiderdmg+=2
	)
if !Spiderbodycount! geq 6 ( 
	set /a Spiderhp+=20
	set /a Spiderdmg+=4
	)


:Caveencounter1
cls
echo.
echo You:%hp%
echo Spider:%Spiderhp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto Caveattack1
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto Worlds
goto Caveencounter1

:Caveattack1

set /a hp-=!Spiderdmg!
set /a Spiderhp-=!playerdmg!
if !Spiderhp! leq 0 (
	cls
	set /a money+=15
	set /a Spiderbodycount+=1
	set /a playerxp+=15
	goto Cavecontinue1
	)
if !hp! leq 0 (
	goto death
	)
goto Caveencounter1

:usebomb
if %bombs% gtr 0 (
    set /a Spiderhp-=30
    set /a bombs-=1)
)
if !Goblinhp! leq 0 (
	cls
	set /a money+=15
	set /a Spiderbodycount+=1
	set /a playerxp+=15
	goto cavecontinue1
	)
    goto cavecounter1

:Cavecontinue1
echo.
echo Wow you. you killed it? Ok
echo You found $15 and gained 15xp
echo. 
pause
goto Caveprecombat1

:Caveprecombat2
cls
set scorpionhp=50
set scorpiondmg=4
if !scorpionbodycount! geq 1 if !scorpionbodycount! leq 5 ( 
	set /a scorpionhp+=10
	set /a scorpiondmg+=2
	)
if !scorpionbodycount! geq 6 ( 
	set /a scorpionhp+=20
	set /a scorpiondmg+=4
	)


:caveencounter2
cls
echo.
echo You:%hp%
echo Scorpion:%scorpionhp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto Caveattack2
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto Worlds
goto Caveencounter2

:Caveattack2

set /a hp-=!scorpiondmg!
set /a Scorpionhp-=!playerdmg!
if !scorpionhp! leq 0 (
	cls
	set /a money+=20
	set /a scorpionbodycount+=1
	set /a playerxp+=20
	goto Cavecontinue2
	)
if !hp! leq 0 (
	goto death
	)
goto Caveencounter2

:usebomb
if %bombs% gtr 0 (
    set /a scorpionhp-=30
    set /a bombs-=1)
)
if !scorpionhp! leq 0 (
	cls
	set /a money+=20
	set /a scorpionbodycount+=1
	set /a playerxp+=20
	goto Cavecontinue2
	)
    goto Caveencounter2

:Cavecontinue2
echo.
echo Wow you. you killed it? Ok
echo You found $20 and gained 20xp
echo. 
pause
goto caveprecombat2

:Mountain
cls
echo.
echo You enter the mountain passage, you can feel the ground rumbling, could there be a boss fight coming up? Maybe a Giant Snow Yeti?
echo.
echo 1) Explore Further Up 
echo 2) Back Out 
echo.
echo.
set /p c=Enter:

if "!c!" == "1" goto Mountainprecombat1
if "!c!" == "2" goto Worlds

:Mountainprecombat1
set yetihp=30
set yetidmg=2
if !yetibodycount! geq 1 if !yetibodycount! leq 5 ( 
	set /a yetihp+=10
	set /a yetidmg+=2
	)
if !yetibodycount! geq 6 ( 
	set /a yetihp+=20
	set /a yetidmg+=4
	)


:Mountainencounter1
cls
echo.
echo Boss Yeti
echo.
echo You:%hp%
echo Yeti:%yetihp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto Mountainattack1
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto Worlds
goto Mountainencounter1

:Mountainattack1

set /a hp-=!yetidmg!
set /a yetihp-=!playerdmg!
if !yetihp! leq 0 (
	cls
	set /a money+=50
	set /a yetibodycount+=1
	set /a playerxp+=50
	goto Mountaincontinue1
	)
if !hp! leq 0 (
	goto death
	)
goto Mountainencounter1

:usebomb
if %bombs% gtr 0 (
    set /a yetihp-=30
    set /a bombs-=1
)
if !yetihp! leq 0 (
	cls
	set /a money+=50
	set /a Yetibodycount+=1
	set /a playerxp+=50
	goto Mountaincontinue1
	)
    goto Mountaincounter1

:Mountaincontinue1
echo.
echo Wow you. you killed it? Ok
echo You found $50 and gained 50xp
echo. 
pause
goto Mountainprecombat1

::## DEATH ################################

:death
cls
echo. 
echo You are Dead
echo You had $%money% and your Max health you attained was %maxhp%Hp at Death 
echo.
echo back to the main menu you go...
echo.
echo.
pause
goto menu