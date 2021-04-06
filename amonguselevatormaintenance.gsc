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

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_ai_mechz;
#using scripts\shared\ai\zombie_utility;
#using scripts\zm\_zm_ai_dogs;
#using scripts\shared\lui_shared;
#using scripts\Sphynx\_zm_subtitles;

#using scripts\zm\zm_chilis;
#using scripts\_NSZ\roomserviceeasteregg;
#using scripts\_redspace\rs_o_jump_pad;
#using scripts\zm\_zm_ai_mechz;


function autoexec init_maintenance()
{
	IPrintLnBold ("maintenance active");
	level.elevatorcogmain = GetEnt("elevator_cog_quest", "targetname"); 
	level.elevatorcog1 = GetEnt("elevator_cog_1", "targetname");
	level.elevatorcog2 = GetEnt("elevator_cog_2", "targetname");
	level.elevatorcogtrig = GetEnt("elevator_cog_quest_trig", "targetname"); 
	level.maintenancetrig = GetEnt("maintenanceroomtrig", "targetname"); 
	level.maintenanceentertrig = GetEnt("maintenanceentrance", "targetname"); 
	level.elevatorcogpickup = GetEnt("cogitempickup", "targetname");
	level.elevatorcogpickuptrig = GetEnt("cogitempickuptrig", "targetname"); 
	level.amongusinteract = GetEnt("amongusinteractspeak", "targetname");
	level.amongusguy = GetEnt("amongusguy", "targetname");
	level.amongusguy2 = GetEnt("amongusguy2", "targetname");
	level.amongusguyclip = GetEnt("amongusguyclip", "targetname");
	level.maintenancedoor = GetEnt("maintenancedoorswing", "targetname");
	level.maintenancedoorclip = GetEnt("maintenancedoorswingclip", "targetname"); 
	level.oillaunchcheck = GetEnt("oil_launch_check", "targetname");
	level.elevatormotoree = GetEnt("elevatormotoree", "targetname");
	level.dripshoes = GetEnt("drip_shoes","targetname");
	level.pickupdrip = GetEnt("pickupdrip","targetname");
	level.wearshoes = GetEnt("drip_shoe_right","targetname");
	level.wearshoes2 = GetEnt("drip_shoe_left","targetname");
	level.wearshoesc = GetEnt("drip_shoe_right2","targetname");
	level.wearshoesc2 = GetEnt("drip_shoe_left2","targetname");
	//hint strings
	level.oillaunchcheck SetHintString("Oil is required to fly. Dumbass");
	level.oillaunchcheck SetCursorHint("HINT_NOICON");
	level.amongusinteract SetHintString("");
	level.amongusinteract UseTriggerRequireLookAt();
	level.elevatorcogpickuptrig UseTriggerRequireLookAt();
	level.pickupdrip UseTriggerRequireLookAt();
	level.elevatorcogtrig UseTriggerRequireLookAt();
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.elevatorcogpickuptrig SetHintString("");
	level.elevatorcogpickuptrig SetCursorHint("HINT_NOICON");
	level.elevatorcogtrig SetHintString("");
	level.elevatorcogtrig SetCursorHint("HINT_NOICON");
	level.amongustime = 3;
	level.elevatorcogmain hide();
	level.amongusguy2 hide();
	level thread powerwait();
	level thread amongus();
	level thread amongus2();
	level thread cog_immersion();
	level.dripshoes hide();
	level.wearshoes hide();
	level.wearshoes2 hide();
	level.wearshoesc hide();
	level.wearshoesc2 hide();
	shoes = GetEntArray("thedrip", "script_noteworthy");
	thread random_spawn(shoes, "secure_drip_flag", "p7_54i_gear_shoes_red", "The Drip");
}

function random_spawn(parts, flag, model, hint){
	r = RandomInt(parts.size);
	foreach(part in parts){
		part_model = GetEnt(part.target, "targetname");
		if(part == parts[r]){
			part thread part_pickup(flag, hint, part_model);
		}else{
			part_model Delete();
			part Delete();
		}
	}
	//Takes in the parts[] array, and flags, you send from your
	//buildable function. The parts array is an array of triggers
	//left behind from stamping a 'random spawn point' - prefab
	//The function then chooses a random trigger to save, and deletes 
	//the rest of the unused triggers and the script_models they're targeting
	//Part pick-up logic is threaded last, right before deleting all
	//the spawn locations of the random parts that weren't chosen to spawn
}

  ///////////////////////////////////////
 //        PART PICKUP LOGIC          //
///////////////////////////////////////
function part_pickup(flag, hint, part)
{
	self SetCursorHint("HINT_NOICON");
	self SetHintString("");
	part hide();
	self hide();
	level waittill("timetofinddrip");
	PlayFX(level._effect["powerup_grabbed"], self.origin);
	part show();
	self show();
	self SetCursorHint("HINT_NOICON");
	self SetHintString("Press &&1 to pickup "+hint);
	self waittill("trigger", player);
	IPrintLnBold ("^2"+player.playername+" ^7Picked up ^6The Drip");
	level flag::set(flag);
	player PlaySound("part_pickup");
	wait(0.1);
	PlayFX(level._effect["powerup_grabbed"], self.origin);
	part Delete();
	self Delete();
	level notify("dripsecuredhomie");
}


function powerwait()
{
	level flag::wait_till( "power_on" );
	foreach (player in GetPlayers())
	{
		earthQuake(.6, 5, player.origin, 200);
	}
	PlayFX(level._effect["powerup_grabbed"], level.elevatorcogmain.origin);
	foreach( player in GetPlayers())
    {
        player PlayLocalSound("explosionelevator"); 
        thread zm_subtitles::subtitle_display(undefined, 3, "^0Chili's", "*large explosion*");
    }
	wait(3);
	foreach( player in GetPlayers())
    {
        player PlayLocalSound("elevatordamageddialouge"); 
        thread zm_subtitles::subtitle_display(undefined, 2, "The OG Memer", "Jesus Christ what the hell was that? Oh great it was the elevator, we need to find a way into the maintenance room.");
    }
	level thread startmaintenance();
}

function amongus()
{
	while(1)
	{
		self endon("power_on");
		level.amongusinteract SetHintString("Press ^3&&1^7");
		level.amongusinteract SetCursorHint("HINT_NOICON");
		level.amongusinteract waittill ("trigger", player);
		//IPrintLnBold ("Still haven't turned the power on? That's Awfully SUS");
		thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "You still haven't turned the power on? That's Awfully SUS");
		PlaySoundAtPosition("vox_powerz", level.amongusguy.origin);
		level.amongusinteract SetHintString("");
		wait(4);
		level.amongusinteract SetHintString("Press ^3&&1^7");
		level.amongusinteract waittill ("trigger", player);
		thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "Can you just get your tasks done?");
		//IPrintLnBold ("Do Your TASKS");
		PlaySoundAtPosition("vox_tasksz", level.amongusguy.origin);
		level.amongusinteract SetHintString("");
		wait(level.amongustime);
		level.amongusinteract SetHintString("Press ^3&&1^7");
		level.amongusinteract waittill ("trigger", player);
		//IPrintLnBold ("Amog us");
		thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "amogus");
		PlaySoundAtPosition("vox_amogusz", level.amongusguy.origin);
		level.amongusinteract SetHintString("");
		wait(level.amongustime);
	}
}

function amongus2()
{
	level flag::wait_till( "power_on" );
	wait(1);
	level.amongusinteract SetHintString("Press ^3&&1^7 To Ask Him To Move");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.amongusinteract waittill ("trigger", player);
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "Why you trying to get in here? That's pretty sus man.");
	//IPrintLnBold ("Why you trying to get in here? That's pretty sus man.");
	PlaySoundAtPosition("vox_prettysusz", level.amongusguy.origin);
	level.amongusinteract SetHintString("");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	wait(2);
	//IPrintLnBold ("Who TF is this");
	wait(level.amongustime);
	level.amongusinteract SetHintString("Press ^3&&1^7 To Continue");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.amongusinteract waittill ("trigger", player);
	//IPrintLnBold ("What does a ******** like you want to do in the maintenance room?");
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "What does a ******** like you want to do in the maintenance room?");
	PlaySoundAtPosition("vox_mongoz", level.amongusguy.origin);
	level.amongusinteract SetHintString("");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	wait(2);
	//IPrintLnBold ("This guy is a waste of time, we need to find another way in");
	wait(level.amongustime);
	level.amongusinteract SetHintString("Press ^3&&1^7 To Continue");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.amongusinteract waittill ("trigger", player);
	//IPrintLnBold ("I'll tell you what, if you can find me my drip i'll let you through");
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "I'll tell you what, if you can find me my drip i'll let you through");
	PlaySoundAtPosition("vox_dripz", level.amongusguy.origin);
	level.amongusinteract SetHintString("");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	//level thread findthedrip();
	level notify("timetofinddrip");
	level thread findthedrip();
}

function announceoilsafecode(firstcode, secondcode, thirdcode)
{
	level waittill("startannouncecodeamogus");
	wait(1);
	level.amongusguy PlaySound("vox_thecodeis");
	//IPrintLnBold ("The Code Is...");
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "The Code Is...");
	wait(1);
	level notify("unhidehint1amog");
	level.amongusguy PlaySound("vox_code_"+firstcode);
	//IPrintLnBold (firstcode);
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, firstcode);
	wait(1.5);
	
	level notify("unhidehint2amog");
	level.amongusguy PlaySound("vox_code_"+secondcode);
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, secondcode);
	wait(1.5);
	
	level notify("unhidehint3amog");
	level.amongusguy PlaySound("vox_code_"+thirdcode);
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, thirdcode);
	wait(1.5);

	level notify("amoguscodeannounced");
}

function findthedrip()
{
	level waittill("dripsecuredhomie");
	level.amongusinteract SetHintString("Press ^3&&1^7 To Return The Drip");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.amongusinteract waittill ("trigger", player);
	level.amongusinteract SetHintString("");
	level.amongusinteract SetCursorHint("HINT_NOICON");
	level.wearshoes show();
	level.wearshoes2 show();
	PlayFX(level._effect["powerup_grabbed"], level.wearshoes.origin);
	PlayFX(level._effect["powerup_grabbed"], level.wearshoes2.origin);
	//level.amongusguy PlaySound("amongdripevt");
	level thread amongdrip();
	level.amongusguy PlaySound("vox_dripfoundz");
	//IPrintLnBold ("Wow is that my drip?! Cool!");
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "Wow is that my drip?! Cool!");
	//PlaySoundAtPosition("vox_dripfoundz", level.amongusguy.origin);
	wait(3);
	level.amongusguy PlaySound("vox_finalz");
	//IPrintLnBold ("This door opens from the other side loser.");
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, "This door opens from the other side loser.");
	wait(2);
	//IPrintLnBold ("You need to get in through the skylight.");
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, "You need to get in through the skylight.");
	wait(2);
	//IPrintLnBold ("You'll have to fly to get in but fear not, I have the code to the manager's oilsafe.");
	thread zm_subtitles::subtitle_display(undefined, 1, undefined, "You'll have to fly to get in but fear not, I have the code to the manager's oilsafe.");
	//PlaySoundAtPosition("vox_finalz", level.amongusguy.origin);
	wait(4.5);
	level notify("startannouncecodeamogus");
	level waittill("amoguscodeannounced");
	level.amongusguy PlaySound("vox_finalz2");
	//IPrintLnBold ("You will need to cover yourself in oil, but its up to you to figure that out");
	thread zm_subtitles::subtitle_display(undefined, 1, "Amogus", "You will need to cover yourself in oil, but its up to you to figure that out");
	wait(5);
	level notify("amongusconvo");
}

function amongdrip()
{
	wait(29.8);
	PlayFX(level._effect["powerup_grabbed"], level.amongusguy.origin);
	//PlaySoundAtPosition("comicalnoise", level.amongusguy.origin);
	level.wearshoesc show();
	level.wearshoesc2 show();
	level.wearshoes Delete();
	level.wearshoes2 Delete();
	level.amongusinteract Delete();
	level.amongusguy Delete();
	level.amongusguyclip Delete();
	level.amongusguy2 show();
}

function startmaintenance()
{
 	level waittill ("playercoveredinoil");
 	level.oillaunchcheck Delete();
 	//IPrintLnBold ("Wait, oil? that all works out perfectly");
 	thread zm_subtitles::subtitle_display(undefined, 2, "The OG Memer", "Wait, oil? that all works out perfectly");
 	level.maintenancetrig waittill ("trigger", player);
 	//IPrintLnBold ("You still alive in there? that looked like a hard landing");
 	thread zm_subtitles::subtitle_display(undefined, 2, "The OG Memer", "You still alive in there? that looked like a hard landing");
 	wait(.5);
 	//IPrintLnBold ("Looks like one of the cogs is missing");
 	thread zm_subtitles::subtitle_display(undefined, 2, undefined, "Looks like one of the cogs is missing");
 	level thread cog_quest();
}

function cog_quest()
{
	level.elevatorcogpickuptrig SetHintString("Press ^3&&1^7 To Pickup Replacement Cog");
	level.elevatorcogpickuptrig SetCursorHint("HINT_NOICON");
	level.elevatorcogpickuptrig waittill ("trigger", player);
	player PlaySound("part_pickup");
	PlayFX(level._effect["powerup_grabbed"], level.elevatorcogpickup.origin);
	level.elevatorcogpickuptrig Delete();
	level.elevatorcogpickup Delete();
	wait(0.5);
	level.elevatorcogtrig SetHintString("Press ^3&&1^7 To Place Cog");
	level.elevatorcogtrig SetCursorHint("HINT_NOICON");
	level.elevatorcogtrig waittill ("trigger", player);
	player PlaySound("build_done");
	PlayFX(level._effect["powerup_grabbed"], level.elevatorcogmain.origin);
	level.elevatorcogtrig Delete();
	level.elevatorcogmain show();
	level.elevatorcogmain RotatePitch(375, 10);
	level.elevatorcog1 RotatePitch(375, 10);
	level.elevatorcog2 RotatePitch(375, 10);
	level.elevatormotoree PlayLoopSound("mechanical_whirring");
	wait(1);
	PlaySoundAtPosition("dooropen", level.maintenancedoor.origin);
	level.maintenancedoor RotateYaw(275, 1);
	level.maintenancedoorclip Delete();
	level notify("maintenancecomplete");
	//IPrintLnBold ("Ah elevator looks sounds like its working again");
	thread zm_subtitles::subtitle_display(undefined, 2, "The OG Memer", "Ah elevator looks sounds like its working again");
	wait(1);
	level notify("amonguskilled");
	//IPrintLnBold ("Give it a try, all players must be present");
	thread zm_subtitles::subtitle_display(undefined, 2, undefined, "Give it a try, all players must be present");
}

function cog_immersion()
{
	while(1)
	{
		level endon("end_game");
		level waittill ("Elevator_Used");
		level.elevatorcogmain RotatePitch(375, 10);
		level.elevatorcog1 RotatePitch(375, 10);
		level.elevatorcog2 RotatePitch(375, 10);
	}
}

