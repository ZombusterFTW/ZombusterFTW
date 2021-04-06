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
#precache("fx", "destruct/fx_dest_paper");
#precache("fx", "dlc1/castle/fx_mech_dmg_sparks");
#precache("fx", "dlc3/stalingrad/fx_steam_door"); 
#precache("fx", "dlc5/cosmo/fx_light_red_vista_sm");
#precache("fx", "dlc5/temple/fx_ztem_meteor_shrink");
#precache("fx", "dlc3/stalingrad/fx_voice_log_blue");
#precache("fx", "zombie/fx_ee_apothigod_beam_success_zod_zmb");
#precache("fx", "dlc1/castle/fx_elec_exp_blue");
#precache( "fx", "dlc1/castle/fx_elec_teleport_flash_sm" );

#precache( "material", "eral" );
#precache( "material", "pigman_jumpscare" );
#precache( "material", "rhettscare" );
#precache( "material", "stuffmanscare" );
#precache( "material", "number2oil" ); 
#precache( "material", "amongscare" );
#precache( "material", "susscare" );
#precache( "material", "trollscare" );
#precache( "material", "zuck153jumpscare" );

#precache("model", "partyhat");
#precache("model", "p7_bezoz_photo_ee");
#precache("model", "p7_elon_photo_ee");
#precache("model", "p7_tiktok_photo_ee");
#precache("model", "p7_rdj_photo_ee");
#precache("model", "p7_19dolla_photo_ee");
#define KINO_SWIRL2                                  "dlc5/tomb/fx_teleport_1p"
#precache( "fx", KINO_SWIRL2 );



#namespace jumpscare; 


function autoexec birthday()
{
	//finalinteractitems
	level flag::init("bezos_flag", false);
	level flag::init("totem153_flag", false);
	level flag::init("unkowntotem_flag", false);
	level flag::init("bezos_flagpickup", false);
	level flag::init("zucktotem153_flagpickup", false);
	level flag::init("unkowntotem_flagpickup", false);
	level.unknownfinaltotem = GetEnt("unknownfinal","targetname");
	level.bezozfinaltotem = GetEnt("19dollafinaltotem","targetname");
	level.a153finaltotem = GetEnt("153zuckfinaltotem","targetname");
	level.bezozfinaltotemtrig = GetEnt("bezozfinalinteract","targetname");
	level.a153finaltotemtrig = GetEnt("153finalinteract","targetname");
	level.unknownfinaltotemtrig = GetEnt("unknownfinalinteract","targetname");
	level.bezozfinaltotemtrig UseTriggerRequireLookAt();
	level.a153finaltotemtrig UseTriggerRequireLookAt();
	level.unknownfinaltotemtrig UseTriggerRequireLookAt();
	level.walterwhiteheadmod = GetEnt("walterwhitehead", "targetname");
	level.walterwhiteheadmodpickup = GetEnt("walterwhiteheadpickup", "targetname");
	level.walterwhiteheadmodpickup SetHintString("Press ^2[{+activate}]^7 To Pickup Head Of Walter Whitey");
	level.walterwhiteheadmodpickup hide();
	level.walterwhiteheadmod hide();
	//
	level.unknownfinaltotemtrig SetHintString("Press ^2[{+activate}]^7 To Place Head Of Walter Whitey");
	level.a153finaltotemtrig SetHintString("Press ^2[{+activate}]^7 To Place The 153 Zuck Totem");
	level.bezozfinaltotemtrig SetHintString("Press ^2[{+activate}]^7 To Place The 19 Dolla Bezoz Totem");
	level.bezozfinaltotemtrig Show();
	level.unknownfinaltotemtrig Show();
	level.unknownfinaltotemtrig thread finaldropoff("unkowntotem_flagpickup",level.unknownfinaltotem, "spot3placed", "unkowntotem_flag");
	level.a153finaltotemtrig thread finaldropoff("zucktotem153_flagpickup",level.a153finaltotem, "spot1placed", "totem153_flag");
	level.bezozfinaltotemtrig thread finaldropoff("bezos_flagpickup", level.bezozfinaltotem, "spot2placed","bezos_flag");
	level.unknownfinaltotemtrig UseTriggerRequireLookAt();
	level.a153finaltotemtrig UseTriggerRequireLookAt();
	level.bezozfinaltotemtrig UseTriggerRequireLookAt();
	//
	level.unknownfinaltotem Hide();
	level.bezozfinaltotem Hide();
	level.a153finaltotem Hide();
	level.bezozfinaltotemtrig Hide();
	level.a153finaltotemtrig Hide();
	level.unknownfinaltotemtrig Hide();
	//finalinteractitems
	//miniphotoee
	level.photocenter = GetEnt("centerphotoee","targetname");
	level.photoright = GetEnt("rightphotoee","targetname");
	level.photoleft = GetEnt("leftphotoee","targetname");
	level.photomintrigs = GetEntArray("photominiee","targetname");
	level.photodetectplayer = GetEnt("photoplayerdetect", "targetname");
	level.photocentertrig SetHintString("");
	level.photorighttrig SetHintString("");
	level.photolefttrig SetHintString("");
	level.a19dollatotem = GetEnt("19dollatotem","targetname");
	level.a19dollatotempickup = GetEnt("19dollatotempickup","targetname");
	level.a19dollatotempickup SetHintString("");
	level.a19dollatotempickup hide();
	level.a19dollatotem hide();
	//miniphotoee
	//153 clock ee
	level.clock1 = GetEntArray("153clockspotsdining1", "targetname");
	level.clock2 = GetEntArray("153dining2spots", "targetname");
	level.clock3 = GetEntArray("153clockspots3dining", "targetname");
	level.clock4 = GetEntArray("153clock4dining", "targetname");
	level.clock1hotel = GetEntArray("clock5spots", "targetname");
	level.clock2hotel = GetEntArray("clock6spot", "targetname");
	level.clock3hotel = GetEntArray("hotelclock2spots", "targetname");
	//
	level.clock1fx = GetEnt("clockmodel1","targetname");
	level.clock2fx = GetEnt("clockmodel2","targetname");
	level.clock3fx = GetEnt("clockmodel3","targetname");
	level.clock4fx = GetEnt("clockmodel4","targetname");
	level.clock5hotelfx = GetEnt("oldclockfx1","targetname");
	level.clock6hotelfx = GetEnt("oldclockfx2","targetname");
	level.clock7hotelfx = GetEnt("oldclockfx3","targetname");
	//
	level.zuckrisetrigger = GetEnt("zuckrisetrigger", "targetname");
	level.zuckpillar = GetEnt("zuckpillar", "targetname");
	level.zucktrig = GetEnt("zucktrigger", "targetname");
	level.zucktrig SetHintString("Press ^2[{+activate}]^7 To Pickup The 153 Zuck Totem");
	level.zuckpilltop = GetEnt("zuckpilltop", "targetname");
	level.zuckpilltop EnableLinkTo();
	level.zuckpilltop LinkTo(level.zuckpillar);
	level.zuckdamage = GetEnt("zucktriggerdmg", "targetname");
	level.zuckpillar2 = GetEnt("zuckpillar2","targetname");
	level.zuckpillar2 hide();
	level.zucktrig UseTriggerRequireLookAt();
	level.zucktrig TriggerEnable(0);
	level.zucklook = GetEnt("zucktriglookat", "targetname");
	//153 clock ee
	level.calendarbottompage = GetEnt("calanderbottompage", "targetname");
	level.calendartoppage = GetEnt("calandertopdel", "targetname");
	level.calendarbreakspot = GetEnt("calandarbreak", "targetname");
	level.calandarbackpageee = GetEnt("calandarbackpageee", "targetname");
	level.calendarspots = GetEntArray("calanderdatedetect","targetname");
	level.calendarbottompagealt = GetEnt("calanderbottompage2","targetname");
	level.secretcompartment = GetEnt("secretcompartmentbday","targetname");
	level.paperfxspot = GetEnt(level.calendarbreakspot.target, "targetname");
	level.cylinderspot1 = GetEntArray("bdaycylinderslot1","targetname");
	level.cylinderspot2 = GetEntArray("bdaycylinderslot2","targetname");
	level.cylinderspot3 = GetEntArray("bdaycylinderslot3","targetname");
	level.calandarbackpageee hide();
	level.calendarbottompagealt hide();
	level.calendarbottompage hide();
	level.calendartoppage hide();
	level waittill("cutsceneover");
	PlayFX(level._effect["destruct/fx_dest_paper"], level.calendartoppage.origin);
	level.calandarbackpageee show();
	level.calendartoppage show();
	level.calendarbreakspot waittill("trigger", player);
	PlayFX(level._effect["destruct/fx_dest_paper"], level.paperfxspot.origin);
	level.calendartoppage Delete();
	level.calendarbottompage show();
	level.calendarbreakspot Delete();
	wait(1);
	PlayFX(level._effect["powerup_grabbed"], level.paperfxspot.origin);
	level.paperfxspot PlaySound("shortbeep");
	foreach(calanderdatedetect in level.calendarspots)
	{
		calanderdatedetect thread bulletdetect();
	}
}


function walterwhitehead()
{
	level.walterwhiteheadmod show();
	PlayFX(level._effect["powerup_grabbed"], level.walterwhiteheadmod.origin);
	level.walterwhiteheadmodpickup show();
	level.walterwhiteheadmodpickup waittill("trigger", player);
	player PlaySound("memento_pickup");
	level.walterwhiteheadmod Delete();
	level.walterwhiteheadmodpickup Delete();
	level flag::set("unkowntotem_flagpickup");
}

function bdaysceneteleport()
{
	level.chunguslair2 = struct::get_array("chungusscaryroom_player","targetname");
	level.birthdaycake = GetEnt("birthdaycake", "targetname");
	level.bdayspots = struct::get_array( "bdaytelespots", "targetname" );
	level.chilisbdayreturn = struct::get_array( "chilisbdayreturnspots", "targetname" );
	level.black_spots = struct::get_array( "black_orgs", "targetname" );
	level.cakegunspawn = GetEnt("cakegunspawn", "targetname");
    level.black_spots_targets = []; 
    for( i=0;i<level.black_spots.size;i++ )
    {
		level.black_spots_targets[i] = struct::get( level.black_spots[i].target, "targetname" );
    }
	foreach(player in GetPlayers())
	{
		player thread playerbirthdayteleport();
	}
}

function bdayscene()
{
	level flag::init("wolfbow", false);
	level flag::init("firebow", false);
	level flag::init("voidbow", false);
	level flag::init("stormbow", false);
	level.voidbow = GetEnt("voidbowmodel","targetname");
	level.voidbowtrig = GetEnt("voidbowtrig","targetname");
	level.firebow = GetEnt("firebowmodel","targetname");
	level.firebowtrig = GetEnt("firebowtrig","targetname");
	level.stormbow = GetEnt("stormbowmodel","targetname");
	level.stormbowtrig = GetEnt("stormbowtrig","targetname");
	level.wolfbow = GetEnt("wolfbowmodel","targetname");
	level.wolfbowtrig = GetEnt("wolfbowtrig","targetname");
	level.wolfbowtrig thread waitforbowactivation(level.wolfbow, "wolfbow", "Press & hold ^1[{+activate}]^7 to Pickup ^1The Brynjar Blaster.", "BOW_WOLF");
	level.voidbowtrig thread waitforbowactivation(level.voidbow, "voidbow", "Press & hold ^1[{+activate}]^7 to Pickup ^1The 153 Experiment.", "BOW_RUNE");
	level.stormbowtrig thread waitforbowactivation(level.stormbow, "stormbow", "Press & hold ^1[{+activate}]^7 to Pickup ^1The Zom-Buster.", "BOW_STORM");
	level.firebowtrig thread waitforbowactivation(level.firebow, "firebow", "Press & hold ^1[{+activate}]^7 to Pickup ^1The Cameronium Incinerator.", "BOW_DEMON");
	level.activatebowstrig = GetEnt("activatebowstrig", "targetname");
	level.activatebowstrig SetHintString("");
	wait(4);
	level notify("lightsonsuprise");
	level.birthdaycake PlaySound("lights_on_evt");
	wait 0.1;
	VideoStart("stormtroopereeevent",true);
	level.birthdaycake PlayLoopSound("stormtroopee");
	wait 30;
	playsoundatposition("zmb_spawn_powerup", level.cakegunspawn.origin);
	PlayFX("zombie/fx_ee_apothigod_beam_success_zod_zmb", level.cakegunspawn.origin);
	wait(1);
	level.activatebowstrig SetHintString("Press & hold [{+activate}] to activate bows. Players will have 30 seconds to choose bows");
	level.activatebowstrig waittill("trigger", player);
	level.birthdaycake PlaySound("namecorrect");
	level.activatebowstrig Delete();
	level notify("spawnbows");
	level thread waitforplayersus();
}

function waitforplayersus()
{
	while(1)
	{
		level endon("bowtimerover");
		if(level flag::get("wolfbow") && level flag::get("firebow") && level flag::get("voidbow") && level flag::get("stormbow"))
		{
			level notify("bowtimercancel");
			level notify("leavebdayscene");
			earthQuake(.6, 3, level.cakegunspawn.origin, 1500);
			VideoStop("stormtroopereeevent");
			level.birthdaycake StopLoopSound(0.5);
			break;
		}
		else
		{
			wait 0.1;
			continue;
		}
	}

}

function bowtimer()
{
	level endon("bowtimercancel");
	wait(30);
	level notify("bowtimerover");
	level notify("leavebdayscene");
	earthQuake(.6, 3, level.cakegunspawn.origin, 1500);
	VideoStop("stormtroopereeevent");
}

function waitforbowactivation(model, flag, hint, weapon)
{
	model hide();
	self hide();
	level waittill("spawnbows");
	PlayFX("dlc1/castle/fx_elec_teleport_flash_sm", model.origin);
	model PlaySound("keycardtelein");
	self show();
	model show();
	self SetHintString(hint);
	self waittill("trigger", player);
	player PlaySound("memento_pickup");
	self func_giveWeapon(weapon);
	self Delete();
	model Delete();
	level flag::set(flag);
}

function func_giveWeapon(weapon)
{
    self TakeWeapon(self GetCurrentWeapon());
    weapon = getWeapon(weapon);
    self GiveWeapon(weapon);
    self GiveMaxAmmo(weapon);
    self SwitchToWeapon(weapon);
}

function playerbirthdayteleport()
{
	self notify("stop_player_out_of_playable_area_monitor");
	self PlayLocalSound("wolf_charge");
	self thread lui::screen_flash( 1, 0.1, 1.5, 1.0, "white" );
	wait(.9);
	self setstance( "stand" );
	wait(0.1);
    self playlocalsound( "kino_teleport_2d" );
    self DisableWeapons();
    self DisableOffhandWeapons();
    self freezecontrols( true );
    self SetOrigin( level.black_spots[self.characterIndex].origin ); 
    self SetPlayerAngles( level.black_spots[self.characterIndex].angles );
    playfx( KINO_SWIRL2, level.black_spots_targets[self.characterIndex].origin ); 
    wait(2);
    self SetOrigin(level.chunguslair2[self.characterIndex].origin);
    self SetPlayerAngles(level.chunguslair2[self.characterIndex].angles);
    //PlayFX(level.oildisappear, self.origin);
    self StopLoopSound(1);
    wait(0.05); 
    self playlocalsound( "kino_beam_fx" );
    self setstance("stand");
    level waittill("lightsonsuprise");
    self SetOrigin(level.bdayspots[self.characterIndex].origin);
    self SetPlayerAngles(level.bdayspots[self.characterIndex].angles);
    self EnableWeapons(); 
    self EnableOffhandWeapons(); 
    self freezecontrols( false );
    level waittill("leavebdayscene");
    self PlayLocalSound("wolf_charge");
	self thread lui::screen_flash( 1, 0.1, 1.5, 1.0, "white" );
	wait(.9);
	self SetOrigin( level.chilisbdayreturn[self.characterIndex].origin ); 
    self SetPlayerAngles( level.chilisbdayreturn[self.characterIndex].angles );
    self thread zm::player_out_of_playable_area_monitor();
    //PlayFX(level.oildisappear, self.origin);
}

function startbdayscene()
{
	while(1)
	{
		if(level flag::get("bezos_flag") && level flag::get("totem153_flag") && level flag::get("unkowntotem_flag"))
		{
			level.secretcompartment PlaySound("build_done");
			level.secretcompartment MoveZ(-16, 2);
			level.secretcompartment PlaySound("robotmove");
			earthQuake(.6, 3, level.secretcompartment.origin, 1500);
			wait 2;
			level.secretcompartment MoveX(-1, 1.5);
			level.secretcompartment PlaySound("tubeextract");
			level thread bdaysceneteleport();
			level thread bdayscene();
			level thread birthdayhats();
			//IPrintLnBold("Birthday ee completed going to scene");
			thread zm_subtitles::subtitle_display(undefined, 2, "-... .- ... . -..", "verification completed.");
			break;
		}
		else
		{
			wait 0.1;
			continue;
		}
	}
}

function birthdayhats()
{
	bdayhat = GetEntArray("partyhatplayer", "targetname");
	players = GetPlayers();
	for(i=0;i<bdayhat.size;i++)
  	{
  		bdayhat EnableLinkTo();
  		bdayhat[i] MoveTo(players[i] GetTagOrigin("tag_helmet"), 0.1);
  		bdayhat LinkTo(players[i]);
  	}
}

function finaldropoff(firstnotify, model, lastnotify, flag)
{
	level flag::wait_till(firstnotify);
	wait 0.5;
	self show();
	self TriggerEnable(1);
	self waittill("trigger", player);
	model show();
	self PlaySound("memento_pickup");
	level flag::set(flag);
	level notify(lastnotify);
	self Delete();
}

function photominiee()
{
	level.photodetectplayer waittill("trigger", player);
	wait 1;
	level.photocenter PlaySound("lightningphotoevent");
	PlayFX(level._effect["poltergeist"], level.photocenter.origin);
	PlayFX(level._effect["poltergeist"], level.photoright.origin);
	PlayFX(level._effect["poltergeist"], level.photoleft.origin);
	wait 0.1;
	level.photocenter SetModel("p7_bezoz_photo_ee");
	level.photoright SetModel("p7_elon_photo_ee");
	level.photoleft SetModel("p7_tiktok_photo_ee");
	wait(1);
	foreach(phototrig in level.photomintrigs)
	{
		phototrig thread photominieeinteract();
	}
	level waittill("photoeesolved");
	level.photoright PlaySound("rune_cross_done");
	level notify("photoeesuccesss");
	level.photominitrigs Delete();
	level.photocenter PlaySound("lightningphotoevent");
	PlayFX(level._effect["poltergeist"], level.photoright.origin);
	PlayFX(level._effect["poltergeist"], level.photoleft.origin);
	PlayFX(level._effect["poltergeist"], level.a19dollatotem.origin);
	wait 0.1;
	level.photoright SetModel("p7_rdj_photo_ee");
	level.photoleft SetModel("p7_19dolla_photo_ee");
	level.a19dollatotempickup UseTriggerRequireLookAt();
	level.a19dollatotempickup SetHintString("Press ^2[{+activate}]^7 To Collect The 19 Dolla Bezoz Totem");
	level.a19dollatotem show();
	level.a19dollatotempickup show();
	level.a19dollatotempickup waittill("trigger", player);
	player PlaySound("memento_pickup");
	level.a19dollatotempickup SetHintString("");
	level.a19dollatotem Delete();
	level.a19dollatotempickup Delete();
	level notify("bezoztotemaquired");
	level flag::set("bezos_flagpickup");
}

function photominieeinteract()
{
	while(1)
	{
		level endon("photoeesuccesss");
		level endon("photofail");
		self UseTriggerRequireLookAt();
		self waittill("trigger", player);
		if(self.script_int == 1)
		{
			PlayFX(level._effect["dlc3/stalingrad/fx_voice_log_blue"], level.photocenter.origin);
			self PlaySound("success");
			wait 0.5;
			level notify("photoeesolved");
		}
		else
		{
			wait 0.5;
			self PlaySound("defaultfail");
			level thread managefailphoto();
			level notify("photofail");
			break;
		}
	}
}

function managefailphoto()
{
	level endon("photoeesolved");
	wait 1.5;
	foreach(phototrig in level.photomintrigs)
	{
		phototrig thread photominieeinteract();
	}
	break;
}

function bulletdetect()
{
	while(1)
	{
		level endon("correctdate");
		level endon("enteredincorrect");
		level.correctcalanderspot = 1;
		self waittill("trigger", player);
		if(self.script_int == 1)
		{
			level.calendarbottompagealt show();
			level.calendarbottompage hide();
			self PlaySound("correctdefaultchilis");
			level thread compartmentopen();
			level notify("correctdate");
			break;
		}

		else
		{
			self PlaySound("defaultfail");
			level thread managefail();
			level notify("enteredincorrect");
			break;
		}
	}
}


function compartmentopen()
{
	foreach(spot1 in level.cylinderspot1)
	{
		spot1 thread fxspawncylindera();
	}
	foreach(spot2 in level.cylinderspot2)
	{
		spot2 thread fxspawncylinderb();
	} 
	foreach(spot3 in level.cylinderspot3)
	{
		spot3 thread fxspawncylinderc();
	}
	//IPrintLnBold("Secret compartment opening");
	level.secretcompartment MoveX(1, 1.5);
	level.secretcompartment PlaySound("tubeextract");
	wait(1.5);
	level.secretcompartment PlaySound("robotmove");
	level.secretcompartment MoveZ(16, 2);
	level thread spawnquestitems();
	wait(2);
	thread zm_subtitles::subtitle_display(undefined, 2, "-... .- ... . -..", "artifacts are required for verification.");
	wait(1);
	thread zm_subtitles::subtitle_display(undefined, 2, "-... .- ... . -..", "find them.");
}

function spawnquestitems()
{
	//IPrintLnBold("started quests");
	level thread walterwhitehead();
	level thread photominiee();
	level thread a153clockthread();
	level thread check153clocks();
	level thread startbdayscene();
	level.clock1fx thread finalclockfxfunc(level.clocktempint1);
	level.clock2fx thread finalclockfxfunc(level.clocktempint2);
	level.clock3fx thread finalclockfxfunc(level.clocktempint3);
	level.clock4fx thread finalclockfxfunc(level.clocktempint4);
	level.clock5hotelfx thread finalclockfxfunc(level.clocktempint5);
	level.clock6hotelfx thread finalclockfxfunc(level.clocktempint6);
	level.clock7hotelfx thread finalclockfxfunc(level.clocktempint7);
}

function finalclockfxfunc(clockint)
{
	while(1)
	{
		if(clockint == 4)
		{
			PlayFX("dlc3/stalingrad/fx_voice_log_blue", self.origin);
			PlaySoundAtPosition("rune_cross_01", self.origin);
			break;
		}
		else
		{
			wait 0.5;
			continue;
		}
	}
}	

function zuckscare()
{
	foreach(player in GetPlayers())
	{
		player thread zuckjs();
	}
}

function zuckjs()
{
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "zuck153jumpscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1;  
	wait(1); 
	jumpscare_overlay FadeOverTime( 1 ); 
	jumpscare_overlay.alpha = 0; 
	jumpscare_overlay destroy();
}

function zuckpillarevent()
{
			level notify("153totemaquired");
			level.zuckpillar PlaySound("rune_cross_done");
			level.zuckrisetrigger waittill("trigger", player);
			level notify("clockkill");
			level.zuckrisetrigger Delete();
			level.zuckpillar MoveZ(327.8, 5);
			earthQuake(.6, 6, level.zuckpillar.origin, 4000);
			level.zuckpillar PlayLoopSound("wwloop");
			wait 4;
			level.zucklook waittill("trigger", player);
			thread zm_subtitles::subtitle_display(undefined, 2, "-... .- ... . -..", "shoot it.");
			level.zucklook Delete();
			wait 0.5;
			level.zuckdamage waittill("trigger", player);
			level.zuckdamage Delete();
			level.zuckpillar2 show();
			level.zuckpillar2 StopLoopSound(0.5);
			PlayFX("dlc5/temple/fx_ztem_meteor_shrink", level.zuckpillar.origin);
			level.zuckpillar2 PlaySound("explosionelevator");
			level.zuckpillar Delete();
			level.zucktrig TriggerEnable(1);
			//level.zucktrig TriggerEnable(1);
			level.zucktrig waittill("trigger", player);
			level.zucktrig TriggerEnable(0);
			level.zuckpillar2 Delete();
			level.zucktrig Delete();
			player PlaySound("memento_pickup");
			level flag::set("zucktotem153_flagpickup");
			level.zuckpillar Delete();
			level.zuckpilltop Delete();
			level flag::set("zucktotem153_flagpickup");
			///IPrintLnBold("triggered success");

}
function check153clocks()
{
	level endon("153totemaquired");
	while(1)
	{
		level.levelclockamount = (level.clocktempint1 + level.clocktempint2 + level.clocktempint3 + level.clocktempint4 + level.clocktempint5 + level.clocktempint6 + level.clocktempint7);
		if(level.levelclockamount == 28)
		{
			level thread zuckscare();
			level thread zuckpillarevent();
			level.clocktempint1 ++;
		}
		else
		{
			wait 0.1;
			continue;
		}

	}
}


function a153clockthread()
{
	level.levelclockamount = 0;
	level.clocktempint1 = 1;
	level.clocktempint2 = 1;
	level.clocktempint3 = 1;
	level.clocktempint4 = 1;
	level.clocktempint5 = 1;
	level.clocktempint6 = 1;
	level.clocktempint7 = 1;
	//thread clocks
	foreach(damagespot in level.clock1)
	{
		damagespot thread a153detectlogic();
	}
	foreach(damagespot in level.clock2)
	{
		damagespot thread a153detectlogica();
	}
	foreach(damagespot in level.clock3)
	{
		damagespot thread a153detectlogicb();
	}
	foreach(damagespot in level.clock4)
	{
		damagespot thread a153detectlogicc();
	}
	foreach(damagespot in level.clock1hotel)
	{
		damagespot thread a153detectlogicd();
	}
	foreach(damagespot in level.clock2hotel)
	{
		damagespot thread a153detectlogice();
	}
	foreach(damagespot in level.clock3hotel)
	{
		damagespot thread a153detectlogicf();
	}
	//thread clocksend
}

function a153detectlogic()
{
	while(level.clocktempint1 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint1)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint1 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
	level notify("clocktempint1");
}
function a153detectlogica()
{
	while(level.clocktempint2 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint2)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint2 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}	
	}
}
function a153detectlogicb()
{
	while(level.clocktempint3 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint3)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint3 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
}
function a153detectlogicc()
{
	while(level.clocktempint4 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint4)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint4 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
}
function a153detectlogicd()
{
	while(level.clocktempint5 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint5)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint5 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
}
function a153detectlogice()
{
	while(level.clocktempint6 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint6)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint6 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
}
function a153detectlogicf()
{
	while(level.clocktempint7 < 3)
	{
		//IPrintLnBold("clock thread");
		self waittill("trigger", player);
				if(self.script_int == level.clocktempint7)
				{
					PlayFX("dlc5/cosmo/fx_light_red_vista_sm", self.origin);
					level.clocktempint7 ++;
					wait 0.1;
				}
				else
				{
					wait 0.1;
					continue;
				}
				
	}
}


function fxspawncylindera()
{
	fxcylinder = util::spawn_model("tag_origin", self.origin);
	PlayFXOnTag("dlc1/castle/fx_mech_dmg_sparks", fxcylinder, "tag_origin");
	level waittill("spot1placed");
	fxcylinder Delete();
}
function fxspawncylinderb()
{
	fxcylinder = util::spawn_model("tag_origin", self.origin);
	PlayFXOnTag("dlc1/castle/fx_mech_dmg_sparks", fxcylinder, "tag_origin");
	level waittill("spot2placed");
	fxcylinder Delete();
}

function fxspawncylinderc()
{
	fxcylinder = util::spawn_model("tag_origin", self.origin);
	PlayFXOnTag("dlc1/castle/fx_mech_dmg_sparks", fxcylinder, "tag_origin");
	level waittill("spot3placed");
	fxcylinder Delete();
}


function managefail()
{
	level endon("correctdate");
	wait 3;
	foreach(calanderdatedetect in level.calendarspots)
	{
		calanderdatedetect thread bulletdetect();
	}
	break;
}




