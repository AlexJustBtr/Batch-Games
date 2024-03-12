@echo off
title RPG Game
setlocal enabledelayedexpansion

:menu
cls
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
set hp=100
set playerdmg=7
set bodycount=0
set money=500
set p=false
set p2=false
set Wkb=false
set wlln=false
set current=Fist
set WkbPurchased=false
set wllnPurchased=false
set bombs=0
goto home

:home
cls
if "!Current!" == "Fist" set /a playerdmg=7
if "!Current!" == "KnuckleBusters" set /a playerdmg=12
if "!Current!" == "LongLadyNails" set /a playerdmg=17
echo.
echo	HP: %hp%		$%money%
echo	Damage: %playerdmg%		Weapon:	%current%
echo.
echo 1) Enter the wild
echo 2) Village
echo 3) Inventory
echo 4) Exit
echo.
set /p c=Enter:

if "!c!" == "1" goto precombat
if "!c!" == "2" goto Village
if "!c!" == "3" goto Inventory
if "!c!" == "4" goto menu
goto home


::## INVENTORY #######################################

:Inventory
cls
echo Current weapon:    [%Current%]
echo.
echo Bombs: %bombs%
echo.
echo Weapons:
echo.
echo 1) Fist
if "!WkbPurchased!" == "true" echo 2) KnuckleBusters
if "!wllnPurchased!" == "true" echo 3) LongLadyNails
echo.
echo.
echo Equip weapon
echo.
echo "b" to go back.
echo.
set /p c=Enter:
if "!c!" == "1" set Current=Fist
if "!c!" == "2" set Current=KnuckleBusters
if "!c!" == "3" set Current=LongLadyNails
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
if %hp% geq 99 (
	goto healfailed
	)
else (	
set /a money-=5
set /a hp=100
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
echo 1) Knuckle Busters ($10)
echo 2) LongLadyNails ($20)
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
    if "!wllnPurchased!" == "true" (
        goto shoparm
    ) else (
        goto purchase.LLN
    )
)
if "!c!" == "3" goto village

:purchase.KB
    set WkbPurchased=true
    set /a money-=10
    goto shoparm

:purchase.LLN
    set wllnPurchased=true
    set /a money-=20
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

:precombat
set monsterhp=30
set monsterdmg=2
if !bodycount! geq 1 if !bodycount! leq 5 ( 
	set /a monsterhp+=10
	set /a monsterdmg+=2
	)
if !bodycount! geq 6 ( 
	set /a monsterhp+=20
	set /a monsterdmg+=4
	)

:encounter1
cls
echo.
echo You:%hp%
echo Goblin:%monsterhp%
echo.
echo 1) Attack	(%playerdmg% dmg)
echo 2) Use Bomb	(30 dmg)
echo 3) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto attack1
if "!c!" == "2" goto Usebomb
if "!c!" == "3" goto home
goto encounter1

:attack1

set /a hp-=!monsterdmg!
set /a monsterhp-=!playerdmg!
if !monsterhp! leq 0 (
	cls
	set /a money+=10
	set /a bodycount+=1
	goto continue1
	)
if !hp! leq 0 (
	goto death
	)
goto encounter1

:usebomb
if %bombs% gtr 0 (
    set /a monsterhp-=30
    set /a bombs-=1)
)
if !monsterhp! leq 0 (
	cls
	set /a money+=10
	set /a bodycount+=1
	goto continue1
	)
    goto encounter1

:continue1
echo.
echo Wow you. you killed it? Ok
echo You found $10
echo. 
pause
goto precombat

::## DEATH ################################

:death
cls
echo. 
echo You are Dead
echo You had $%money% at Death 
echo.
echo back to the main menu you go...
echo.
echo.
pause
goto menu