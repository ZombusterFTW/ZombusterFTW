#using scripts\zm\_zm_utility;
#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_score;
#using scripts\zm\zm_usermap;
#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#using scripts\shared\animation_shared;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\shared\ai\zombie_utility;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_perks;
#using scripts\Sphynx\_zm_subtitles;
//#using scripts\zm\zm_chilis;
#using scripts\_NSZ\roomserviceeasteregg;
//#using scripts\_redspace\rs_o_jump_pad;
#using scripts\zm\_zm_ai_mechz;
#using scripts\shared\lui_shared;
#precache("fx", "dlc2/zmb_weapon/fx_skull_quest_ritual_doorbarrier_island");
#precache( "fx", "dlc1/castle/fx_elec_teleport_flash_sm" );
#precache( "vehicle", "veh_default_zipline");
#precache( "fx", "redspace/fx_launchpad_blue" );
#precache( "fx", "redspace/fx_launchpad_red" );
#precache("fx", "_mikeyray/perks/phd/fx_perk_phd");
#precache( "material", "eral" );
#precache( "material", "pigman_jumpscare" );
#precache( "material", "rhettscare" );
#precache( "material", "stuffmanscare" );
#precache( "material", "number2oil" ); 
#precache( "material", "amongscare" );
#precache( "material", "susscare" );
#precache( "material", "trollscare" );
#precache("fx", "fx_powerup_nuke_zmb");
#namespace jumpscare; 


function autoexec roomservice()
{
	level.mushroomcloudfx = "fx_powerup_nuke_zmb";
	level.phdnukefx = "_mikeyray/perks/phd/fx_perk_phd";
	level.keycarddisappear = "dlc1/castle/fx_elec_teleport_flash_sm";
	level.bartenderdetect = GetEnt("bartender_man_detect","targetname");
	level.teleporterdoorfxtest = "dlc2/zmb_weapon/fx_skull_quest_ritual_doorbarrier_island";
	level.roomdoor = GetEnt("roomservicedoor", "targetname");
	level.roomservicedoortrig = GetEnt("roomservicetrig", "targetname");
	level.playerhallcheck = GetEnt("playerhallwaycheck", "targetname");
	//level.roomservicesound = GetEnt("roomservicesound", "targetname");
	level.roomservicedeliver = GetEnt("roomservicedeliver", "targetname");
	level.roomservicefood = GetEnt("roomservicefood", "targetname");
	level.roomservicefoodtrig = GetEnt("roomservicedelivertrig", "targetname");
	level.roomservicefoodtrig SetCursorHint("HINT_NOICON");
	level.roomservicefoodtrig SetHintString("");
	level.roomservicedeliver SetCursorHint("HINT_NOICON");
	level.roomservicedeliver SetHintString("");
	level.teleportdoortrigger = GetEnt("teleporterdoordetect", "targetname");
	level.teleportdooorclip = GetEnt("teleportguarddoor", "targetname");
	level.teleporterdoorfx = GetEnt("fxmodelteleporterdoor", "targetname");
	level.keycard = GetEnt("employeekeycard","targetname");
	level.keycardtrigger = GetEnt("employeekeycardtrig", "targetname");
	level.bartenderdetectinteracts = GetEnt("bartenderspeakertrig", "targetname");
	level.keycardtrigger SetCursorHint("HINT_NOICON");
	level.keycardtrigger SetHintString("");
	level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	level.bartenderdetectinteracts SetHintString("");
	level.bartenderdetectinteract TriggerEnable(false);
	level.keycardtrigger TriggerEnable(false);
	level.keycardpantry = GetEnt("keycardpantry","targetname");
	level.keycardpantryreader SetCursorHint("HINT_NOICON");
	level.keycardpantryreader SetHintString("");
	level.keycardpantryreader = GetEnt("keycardreaderpantry","targetname");
	level.keycardpantrydoor = GetEnt("pantrydoor","targetname");
	level.keycardpantrydoorclip = GetEnt("pantrydoorclip","targetname");
	level.keycardpantryreader TriggerEnable(false);
	//boxes reveal linkpad
	level.revealboxes = GetEntArray("revealbox","targetname");
	level.revealboxesclip = GetEnt("boxdebris","targetname");
	level.revealboxestrigger = GetEnt("powerboxesgobyebye","targetname");
	//level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	//level.bartenderdetectinteracts SetHintString("");
	//level.keycardtrigger UseTriggerRequireLookAt();
	level.bartenderdetectinteracts show();
	level.questcomplete = 0;
	level.dialougnum = 0;
	level.keycard hide();
	//level.teleporterdoorfx hide();
	level.roomservicedeliver hide();
	level.roomservicedoortrig hide();
	level thread dialougedetermine();
	level thread keycarddetect();
	level thread dialoug1();
	level thread dialoug2();
	level.keycardpantry hide();
	
}

function dialoug1()
{
	while(1)
	{
	self endon("dialougset");
	level.bartenderdetect waittill("trigger", player);
	level.dialougenum = 1;
	level notify("dialougset");
	break;
	}

}
function dialoug2()
{
	while(1)
	{
	self endon("dialougset");
	level.playerhallcheck waittill("trigger", player);
	level.dialougenum = 2;
	level notify("dialougset");
	break;
	}
}

function dialougedetermine()
{
	level waittill("dialougset");
	wait(0.5);

		if (level.dialougenum == 1)
		{
			level thread bartenderfirst();
			//IPrintLnBold ("walked past bartender first");
			//speak_to_meemers("mlg");
			level.bartenderdetectinteract TriggerEnable(true);
			//level.dialougenum = 1;
			break;
		}
		else if (level.dialougenum == 2)
		{
			//level.dialougenum = 2;
			//IPrintLnBold ("walked past 237 first");
			//speak_to_meemers("mlg");
			level.bartenderdetectinteract TriggerEnable(true);
			level thread walkpastfirst();
			break;
		}
}


function walkpastfirst()
{
	thread zm_subtitles::subtitle_display(undefined, 3, "^0Patron", "Hey, I see you out there! Are you my roomservice?");
	level.roomdoor PlaySound("vox_roomservice_1");
	wait(4.2);
	level.playerhallcheck waittill("trigger", player);
	thread zm_subtitles::subtitle_display(undefined, 3, "^0Patron", "Can you do me a favor and talk to the bartender for me pal?");
	level.roomdoor PlaySound("vox_roomservice_2");
	wait(4.2);
	thread zm_subtitles::subtitle_display(undefined, 3, undefined, "I've been waiting for hours");
	level.roomdoor PlaySound("vox_roomservice_3");
	wait(3.2);
	level thread bartendertalkpostwalk();		
	//IPrintLnBold ("Please come back, I've been waiting for hours, I'm starving please..");
}

function bartendertalkpostwalk()
{
	//IPrintLnBold ("post walk started");
	level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	level.bartenderdetectinteracts SetHintString("Press ^2[{+activate}]^8 To Talk To Lloyd");
	level.bartenderdetectinteracts waittill("trigger", player);
	wait(0.1);
	level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	level.bartenderdetectinteracts SetHintString("");
	//level.bartenderman PlaySound("");
	thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "I appreciate you talking to the fool in room 237 for me. I guess you've already done a favor for me, but would you mind doing another one for me?");
	wait(3);
	//level.bartenderman PlaySound("");
	thread zm_subtitles::subtitle_display(undefined, 2, undefined, "The patron in 237 wants a travis scott burger from the chilis upstairs. Could you prepare it and deliver it to him for me?");
	wait(3);
	//level.bartenderman PlaySound("");
	thread zm_subtitles::subtitle_display(undefined, 2, undefined, "In return i'll give you my employee keycard, which will allow to access the machine at the top of the stairs. Deal?");
	wait(3);
	//level.bartenderman PlaySound("");
	thread zm_subtitles::subtitle_display(undefined, 2, undefined, "You'll also need it to access the pantry upstairs. Pick it up when you are ready.");
	//IPrintLnBold ("Pick it up when ever you are ready");
	level thread keycardanim();
}

function keycardanim()
{
	//level.keycardtrigger EnableLinkTo();
	//level.keycardtrigger LinkTo(level.keycard);
	level.bartenderdetectinteract TriggerEnable(false);
	level.bartenderdetect TriggerEnable(false);
	level.bartenderdetect hide();
	level.bartenderdetectinteract hide();
	level.keycard show();
	PlayFX(level.keycarddisappear, level.keycard.origin);
	level.keycard PlaySound("keycardtelein");
	wait(.2);
	level.keycard MoveX(-19, 2);
	wait(2);
	//trigger wont show up the right way FUCK
	level.keycardtrigger TriggerEnable(true);
	//level.keycardtrigger UseTriggerRequireLookAt();
	level.keycardtrigger SetCursorHint("HINT_NOICON");
	level.keycardtrigger SetHintString("Hold ^2[{+activate}]^8 To Pick Up Employee Keycard");
	wait(0.1);
	//level.bartenderman PlaySound("");
	level.keycardtrigger waittill("trigger", player);
	level.keycardtrigger SetCursorHint("HINT_NOICON");
	level.keycardtrigger SetHintString("");
	player PlaySound("zmb_craftable_pickup");
	clientfield::set("employeekeycardchilis", 1);
	wait(0.1);
	level.keycardtrigger Delete();
	level.keycard Delete();
	level.questcomplete = 1;
	level thread pantrydoorunlock();
	level.keycardtrigger TriggerEnable(false);
	level.bartenderdetect TriggerEnable(true);
	level.bartenderdetect show();
	level.bartenderdetectinteract show();
	level notify("burgergamepartspawn");
	//level notify("burgergameactivate");
	//PlayFX(level._effect["powerup_grabbed"], level.keycard.origin);
	//level.bartenderman PlaySound("");
	//level thread burgerqueststart();
	//level thread bartenderextrareward();
}

function bartenderfirst()
{
	//IPrintLnBold ("bartender startingsada");
	//level.bartenderman PlaySound("");
	players = GetPlayers();
	if(players.size == 1)
	{
		thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "Hey, kid you mind doin me a favor?");
	}
	else
	{
		thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "Hey, do you guys mind doin me a favor?");
	}
	wait(5);
	level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	level.bartenderdetectinteracts SetHintString("Press ^2[{+activate}]^8 To Talk To Lloyd");
	level.bartenderdetectinteracts waittill("trigger", player);
	level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
	level.bartenderdetectinteracts SetHintString("");
			//level.bartenderman PlaySound("");
			IPrintLnBold ("");
			thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "Ok so there's guy in ^2room 237^8 waiting for roomservice, I would deliver it under normal circumstances but as you can see these circumstances aren't normal");
			wait(1.5);
			thread zm_subtitles::subtitle_display(undefined, 2, undefined, "I would deliver it under normal circumstances but as you can see these circumstances aren't normal");
			wait(1.5);
			//level.bartenderman PlaySound("");
			thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "He wants a travis scott burger from the chilis upstairs, could you prepare it and deliver it to him for me?");
			wait(2);
			//level.bartenderman PlaySound("");
			thread zm_subtitles::subtitle_display(undefined, 2, undefined, "In return i'll give you my employee keycard, it will allow you to access the machine at the top of the stairs and the ingredients upstairs");
			wait(2);
			//level.bartenderman PlaySound("");
			thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "Pick up the keycard whenever you are ready");
			//level.bartenderman PlaySound("");
			level thread keycardanim();
}

function autoexec burgerqueststart()
{
//Burger mini "game"
	level.cheese = GetEnt("cheese_pickup","targetname");
	level.topbun = GetEnt("topbun_pickup","targetname");
	level.bottombun = GetEnt("bottombun_pickup","targetname");
	level.patty = GetEnt("patty_pickup","targetname");
	level.lettuce = GetEnt("lettuce_pickup","targetname");
	level flag::init("cheese_flag", false);
	level flag::init("topbun_flag", false);
	level flag::init("bottombun_flag", false);
	level flag::init("patty_flag", false);
	level flag::init("lettuce_flag", false);
	///thread contructor
	
	/////
	level.cheesemodel hide();
	level.topbunmodel hide();
	level.bottombunmodel hide();
	level.burgerpattymodel hide();
	level.lettucemodel hide();
	level.cheesespot = GetEnt("hamburgerpatty","script_noteworthy");
	level.cheesespot thread clearhintstring();
	level.cheesemodel = GetEnt(level.cheesespot.target, "targetname");
	level.topbunspot = GetEnt("foodspottop","script_noteworthy");
	level.topbunspot thread clearhintstring();
	level.topbunmodel = GetEnt(level.topbunspot.target, "targetname");
	level.bottombunspot = GetEnt("foodspotbottom","script_noteworthy");
	level.bottombunspot thread clearhintstring();
	level.bottombunmodel = GetEnt(level.bottombunspot.target, "targetname");
	level.lettucespot = GetEnt("lettucebad","script_noteworthy");
	level.lettucespot thread clearhintstring();
	level.lettucemodel = GetEnt(level.lettucespot.target, "targetname");
	level.burgerpattyspot = GetEnt("foodspotcheese","script_noteworthy");
	level.burgerpattyspot thread clearhintstring();
	level.burgerpattymodel = GetEnt(level.burgerpattyspot.target, "targetname");
	level.finalburgerinteract = GetEnt("foodspotfinal","script_noteworthy");
	level.finalburgerinteract thread clearhintstring();
	level.finalburgermodel = GetEnt(level.finalburgerinteract.target, "targetname");
	level.cookarea = GetEnt("cookstation","targetname");
	level.cookarea thread clearhintstring();
	level.kitchendetect = GetEnt("kitchendetect","targetname");
	level.burgercook = GetEnt("cookingburgermodel", "targetname");
	level.pattydecoy = GetEnt("pattydecoy", "targetname");
	level.cheese thread burgerparts("cheese_flag", "Cheese", level.cheese.target, level.cheesemodel);
	level.topbun thread burgerparts("topbun_flag", "Top Bun", level.topbun.target, level.topbunmodel);
	level.bottombun thread burgerparts("bottombun_flag", "Bottom Bun", level.bottombun.target, level.bottombunmodel);
	level.patty thread burgerparts("patty_flag", "Raw Burger Patty", level.patty.target, level.pattydecoy);
	level.lettuce thread burgerparts("lettuce_flag", "Lettuce", level.lettuce.target, level.lettucemodel);
	level.failtime = 0;
	//
	level.burgercook hide();
	level.burgerpattymodel hide();
	level.finalburgermodel hide();
	level waittill("burgergameactivate");
	level flag::clear( "zombie_drop_powerups");
	level flag::clear( "spawn_zombies" );
	level thread killallzs();
	//play instuctional video here
	//stop zombies spawns
	//wait for length of video or split vid in parts
	//tell player how to cook patty and how its delicous smell will attract customers, do not be afraid to use lethal force the recipe must not be found
	//lock player in kitchen
	level.cookarea changehintstring("Press ^2[{+activate}]^8 To Begin Cooking Burger");
	level.cookarea waittill("trigger", player);
	level.cookarea changehintstring("Burger cooking in progress");
	level.burgercook show();
	foreach(player in GetPlayers())
	{
	player PlayLocalSound("vox_burger_scream");
	}
	thread zm_subtitles::subtitle_display(undefined, 2, "Burger", "*Various screams of intense agony*");
	level.burgercook PlayLoopSound("sizzleloop");
	//tempsound
	//level.burgercook PlaySound("mlg");
	level thread infinitesprintersspawn();
	//the zombies are coming
	wait(45);
	level.burgercook StopLoopSound(0.5);
	level notify("cookcompleted");
	level thread killallzs();
	level thread whitescreenflash();
	level.cookarea changehintstring("Press ^2[{+activate}]^8 To Pick Up Cooked Burger");
	level.cookarea waittill("trigger", player);
	level.cookarea changehintstring("");
	level.burgerpattymodel show();
	level.burgercook hide();
	//video with narration explains the correct order of ingredients
	level.choiceiteration = 0;
	level.cheesespot thread enterorder(level.cheesemodel, "Cheese");
	level.topbunspot thread enterorder(level.topbunmodel, "Top Bun");
	level.bottombunspot thread enterorder(level.bottombunmodel, "Bottom Bun");
	level.burgerpattyspot thread enterorder(level.burgerpattymodel, "Burger Patty");
	level.lettucespot thread enterorder(level.lettucemodel, "Lettuce");
	level thread checkorder();
	break;
	/*/
	Player must go into pantry to find the ingredients beef buns and veggies condiments and the secret ingredient which is out
	but the retard in 237 wont notice
	burger must be cooked which takes a set time like 20 - 30 secs
	during this period zombies infinitly spawn and the round progression is halted
	after this the player must then assemble the burger in order, if they fail to do this a panzer spawns and the player must wait a round to try again
	after this the player can deliver the burger to room 237 where they get a dialouge from the patron thanking them, and they receive some points maybe
	the player can then access the teleporter and packapunch and if they speak to the bartender again an altered version of the deadshot daq dialouge plays
	with deadshot being a secondary reward.
	later the player finds that the secret ingredient of the travis scott burger is zombie souls?
	default dance music for success
	karen for fail
	/*/
}

function changehintstring(user_hint)
{
	self SetCursorHint("HINT_NOICON");
	self SetHintString(""+user_hint);
}

function enterorder(model, hint)
{
	level.firstchoice = 0;
	level.secondchoice = 1;
	level.thirdchoice = 2;
	level.fourthchoice = 3;
	level.fifthchoice = 4;
	level.first = 0;
	level.second = 0;
	level.third = 0;
	level.fourth = 0;
	level.fifth = 0;
	self SetCursorHint("HINT_NOICON");
	self SetHintString("Press ^2[{+activate}]^7 To Choose "+hint);
	self waittill("trigger", player);
	self SetCursorHint("HINT_NOICON");
	self SetHintString("");
	self PlaySound("shortbeep");
	PlayFX(level._effect["powerup_grabbed"], model.origin);
	model hide();
	switch(level.choiceiteration)
	{
		case 0:
		level.first = self.script_int;
		level.choiceiteration ++;
		level waittill("fivechoices");
		PlayFX(level._effect["powerup_grabbed"], self.origin);
		self PlaySound(self.script_sound);
		thread zm_subtitles::subtitle_display(undefined, 3, "ACS", hint);
		wait(1);
		level notify("firstchoiceplayed");
		break;
		case 1:
		level.second = self.script_int;
		level.choiceiteration ++;
		level waittill("firstchoiceplayed");
		PlayFX(level._effect["powerup_grabbed"], self.origin);
		self PlaySound(self.script_sound);
		thread zm_subtitles::subtitle_display(undefined, 3, "ACS", hint);
		wait(1);
		level notify("secondchoice");
		break;
		case 2:
		level.third = self.script_int;
		level.choiceiteration ++;
		level waittill("secondchoice");
		PlayFX(level._effect["powerup_grabbed"], self.origin);
		self PlaySound(self.script_sound);
		thread zm_subtitles::subtitle_display(undefined, 3, "ACS", hint);
		wait(1);
		level notify("thirdchoice");
		break;
		case 3:
		level.fourth = self.script_int;
		level.choiceiteration ++;
		level waittill("thirdchoice");
		PlayFX(level._effect["powerup_grabbed"], self.origin);
		self PlaySound(self.script_sound);
		thread zm_subtitles::subtitle_display(undefined, 3, "ACS", hint);
		wait(1);
		level notify("fourthchoice");
		break;
		case 4:
		level.fifth = self.script_int;
		level.choiceiteration ++;
		level waittill("fourthchoice");
		PlayFX(level._effect["powerup_grabbed"], self.origin);
		self PlaySound(self.script_sound);
		thread zm_subtitles::subtitle_display(undefined, 3, "ACS", hint);
		wait(1);
		level notify("finalchoicemade");
		break;
	}
}

function postplayerfail()
{
	thread zm_subtitles::subtitle_display(undefined, 1, "ACS", "That wasn't the correct order prepare to die...");
	//playsound
	level thread spawnpanzer();
	level flag::set( "zombie_drop_powerups" );
	level flag::set( "spawn_zombies" );
	level.finalburgerinteract thread changehintstring("You FUCKED Up! Burger Station Is Cooling Down");
	wait(30);
	level.finalburgerinteract PlaySound("longbeep");
	level.fxzModel Delete();
	level.fxzzModel Delete();
	level.finalburgerinteract thread changehintstring("Press ^2[{+activate}]^8 To Activate Burger Station");
	level.finalburgerinteract waittill("trigger", player);
	level.finalburgerinteract thread changehintstring("");
	level.cheesemodel thread appearfximmerse();
	level.topbunmodel thread appearfximmerse();
	level.bottombunmodel thread appearfximmerse();
	level.burgerpattymodel thread appearfximmerse();
	level.lettucemodel thread appearfximmerse();
	level.finalburgerinteract thread clearhintstring();
	//level thread killallzs();
	//level flag::clear( "spawn_zombies" );
	level.choiceiteration = 0;
	level.cheesespot thread enterorder(level.cheesemodel, "Cheese");
	level.topbunspot thread enterorder(level.topbunmodel, "Top Bun");
	level.bottombunspot thread enterorder(level.bottombunmodel, "Bottom Bun");
	level.burgerpattyspot thread enterorder(level.burgerpattymodel, "Burger Patty");
	level.lettucespot thread enterorder(level.lettucemodel, "Lettuce");
	level thread checkorder();
	//allow the player to attempt the correct order once again
	break;
}

function autoexec animpowertest()
{
	level flag::wait_till( "power_on" );
	foreach(player in GetPlayers())
	{
		player thread animation::Play("cp_mi_sing_blackstation_water_flail");
	    wait(5);
	    player animation::stop();
	}
}
function dissapearfximmerse()
{
	PlayFX(level.keycarddisappear, self.origin);
	self PlaySound("keycardtelein");
	wait(.2);
	self hide();
}

function appearfximmerse()
{
	PlayFX(level.keycarddisappear, self.origin);
	self PlaySound("keycardtelein");
	wait(.2);
	self show();
}

function checkorder()
{
	//level waittill("finalchoicemade");
	while(1)
	{
		if(level.choiceiteration == 5)
		{
			fxModel = util::spawn_model("tag_origin", level.finalburgerinteract.origin);
			PlayFXOnTag("redspace/fx_launchpad_blue", fxModel, "tag_origin");
			level.finalburgerinteract thread changehintstring("Press ^2[{+activate}]^8 To Confirm Ingredient Order");
			level.finalburgerinteract waittill("trigger", player);
			fxModel Delete();
			level.finalburgerinteract thread clearhintstring();
			wait(0.1);
					if((level.firstchoice == level.first) && (level.secondchoice == level.second) && (level.thirdchoice == level.third) && (level.fourthchoice == level.fourth) && (level.fifthchoice == level.fifth))
					{
						level thread announceorder();
						level waittill("orderannouced");
						thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "That was the correct order!");
						thread speak_to_meemers("defaultdance");
						wait(7.1);
						PlayFX(level._effect["powerup_grabbed"], level.finalburgermodel.origin);
						level.finalburgermodel show();
						level.finalburgerinteract thread changehintstring("Press ^2[{+activate}]^8 To Pick Up Order");
						level.finalburgerinteract waittill("trigger", player);
						level.finalburgerinteract thread changehintstring("");
						player PlaySound("zmb_craftable_pickup");
						level.finalburgermodel Delete();
						level notify("roomservicereadytodeliver");
						//thread deliver script
						//and the announcer says that the burger is ready for the special ingredient but the tape fails, so the burger is delivered as is this is a stroke of luck as big chungus is actually the roomie!
						thread speak_to_meemers("mlg");
						//dialouge from lloyd
						level flag::set( "zombie_drop_powerups" );
						level flag::set( "spawn_zombies" );
						level thread delivertoroomie();
						break;
					}
					else
					{
						level thread announceorder();
						level waittill("orderannouced");
						level.fxzModel = util::spawn_model("tag_origin", level.finalburgermodel.origin);
						level.fxzzModel = util::spawn_model("tag_origin", level.finalburgermodel.origin);
						PlayFXOnTag(level.mushroomcloudfx, level.fxzModel, "tag_origin");
						PlayFXOnTag(level.phdnukefx, level.fxzzModel, "tag_origin");
						thread speak_to_meemers("defaultfail");
						//thread speak_to_meemers("vox_fail_long");
						level thread failsound();
						level thread postplayerfail();
						break;
					}
		}
		else
		{
			wait(0.1);
		}
	}
}

function failsound()
{
	if(level.failtime == 0)
	{
		level.finalburgerinteract PlaySound("vox_fail_longy");
		level.burgerinteract PlaySound("defaultfail");
		thread zm_subtitles::subtitle_display(undefined, 1, "ACS", "Angered long expression");
		level.failtime++;
		break;
	}
	else if(level.failtime == 10)
	{
		foreach(player in GetPlayers())
		{
			player thread dumbassplayer();
		}
		//thread speak_to_meemers("loudnigra");
		wait(5);
		level notify("end_game");
		level.failtime++;
		break;
	}
	else
	{
		level.finalburgerinteract PlaySound("vox_fail_shortz");
		level.burgerinteract PlaySound("defaultfail");
		thread zm_subtitles::subtitle_display(undefined, 1, "ACS", "Angered short expression");
		level.failtime++;
		break;
	}
}

function dumbassplayer()
{
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "susscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("loudnigra");  
	jumpscare_overlay.alpha = 0; 
	wait(.15); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "susscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("loudnigra");  
	jumpscare_overlay.alpha = 0; 
	wait(.25); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "susscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("loudnigra");  
	jumpscare_overlay.alpha = 0; 
}

function announceorder()
{
	level.cheesemodel thread appearfximmerse();
	level.topbunmodel thread appearfximmerse();
	level.bottombunmodel thread appearfximmerse();
	level.burgerpattymodel thread appearfximmerse();
	level.lettucemodel thread appearfximmerse();
	level.finalburgerinteract PlaySound("vox_orderentered");
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "The Entered Order Was....");
	wait(2);
	level notify("fivechoices");
	wait(0.5);
	level waittill("finalchoicemade");
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "The Correct Order Was....");
	level.finalburgerinteract PlaySound("vox_correctorder");
	wait(2);
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Top Bun");
	level.topbunspot PlaySound(level.topbunspot.script_sound);
	PlayFX(level._effect["powerup_grabbed"], level.topbunspot.origin);
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Lettuce");
	level.lettucespot PlaySound(level.lettucespot.script_sound);
	PlayFX(level._effect["powerup_grabbed"], level.lettucespot.origin);
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Burger Patty");
	level.burgerpattyspot PlaySound(level.burgerpattyspot.script_sound);
	PlayFX(level._effect["powerup_grabbed"], level.burgerpattyspot.origin);
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Cheese");
	level.cheesespot PlaySound(level.cheesespot.script_sound);
	PlayFX(level._effect["powerup_grabbed"], level.cheesespot.origin);
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Bottom Bun");
	level.bottombunspot PlaySound(level.bottombunspot.script_sound);
	PlayFX(level._effect["powerup_grabbed"], level.bottombunspot.origin);
	wait(1);
	level notify("orderannouced");
	level.cheesemodel thread dissapearfximmerse();
	level.topbunmodel thread dissapearfximmerse();
	level.bottombunmodel thread dissapearfximmerse();
	level.burgerpattymodel thread dissapearfximmerse();
	level.lettucemodel thread dissapearfximmerse();
}

function delivertoroomie()
{
	level.chungusfly = GetEntArray("chungus_float","targetname");
	level.cutscenetrackstart = GetEnt("cutscenetrack", "targetname");
	level.cutscenetrackend = GetEnt(level.cutscenetrackstart.target, "targetname");
	level.roomservicedeliver changehintstring("Press ^1^2[{+activate}]^8 To Deliver Roomservice");
	level.roomservicedeliver show();
	level.roomservicedeliver waittill("trigger", player);
	wait(0.1);
	level.roomservicedeliver clearhintstring();
	level.roomservicedeliver hide();
	level.questcomplete = 2;
	//IPrintLnBold("ROOMSERVICE DELIVERED PAP NOW AVALIBLE");
	level thread killallzs();
	level flag::clear( "spawn_zombies" );
	level thread dooropensequence();
	foreach(player in GetPlayers())
	{
		player thread playercutscene();
	}
	level thread chungusscarefunc();
	level waittill("cutsceneover");
	level flag::set( "spawn_zombies" );
	//playsound here
	//cinematic cutscene
}

function chungusscarefunc()
{
	level waittill("playerinlair");
	thread zm_subtitles::subtitle_display(undefined, 3, "^5Unknown", "hello");
	wait(2);
	thread zm_subtitles::subtitle_display(undefined, 3, undefined, "seems like you got my order wrong.");
	wait(2);
	thread zm_subtitles::subtitle_display(undefined, 3, undefined, "seems like you got my order wrong.");
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 3, undefined, "find the missing part of the tape.");
	foreach(chungus_float in level.chungusfly)
	{
	chungus_float MoveZ(-5, 0.8);
	chungus_float MoveY(717, 2);
	}
	wait(2.1);
	level notify("chungusscream");
	wait(1);
	level notify("chungusscare");
	
}

function playercutscene()
{
		chunguslair = struct::get_array("chungusscaryroom_player","targetname");
		chunguscinematic1 = struct::get_array( "chunguscinematicpos1", "targetname" );
		self DisableWeapons();
        self DisableOffhandWeapons();
		self EnableInvulnerability();
        self SetOrigin(chunguscinematic1[self.characterIndex].origin);
        self SetPlayerAngles(chunguscinematic1[self.characterIndex].angles);
        PlayFX(level.oildisappear, self.origin);
        self FreezeControls(true);
        wait(1.5);
        self notify("stop_player_out_of_playable_area_monitor");
        playerenttrack = Spawn("script_origin", self.origin);
        self PlayerLinkToDelta(playerenttrack, "tag_origin");
        playerenttrack MoveTo(level.cutscenetrackstart.origin, 2);
        //
        //wait(2);
        playerenttrack MoveTo(level.cutscenetrackend.origin, 1);
        //wait(.8);
        self unlink();
		playerenttrack delete();
        self SetOrigin(chunguslair[self.characterIndex].origin);
        self SetPlayerAngles(chunguslair[self.characterIndex].angles);
        self FreezeControls(true);
        level notify("playerinlair");
        level waittill("chungusscream");
        self PlayLocalSound("scaryscream");
        level waittill("chungusscare");
        self SetOrigin(chunguscinematic1[self.characterIndex].origin);
        self SetPlayerAngles(chunguscinematic1[self.characterIndex].angles);
        self FreezeControls(true);
        PlayFX(level.oildisappear, self.origin);
        thread zm_subtitles::subtitle_display(undefined, 3, "^1Patron^7", "If you are gonna freak out somewhere, can you not do it in front of my room please");
        //player DisableInvulnerability();
		//cin_1 = struct::get("cinematic_struct", "targetname");
		//cin_1look = struct::get("cinematic_structz", "targetname");
        //self CameraSetPosition(self GetTagOrigin("j_head"), self GetAngles());
        //self CameraActivate(true);
        //distance = Distance(self GetTagOrigin("j_head"), cin_1.origin);
        //time = 12.5;
        //time = 10;
        //self StartCameraTween(time);
        //self CameraSetPosition(cin_1.origin);
       //self CameraSetLookAt(self GetTagOrigin("j_head"));
        //wait(time);
        //player StartCameraTween(3);
        //player CameraSetPosition(player.origin, player GetAngles());
        //player CameraSetLookAt(player GetTagOrigin("j_head"));
        //wait(3);
        //player DisableInvulnerability();
        self thread zm::player_out_of_playable_area_monitor();
        self FreezeControls(false);
        //self CameraActivate(false);
        self DisableInvulnerability();
        self EnableWeapons();
        self EnableOffhandWeapons();
        self thread teleport_aftereffect_fov();
        self shellshock( "explosion", 4 );
        self shellshock( "electrocution", 4 );
        level notify("cutsceneover");
}

function teleport_aftereffect_fov()
{
	util::setClientSysState( "levelNotify", "tae", self );
}

/*/
function suckedin()
{
	vehicle_path_start = GetVehicleNode("playersuckin", "targetname");
	self.vehicle = SpawnVehicle("veh_default_zipline",(0,0,0),(0,0,0));
	self.vehicle SetIgnorePauseWorld(1);
	self HideViewModel();
	self util::magic_bullet_shield();
	self FreezeControls(1);
	self AllowSprint(0);
	self AllowJump(0);
	self DisableWeapons();
	self SetPlayerAngles(vehicle_path_start.angles);
	self.vehicle.origin = vehicle_path_start.origin;
	self.vehicle.angles = vehicle_path_start.angles;
	self SetOrigin(self.vehicle GetTagOrigin("tag_zipline"));self.vehicle.e_parent = self;
	self.vehicle SetSpeed("playersuckin",1000);
	self.vehicle vehicle::get_on_path(vehicle_path_start);
	self PlayerLinkToDelta(self.vehicle, "tag_zipline", 1, 70, 70, 15, 60);
	wait(.05);
	self thread animation::Play("cp_mi_sing_blackstation_water_flail");
	self.model_linked unlink();
	self.model_linked Delete();
	self ShowViewModel();
	self.vehicle vehicle::go_path();
	self.vehicle notify("finish_path");
	self Unlink();
	self animation::stop();
	self notify("vehicle_over");
	self util::stop_magic_bullet_shield();
	self FreezeControls(0);
	self AllowSprint(1);
	self AllowJump(1);
	self enableWeapons();
	wait (2);
}
/*/

function dooropensequence()
{
	level.roomdoor RotateYaw(90, 1.2);
	level waittill("chungusscare");
	level.roomdoor RotateYaw(-90, 0.8);
	IPrintLnBold ("ACT I");
}

function killallzs()
{
	zombies = GetAiSpeciesArray( level.zombie_team, "all" );
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
}

function clearhintstring()
{
	self SetCursorHint("HINT_NOICON");
	self SetHintString("");
}

function infinitesprintersspawn()
{
	while(1)
	{
		level endon("cookcompleted");
		zombie_utility::set_zombie_run_cycle( "super_sprint" );
		e_ai = zombie_utility::spawn_zombie( level.zombie_spawners[ 0 ] );
        e_ai._rise_spot = array::random( struct::get_array( "start_zone_spawners", "targetname" ) );
        e_ai.ignore_enemy_count = 1;
        wait(1.5);
	}
}

function spawnpanzer()
{
	//play sound here
	wait(2);
	e_ai = zm_ai_mechz::spawn_mechz(500);
	//e_ai = zm_ai_mechz::spawn_mechz(500);
	e_ai._rise_spot = array::random( struct::get_array( "start_zone_spawners", "targetname" ) );
    e_ai.ignore_enemy_count = 1;
}

function spawnfood()
{
	while(true)
	{
		level.kitchendetect waittill("trigger", player);
		if(level flag::get("cheese_flag") && level flag::get("topbun_flag") && level flag::get("patty_flag") && level flag::get("bottombun_flag") && level flag::get("lettuce_flag"))
		{
			level notify("burgergameactivate");
			level thread whitescreenflash();
			break;
		}
		else
		{
			//IPrintLnBold("Looks like you are missing some items");
			thread zm_subtitles::subtitle_display(undefined, 3, "ACS", "Looks like you are missing some items");
			wait(5);
		}
	}
}

function burgerparts(flag, hint, part, otherpart)
{
	self SetCursorHint("HINT_NOICON");
	self SetHintString("");
	part = GetEnt(self.target, "targetname");
	part hide();
	otherpart hide();
	level waittill("burgergamepartspawn");
	part show();
	self SetCursorHint("HINT_NOICON");
	self SetHintString("Press &&1 to pickup "+hint);
	self waittill("trigger", player);
	level flag::set(flag);
	player PlaySound("zmb_craftable_pickup");
	wait(0.1);
	PlayFX(level._effect["powerup_grabbed"], self.origin);
	otherpart show();
	part Delete();
	self Delete();
}


function pantrydoorunlock()
{
	level.keycardpantryreader TriggerEnable(true);
	level.keycardpantryreader SetHintString("Press ^2[{+activate}]^7 To Unlock Pantry");
	level.keycardpantryreader SetCursorHint("HINT_NOICON");
	level.keycardpantryreader waittill("trigger", player);
	level.keycardpantryreader TriggerEnable(false);
	level.keycardpantryreader SetHintString("");
	level.keycardpantryreader SetCursorHint("HINT_NOICON");
	level.keycardpantry show();
	PlayFX(level.keycarddisappear, level.keycardpantry.origin);
	level.keycardpantry PlaySound("keycardtelein");
	wait(.2);
	level.keycardpantry MoveX (-15, 1.5);
	wait(1.2);
	level.keycardpantryreader PlaySound("longbeep");
	wait(.3);
	PlayFX(level.keycarddisappear, level.keycardpantry.origin);
	level.keycardpantry PlaySound("keycardtelein");
	wait(.2);
	level.keycardpantry hide();
	wait(1);
	level.keycardpantrydoor PlaySound("safe_door_unlock");
	level.keycardpantrydoor RotateYaw(-135, 1.2);
	level.keycardpantrydoorclip EnableLinkTo();
	level.keycardpantrydoorclip LinkTo(level.keycardpantrydoor);
	level thread spawnfood();
	level.questcomplete = 1;
}

function whitescreenflash()
{
	foreach(player in GetPlayers())
	{
		player thread playerscreenfash();
	}
}

function playerscreenfash()
{
	speak_to_meemers("success");
	self thread lui::screen_flash( 0.2, 0.1, .5, .87, "white" );
}

function keycarddetect()
{
	PlayFX(level.teleporterdoorfxtest, level.teleporterdoorfx.origin);
	while(1)
	{
	level.teleportdoortrigger waittill("trigger", player);
		if (level.questcomplete == 0)
		{
			//IPrintLnBold ("This area requires an employee keycard.");
			thread zm_subtitles::subtitle_display(undefined, 3, "^0The Hotel", "This area requires an employee keycard.");
			PlaySoundAtPosition("aetherdoorfail", level.teleportdoortrigger.origin);
			//play sound error beep
			//play dialouge
			wait(3);
			continue;
		}
		else if(level.questcomplete == 1)
		{
			//IPrintLnBold ("You'll have to deliver that roomservice for access, friend.");
			thread zm_subtitles::subtitle_display(undefined, 3, "^0The Hotel", "You'll have to deliver that roomservice for access, friend.");
			PlaySoundAtPosition("aetherdoorfail", level.teleportdoortrigger.origin);
			//play sound error beep
			//play dialouge
			wait(3);
			continue;
		}
		else if(level.questcomplete == 2)
		{
			//IPrintLnBold ("This area is now unlocked, welcome.");
			thread zm_subtitles::subtitle_display(undefined, 3, "^0The Hotel", "This area is now unlocked, welcome.");
			PlaySoundAtPosition("aetherdoorunlock", level.teleportdoortrigger.origin);
			//play dialouge
			//play unlock sound
			//door clip delete
			//door fx model delete
			//play delete fx
			level.teleportdooorclip Delete();
			level.fxmodelteleporterdoor Delete();
			level thread bartenderextrareward();
			level thread linkpadreveal();
			break;
		}
	}
}

function linkpadreveal()
{
 	//level.revealboxes = GetEntArray("revealbox","targetname");
	//level.revealboxesclip = GetEnt("boxdebrisclip","targetname");
	//level.revealboxestrigger = GetEnt("powerboxesgobyebye","targetname");
	level.flytarget = GetEnt("powerboxdebrisskytarget","targetname");
	level notify("teleporterdoorunlocked");
	level.revealboxestrigger waittill("trigger", player);
	wait(0.2);
	level.revealboxesclip Delete();
	level.revealboxestrigger PlaySound("lightningdoor");
	foreach(revealbox in level.revealboxes)
	{
		//revealboxtarget = GetEnt(revealbox.target, "targetname");
		PlayFX(level._effect["poltergeist"], revealbox.origin);
		//revealbox MoveTo(level.flytarget.origin, 2);
		revealbox MoveZ(25, 1);
		revealbox MoveZ(800, 1);
	}
	wait(2);
	foreach(revealbox in level.revealboxes)
	{
		revealbox Delete();
	}
}

function speak_to_meemers( sound )
{
    players = Getplayers(); 
    foreach( player in players )
    {
        player StopLocalSound( "nsz_banana_song" );
        player PlayLocalSound( sound ); 
    }
}

function bartenderextrareward()
{
daqs = GetEntArray("daq","targetname");
level.bartenderdetectinteract TriggerEnable(true);
level.bartenderdetectinteracts SetHintString("Press ^2[{+activate}]^8 To Ask Lloyd What He Drinking");
level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
level.bartenderdetectinteracts waittill("trigger", player);
//PlaySoundAtPosition( "nowigottadrinkemall", level.bartenderdetectinteracts.origin );
level.bartenderdetectinteracts PlaySound("nowigottadrinkemall");
level.bartenderdetectinteracts SetHintString("");
thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "This Gulag Peterson Guy Placed An Order For A Full Case Of Deadshot And Didn't Pick Em Up, Now I Gotta Drink Em All");
level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
wait(8);
//PlaySoundAtPosition( "theyfuckingsuck", level.bartenderdetectinteracts.origin );
level.bartenderdetectinteracts PlaySound("theyfuckingsuck");
//level.bartenderdetectinteracts SetHintString("You Really Want One? They Fucking Suck");
thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "You Really Want One? They Fucking Suck");
wait(5);
level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
level.bartenderdetectinteracts PlaySound("enjoyitkitten");
level.bartenderdetectinteracts SetHintString("Press ^2[{+activate}]^8 To Claim");
thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "You go ahead and enjoy that kitten.");
level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
for(i=0;i<daqs.size;i++)
  {
  	level.bartenderdetectinteracts waittill("trigger", player);
  	daqs[i] Delete();
  	player thread drinkdaqbrynjar();
  }
//level.bartenderdetectinteracts SetHintString("Looks like you drank em all, haha, wasn't expecting that");
level.bartenderdetectinteracts SetHintString("");
thread zm_subtitles::subtitle_display(undefined, 2, "Lloyd", "Looks like you drank em all, haha, wasn't expecting that");
level.bartenderdetectinteracts SetCursorHint("HINT_NOICON");
level notify("daqsdrinken");
}

function drinkdaqbrynjar()
{
  //self clientfield::set_to_player( "deadshot_perk", 1);
  self zm_perks::vending_trigger_post_think( self, "specialty_deadshot" );
  self zm_perks::give_perk( "specialty_deadshot", true );
  wait(4);
}

function autoexec randomchatter()
{
	level waittill("daqsdrinken");//game waits till all perks have been drank
	while(true)//
	{
		level endon("intermission");
		wait(35);
		level.bartenderdetect waittill("trigger", player);
		wait(6);
		level.randomchatterchance = RandomInt(4);
		if(level.randomchatterchance == 2)
		{
			level.llyodchatterselect = RandomInt(5);
			wait(1);
			level.bartenderdetectinteracts PlaySound("lloydchatter_"+level.llyodchatterselect);
			wait(20);
			continue;
		}
		else
		{
			wait(1);
			continue;
		}
	}
}

