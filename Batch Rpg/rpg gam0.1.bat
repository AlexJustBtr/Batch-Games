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
set money=20
set armor=None
set weapon=None
set p=false
set Wkb=False
set wlln=false
set Wpistol=false
set current=Fist
goto home

:home
cls
echo.
echo	HP: %hp%		$%money%
echo	Damage: %playerdmg%
echo	Armor: %armor%	Weapon: %weapon%
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
echo Current weapon:	[%Current%]
echo.
echo.
echo Weapons:
echo.
echo.
if "!wkb!" == "true" echo KnuckleBusters && set p=true
if "!wlln!" == "true" echo LongLadyNails && set p=true
if "!Wpistol!" == "true" echo Pistol && set p=true
if "!p!" == "false" echo None
echo.
echo.
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
echo 3) Home
echo.
set /p c=Enter:

if "!c!" == "1" goto shophp
if "!c!" == "2" goto shoparm
if "!C!" == "3" goto home

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
echo 3) Pistol ($30)
echo.
echo "b" to go back
echo.
set /p c=Enter:

if "!c!" == "1" goto purchase.KB
if "!c!" == "2" goto purchase.LLN
if "!c!" == "3" goto purchase.Pistol
if "!c!" == "b" goto village

:purchase.KB
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo 1) Buy KnuckleBusters ($10)
echo 2) I'm broke, i dont wanna spend money on this. 
echo.
echo.
set /p c=Enter:

if "!c!" == "1" (
	set /a Wkb=true
	set /a money-=10
	set /a playerdmg+=5
	echo.
	echo.
	echo Thank you, do come again!
	echo.
	echo.
	)
if "!c!" == "2" (
	echo.
	echo.
	echo.
	echo Dont buy my stuff then loser!
	echo.
	echo.
	)
pause
goto shoparm

:purchase.LLN
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo 1) Buy LongLadyNails ($20)
echo 2) I'm broke, i dont wanna spend money on this. 
echo.
echo.
set /p c=Enter:

if "!c!" == "1" (
	set /a wlln=true
	set /a money-=20
	set /a playerdmg+=10
	echo.
	echo.
	echo Thank you, do come again!
	echo.
	echo.
	)
if "!c!" == "2" (
	echo.
	echo.
	echo.
	echo Dont buy my stuff then loser!
	echo.
	echo.
	)
pause
goto shoparm

:purchase.Pistol
cls
echo.
echo.    -----
echo    [-$%money%-]	   Hp:%hp%
echo.    -----
echo.
echo 1) Buy Pistol ($30)
echo 2) I'm broke, i dont wanna spend money on this. 
echo.
echo.
set /p c=Enter:

if "!c!" == "1" (
	set /a Wpistol=true
	set /a money-=30
	set /a playerdmg+=15
	echo.
	echo.
	echo Thank you, do come again!
	echo.
	echo.
	)
if "!c!" == "2" (
	echo.
	echo.
	echo.
	echo Dont buy my stuff then loser!
	echo.
	echo.
	)
pause
goto shoparm


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
echo 1) Attack
echo 2) Run Away
echo. 
set /p c=Enter:

if "!c!" == "1" goto attack1
if "!c!" == "2" goto home
goto encounter1

:attack1

set /a hp-=!monsterdmg!
set /a monsterhp-=!playerdmg!
if !monsterhp! lss 0 (
	cls
	set /a money+=10
	set /a bodycount+=1
	goto continue1
	)
if !hp! lss 0 (
	goto death
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