# Ami_Wrapper
KOL script that will run volcano mining based on the requirements of user Amicrobial 

What does it do?
----------------
This script will run through daily volcano meat-farming based on a set of requirements by Amicrobial.

What Actions are performed?
----------------
```
run zatara.ash:  http:// pekaje.mooo.com/share/zatara.ash
consult CWbot 3x
run randomtrain.ash:  http:// pekaje.mooo.com/ share/ randomtrain.ash
run epicmall.ash:  https://github.com/ infopowerbroker/ EpicMall
use the still 10x ( tonic water is always good, so are the fruit needed for the best drinks pls)
use BACON to buy print screen button or gallon of milk
equip custom outfit 1 - Free fights (in the inventory) and use the Jokesterâs gun 
fax and fight swarm of fudgewasps
use portable steam unit
use portable ping-pong table
use strange stalagmite
free fights (molehill: +muscle, tentacle: +item): steal and attack
use lodestone
run CONSUME ALL VALUE 3500 and buy the needed diet items at the mall: [link] https://github.com/ soolar/CONSUME.ash
run 1 turn with linkoildmine.ash:  https:// drive.google.com/ file/d/ 1qns_TFnxjahhPUV6wmw llI26BBRHV0Vn/view? usp=sharing
equip custom outfit 3 - Volcano Farming (already on inventory)
run all turns left with minevolcano.ash:  https://github.com/ Loathing-Associates- Scripting-Society/ KoL-MineVolcano
run RollOver Management.ash:  https://kolmafia.us/ threads/rollover- management.22074/

```
How do I use it?
----------------
First, install it by running this command in KoLmafia's graphical CLI:

```
git checkout https://github.com/infopowerbroker/ami_wrapper.git release
```

 
Add the following as a custom daily deed:
```
$CUSTOM|Command|Run Ami_Wrapper|z_Ami_Wrapper|call Ami_wrapper.ash|||,
```

More information about custom daily deeds can be found on the Wiki: https://wiki.kolmafia.us/index.php/Daily_Deeds

To add the daily deed, close down mafia and edit the file GLOBAL_prefs.txt in settings/
Make a backup copy first. Also make sure your editor isn't set to word wrap (not clear on how that works).
Find the line that starts with dailyDeedsOptions= and add a comma and the custom deed you want to the end of the line. You can reorder the lines easily in mafia, once you restart it. 
