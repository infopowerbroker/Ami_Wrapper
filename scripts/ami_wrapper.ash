#ami_wrapper.ash
void main(){
notify infopowerbroker;
//first run prerequisites check. This will find any issues in the script or update preferences per ascention
if((get_property("_amiWrapperStage").to_int()!=1) && (get_property("_amiWrapperStage").to_int()<2)){
	
	//saving the outfit to get redressed after testing prerequisites
	cli_execute("outfit save z_ami_Backup");

	//checking for CCS Jokester (using Jokester's Gun for free fights)
	if(!cli_execute("ccs Jokester")){
	print("please create a CCS named Jokester then re-run this script.");
	print("the CCS should have the following lines:");
	print("special action");
	print("skill Fire the Jokester's Gun");
	print("spell Saucegeyser");
	print("attack with weapon");
	abort("Error: the CCS for Jokester's Gun could not be found");
	}
	//checking for CCS ShatterPunch (using Shattering Punch for free fights)
	if(!cli_execute("ccs ShatterPunch")){
	print("please create a CCS named ShatterPunch then re-run this script.");
	print("the CCS should have the following lines:");
	print("special action");
	print("skill Shattering Punch");
	print("spell Saucegeyser");
	print("attack with weapon");
	abort("Error: the CCS for Shattering Punch could not be found");
	}
	//checking for CCS Saucegeyser (using Saucegeyser for winning already-free fights)
	if(!cli_execute("ccs Saucegeyser")){
	print("please create a CCS named Saucegeyser then re-run this script.");
	print("the CCS should have the following lines:");
	print("special action");
	print("spell Saucegeyser");
	abort("Error: the CCS named Saucegeyser could not be found");
	}
	//We use this zone to clear timepranks that would mess up automation. Setting to 'skip adventure' makes it free.
	if(get_property("choiceAdventure783").to_int() != 6){
	print("Please set the Choice Adventure preference");
	print("for Hidden City: An Overgrown Shrine (Southwest)");
	print("to 'skip this adventure'.");
	print("This will let us clear timepranks.");
	abort("Error: please set the choice adventure. Ask IPB if any help is needed");
	}
	//this will automate the Soul Stalagmite adventure, should only need to be changed once per ascention. 
	if(my_primestat() == $stat[Muscle]){if(get_property("choiceAdventure1491").to_int() != 1){
	print("Please set the Choice Adventure preference");
	print("for Item: Strange Stalagmite");
	print("to 'Muscle substats'.");
	print("This will boost Mainstat.");
	abort("Error: please set the choice adventure. Ask IPB if any help is needed");
	}}else if(my_primestat() == $stat[Mysticality]){if(get_property("choiceAdventure1491").to_int() != 2){
	print("Please set the Choice Adventure preference");
	print("for Item: Strange Stalagmite");
	print("to 'Mysticality substats'.");
	print("This will boost Mainstat.");
	abort("Error: please set the choice adventure. Ask IPB if any help is needed");
	}}else if(get_property("choiceAdventure1491").to_int() != 3){ //if not Mus or Mys, why not zoid-Moxie?
	print("Please set the Choice Adventure preference");
	print("for Item: Strange Stalagmite");
	print("to 'Moxie substats'.");
	print("This will boost Moxie, the best.");
	abort("Error: please set the choice adventure. Ask IPB if any help is needed");
	}
	//this will check to make sure the outfit is named correctly. IPB can change the script if needed.
	if(!cli_execute("outfit 1 - Free fights")){
	print("Unable to find the right outfit. Ask IPB to update the code with the right outfit name");
	cli_execute("outfit z_ami_Backup");
	abort("Error: unable to find the corect outfit '1 - Free Fights'");
	}
	//this will check to make sure the outfit is named correctly. IPB can change the script if needed.
	if(!cli_execute("outfit 3 - Volcano Farming")){
	print("Unable to find the right outfit. Ask IPB to update the code with the right outfit name");
	cli_execute("outfit z_ami_Backup");
	abort("Error: unable to find the corect outfit '3 - Volcano Farming'");
	}


	//tests are over. Getting back in our PJs so we can have a proper 1980's breakfast
	cli_execute("outfit z_ami_Backup");
	
}
//checking to see if someone else already farmed with Ami today. I'm guessing 60 adv is safe, the nightcap won't exceed that
if((get_property("_amiWrapperStage").to_int()!=1) && (get_property("_amiWrapperStage").to_int()<2) && (my_inebriety().to_int()>inebriety_limit().to_int())){
	chat_notify( "Someone else already ran adventures today", "red" );
	chat_notify( "Try again after rollover", "red" );
	set_property("_amiWrapperStage", 10);
	set_property("_amiWrapperDescription",'Someone else already ran turns today.');
}

if((get_property("_amiWrapperStage").to_int()!=1) && (get_property("_amiWrapperStage").to_int()<2)){
	set_property("_amiWrapperDescription",'Eating Breakfast');
		//run Breakfast
	cli_execute("try; breakfast");
	
	adv1($location[An Overgrown Shrine (Southwest)], -1, ""); // Deal with pending timepranks
	set_property("_amiWrapperStage", 1);//breakfast done
	set_property("_amiWrapperDescription",'Breakfast Done');
}

if(get_property("_amiWrapperStage").to_int()==1){
		set_property("_amiWrapperDescription",'Checking/Getting Photocopied Monster');
	adv1($location[An Overgrown Shrine (Southwest)], -1, ""); // Deal with pending timepranks
	if (item_amount( $item[photocopied monster] ).to_int() <1){
		chat_private("cwbot" , "!fax");
		//at this point, the operator can !fax in a fudge wasp in accordance with clan rules
		//after the fax is obtained, re-run the program
		exit;
		}
	else{
		cli_execute("outfit 1 - Free Fights");
		cli_execute("ccs Jokester");
		visit_url("inv_use.php?pwd&which=3&whichitem=4873");
		adv1($location[Noob Cave], -1, "");
		
		set_property("_amiWrapperStage", 2);
		set_property("_amiWrapperDescription",'Photocopied Monster Obtained and fought');
	}
}

if(get_property("_amiWrapperStage").to_int()==2){
	set_property("_amiWrapperDescription",'using items and interacting with clannies');
	//Run Zatara.ash 
	cli_execute("try; call Zatara.ash");
	
	//get an item from the Clan's April Shower. Change 'ice' to one of the following
	//cold | ice | cool | moxie | lukewarm | mysticality | warm | muscle | hot | mp
	cli_execute("try; shower ice");	
	
	
	//getting first of 3 consults from CWBot
	if (get_property("_clanFortuneConsultUses") <3){
		cli_execute("try; fortune cwbot");
		chat_notify( "Asked fortune from CWBot", "blue" );
	}
	
	boolean hastrained = get_property( "_crimboTraining" ).to_boolean();
	//trying to train somone with the crimbo skill 
	if( !hastrained ){
		cli_execute("try; call randomtrain.ash");
	}
	
	//runs strange stalagmite and boosts mainstat
	if(my_primestat() == $stat[Muscle])
			{
				use(1,$item[strange stalagmite]); run_choice(1); // muscle stats
			}
			else if(my_primestat() == $stat[Mysticality])
			{
			print("taking mys branch");
			use(1,$item[strange stalagmite]) ;run_choice(2); // myst stats
			}
			else // if no prime stat we still want moxie
			{
				use(1,$item[strange stalagmite]) ;run_choice(3); // moxie stat
}
	
	//doing pingpong with a random clannie
	boolean forrestGump = get_property( "_pingPongGame" ).to_boolean();
	if( forrestGump )
	{
		print_html( "You've already played ping pong against someone today" );
	}
	else{
		boolean[string] clannies = who_clan();
		string[int] randomlist;
		int i = 0;
		foreach name in clannies
		{
			randomlist[i++] = name;
		}
		sort randomlist by random(1000000);
		for( i = 0; i < randomlist.count(); i++ )
		{
			if(!forrestGump){
			cli_execute( "try; pingpong " + randomlist[i] );
			}
		
			forrestGump = get_property( "_pingPongGame" ).to_boolean();
		}
		if(!forrestGump){
		print_html( "Nobody in chat wanted to play ping pong, try again later." );
		}
	}
	//using portable steam unit
	use(1,$item[portable steam unit]);

	cli_execute("epicmall.ash");

	//getting second of 3 consults from CWBot
	if (get_property("_clanFortuneConsultUses") <3){
		cli_execute("try; fortune cwbot");
		chat_notify( "Asked fortune from CWBot", "blue" );
	}
set_property("_amiWrapperDescription",'done with epicmall and pingpong stuff');
set_property("_amiWrapperStage", 3);
}



if(get_property("_amiWrapperStage").to_int()==3){
set_property("_amiWrapperDescription",'Starting Free Fights');
	//do additional free fights
	cli_execute("ccs ShatterPunch");
	visit_URL("place.php?whichplace=forestvillage&action=fv_scientist");run_choice(1);//eldridch tenticle
	
	use(1,$item[molehill mountain]);
	
set_property("_amiWrapperDescription",'Done with Free Fights');
set_property("_amiWrapperStage", 4);
}

if(get_property("_amiWrapperStage").to_int()==4){
	set_property("_amiWrapperDescription",'Running visiting Internet Store');
	if(item_amount($item[gallon of milk]) <= item_amount($item[print screen button]))
	{
		cli_execute("try; coinmaster buy bacon gallon of milk");
	}
	else{
		cli_execute("try; coinmaster buy bacon print screen button");
	}
	set_property("_amiWrapperDescription",'Done at internet store');
	set_property("_amiWrapperStage", 5);
}

if(get_property("_amiWrapperStage").to_int()==5){
set_property("_amiWrapperDescription",'visiting the Still');
//getting 10 tonic water, can make this more complicated if trying to balance items
cli_execute("try; make 10 tonic water");

set_property("_amiWrapperDescription",'done with the still');
set_property("_amiWrapperStage", 6);
}

if(get_property("_amiWrapperStage").to_int()==6){
	//running LinknoidMine script
	cli_execute("linknoidmine.ash 1");
	set_property("_amiWrapperDescription",'Ran LinknoidMine');
	set_property("_amiWrapperStage", 7);
}

if(get_property("_amiWrapperStage").to_int()==7){
	set_property("_amiWrapperDescription",'using Lodestone');
	cli_execute("CONSUME ALL VALUE 3500"); 
	//using lodestone
	use(1, $item[lodestone]);
	set_property("_amiWrapperDescription",'Lodestone Used');
	set_property("_amiWrapperStage", 8);
}

if(get_property("_amiWrapperStage").to_int()==8){
	cli_execute("outfit 3 - Volcano Farming");
	//running KOL-MineVolcano 
int miningtime = my_adventures()-1;
	cli_execute("minevolcano.ash " + miningtime);
set_property("_amiWrapperDescription",'Ran mineVolcano');
	set_property("_amiWrapperStage", 9);
}

if(get_property("_amiWrapperStage").to_int()==9){
	cli_execute("try; rollover management.ash");
	//
	set_property("_amiWrapperDescription",'Beginning End of day Routine');
	cli_execute("try; familiar stooper");
	cli_execute("try; cast ode");
	cli_execute("try; CONSUME NIGHTCAP VALUE 3500");
	cli_execute("try; familiar Teddy Bear");
	set_property("_amiWrapperDescription",'Overdrunk');
	
	//getting third of 3 consults from CWBot
	if (get_property("_clanFortuneConsultUses") <3){
		cli_execute("try; fortune cwbot");
		chat_notify( "Asked fortune from CWBot", "blue" );
	}
	boolean hastrained3 = get_property( "_crimboTraining" ).to_boolean();
	
	//trying to train somone with the crimbo skill if it didn't work the first time
	if( !hastrained3 ){
	cli_execute("try; call randomtrain.ash");
	}
	set_property("_amiWrapperStage", 10);
	set_property("_amiWrapperDescription",'Done for the day');
	exit;
}
}
