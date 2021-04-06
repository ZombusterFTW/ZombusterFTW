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
#using scripts\Sphynx\_zm_subtitles;
//#using scripts\zm\zm_chilis;
#using scripts\_NSZ\roomserviceeasteregg;
//#using scripts\_redspace\rs_o_jump_pad;
#using scripts\zm\_zm_ai_mechz;
#using scripts\shared\lui_shared;

#namespace jumpscare; 

#precache( "material", "eral" );
#precache( "material", "pigman_jumpscare" );
#precache( "material", "rhettscare" );
#precache( "material", "stuffmanscare" );
#precache( "material", "number2oil" ); 
#precache( "material", "amongscare" );
#precache( "material", "susscare" );
#precache( "material", "trollscare" );
#precache( "fx", "dlc0/factory/fx_teleporter_beam_factory" ); 
#precache( "fx", "dlc1/castle/fx_elec_teleport_flash_sm" );
#precache( "fx", "zombie/fx_ritual_barrier_defend_zod_zmb" );
#precache( "fx", "dlc1/castle/fx_ee_keeper_demongate_portal_open" );
#precache( "fx", "dlc1/castle/fx_ee_keeper_demongate_portal_loop" );
#define KINO_SWIRL2                                  "dlc5/tomb/fx_teleport_1p"
#precache( "fx", KINO_SWIRL2 );

function autoexec init()
{
	level.oilappear = "dlc0/factory/fx_teleporter_beam_factory";
	level.oildisappear = "dlc1/castle/fx_elec_teleport_flash_sm";
	level.evilbarrier = "zombie/fx_ritual_barrier_defend_zod_zmb";
	level.bartenddoorfx = "dlc2/zmb_weapon/fx_skull_quest_ritual_doorbarrier_island";
	level.oilbottleplace = GetEnt("oilinitialplacebottle", "targetname");
	level.oilbottle = GetEnt("oilbottle", "targetname");
	level.oilbottletrig = GetEnt("oilbottletrig", "targetname");
	level.oilbottleteleport = GetEnt("oilbottlegrow", "targetname");
	level.oilbottleplacetrig = GetEnt("placeoil", "targetname");
	level.activatesequence = GetEnt("beginoilconversion", "targetname");
	level.oilpool = GetEnt("oilraiseheight", "targetname");
	level.oilpooldetect = GetEnt("oilpooldetect", "targetname");
	level.oilroomdetect = GetEnt("oildoordetect", "targetname");
	level.oilpoolbarrier = GetEnt("oilbarrier", "targetname");
	level.oilroombarrierz = GetEnt("oilfatdoor", "targetname"); 
	level.oiltelepad = GetEnt("oiltelepad", "targetname");
	level.oilsuccz = GetEnt("oilsucctubez", "targetname");
	level.screenchase = GetEnt("littlemoefadeschase", "targetname");
	level.screenlookat = GetEnt("littlemoelook", "targetname");
	//level.screenhurt = GetEnt("littlemokill", "targetname");
	level.hallwayend = GetEnt("hallwaychaseend", "targetname");
	level.hallwayhint = GetEnt("hallwayrunhint", "targetname");
	level.killcheck = GetEnt("playerkillerchasecheck", "targetname");
	level.spawnportal = GetEnt("portalexitspawnhall","targetname");
	level.oildoorautomatic = GetEnt("oildoormechanical", "targetname");
	level.portalopen = "dlc1/castle/fx_ee_keeper_demongate_portal_open";
	level.portalloop = "dlc1/castle/fx_ee_keeper_demongate_portal_loop";
	level.fxwoodplanckdoor = GetEnt("fx_woodplanckoilroom", "targetname");
	level.fxwoodplanckdoor hide();
	level.spawnportal hide();
	level.oilbottleplace hide();
	level.oilbottleteleport hide();
	level.growsize = 1;
	//level.oilroombarrier MoveZ(-200,1);
	//thread waitforoil();
	thread pickupoil();
	thread oilwaitforpower();
	level.oilroombarrierz MoveZ(-135,0.5);
}

function oilwaitforpower()
{
	level.oilbottletrig SetCursorHint("HINT_NOICON");
	level.oilbottletrig SetHintString("");
	level.oilbottleplacetrig UseTriggerRequireLookAt();
	level.activatesequence UseTriggerRequireLookAt();
	level.oilbottleplacetrig SetHintString( &"ZOMBIE_NEED_POWER" );
	level.activatesequence SetHintString( &"ZOMBIE_NEED_POWER" );
	level.oilbottleplacetrig SetCursorHint("HINT_NOICON");
	level.activatesequence SetCursorHint("HINT_NOICON");
	level flag::wait_till( "power_on" ); 
	level.oilbottleplacetrig SetHintString("Requires Oil");
	level.oiltankshoweractivate SetCursorHint("HINT_NOICON");
	level.activatesequence SetHintString("Oil Required For Synthesis Activation");
	level waittill("oilgrabbed");
	thread waitforoil();
}

function pickupoil()
{
	level waittill("amongusconvo");
	level waittill("codenum_solved");
	wait(0.5);
	level.oilbottletrig SetCursorHint("HINT_NOICON");
	level.oilbottletrig SetHintString("Hold [{+activate}] To Pick Up Meme Oil");
	level.oilbottletrig UseTriggerRequireLookAt();
	level.oilbottletrig waittill("trigger", player);
	level notify("oilgrabbed");
	player PlaySound("zmb_craftable_pickup");
	level.oilbottletrig Delete();
	PlayFX(level._effect["powerup_grabbed"], level.oilbottle.origin);
	level.oilbottle Delete();
	level notify("oilgrabbed");
}

function waitforoil()
{
	level.oilbottleplacetrig SetCursorHint("HINT_ACTIVATE");
	level.oilbottleplacetrig SetHintString("Press [{+activate}] To Place Oil On Teleport Pad");
	level.oilbottleplacetrig waittill("trigger", player);
	level.oilbottleplace show();
	wait(1);
	PlayFX(level.oildisappear, level.oilbottleplace.origin);
	level.oiltelepad PlaySound("oilteleport");
	wait(.2);
	level.oilbottleplace hide();
	level.oilbottleplacetrig SetCursorHint("HINT_NOICON");
	level.oilbottleplacetrig SetHintString("Oil Teleported To Expansion Chamber");
	wait(0.8);
	PlayFX(level.oilappear, level.oilbottleteleport.origin);
	level.oiltelepad PlaySound("oilappear");
	level.oilbottleplace Delete();
	wait(.4);
	level.oilbottleteleport show();
	wait(0.2);
	level.activatesequence SetCursorHint("HINT_ACTIVATE");
	level.activatesequence SetHintString("Press [{+activate}] To Activate Expansion Sequence, Requires All Players");
	level.activatesequence waittill("trigger", player);
	level.oilroomdetect waittill("trigger", player);
	level.activatesequence PlaySound( "kino_activate_start" );
	wait(0.1);
	level.oilroombarrierz MoveZ(135,0.5);
	level thread beginshower();
}

function teleport_aftereffect_fov()
{
	util::setClientSysState( "levelNotify", "tae", self );
}

function beginshower()
{
	level flag::clear( "spawn_zombies" );
	level flag::clear( "zombie_drop_powerups" );
	PlayFX(level.evilbarrier, level.fxwoodplanckdoor.origin);
	level notify("startlockdown");
	VideoStart("oilconvert",false);
	foreach( player in GetPlayers())
    {
        player PlayLocalSound("loonboon"); 
    }
	level.oilbottleteleport playsound( "oilgrow" );
	level.activatesequence SetHintString("Expansion In Progress, Lockdown In Effect...");
	level.oilbottleplacetrig SetHintString("Expansion In Progress, Lockdown In Effect...");
	thread spawn_panzers();
	level thread growoil();
	wait(50);
	level.activatesequence PlaySound( "kino_activate_start" );
	level.oilsucc PlaySound("tubeextract");
	level.oilsuccz MoveZ(-15,2);
	wait(.5);
	foreach( player in GetPlayers())
    {
        player PlayLocalSound("oilcomplete"); 
    }
	level notify( "oiltankfilling" );
	zombies = GetAiSpeciesArray( level.zombie_team, "all" );
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    wait(2);
    level.oilsucc PlayLoopSound("succnoise");
    level.oilpool PlaySound( "oilslosh" );
    level.oilpool MoveZ(81,8);
    thread zm_subtitles::subtitle_display(undefined, 3, "^5Chili's Lab", "Dispensing Oil.....");
    wait(8);
    level.oilsucc StopLoopSound(0.3);
    level.activatesequence SetCursorHint("HINT_NOICON");
	level.activatesequence SetHintString("Oil Expansion Complete, Please Submerge Yourself In The Oil");
	level.oilbottleplacetrig SetCursorHint("HINT_NOICON");
	level.oilbottleplacetrig SetHintString("Oil Expansion Complete, Please Submerge Yourself In The Oil");
	level.oilpoolbarrier MoveZ(-144,1.5);
	level.oildoorautomatic MoveZ(-144,1.5);
	level.oildoorautomatic PlaySound("dooropen_1");
	wait(0.5);
	level.oilpooldetect waittill("trigger", player);
	level thread disable_guns();
	wait(2);
	level thread speak_to_players("dimbreak");
	thread zm_subtitles::subtitle_display(undefined, 2, "The OG Memer", "Dimensional stability is breaking down.!! WE'RE LOSING THEM.!!");
	level thread dimensionalbreakallplayers();
	level.oildoorautomatic PlaySound("dooropen_2");
	level.oilpoolbarrier MoveZ(144,1.5);
	level.oildoorautomatic MoveZ(144,1.5);
	//level thread instakillplayer();
	level waittill("teleporttohall");
	VideoStop("oilconvert");
	level thread chase_scene();
	level waittill("playerescapehall");
	level.activatesequence SetCursorHint("HINT_NOICON");
	level.activatesequence SetHintString("");
	level.oilbottleplacetrig SetCursorHint("HINT_NOICON");
	level.oilbottleplacetrig SetHintString("");
	thread zm_subtitles::subtitle_display(undefined, 3, "^5Chili's Lab", "You are now covered in oil. You may now fly.....");
    level notify( "playercoveredinoil" );
    level thread enable_guns();
    level.oilroombarrierz Delete();
    level.oilroombarrierz MoveZ(-135,0.5);
    level.fxwoodplanckdoor Delete();
    level thread increaseroundz();
    wait(3);
    level flag::set( "spawn_zombies" );
    level flag::set( "zombie_drop_powerups" );
    zombies = GetAiSpeciesArray( level.zombie_team, "all" );
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
}

function spawn_panzers()
{
	level flag::clear( "spawn_zombies" );
	zombie_utility::set_zombie_run_cycle( "super_sprint" );
	while(1)
	{
		level endon("oiltankfilling");
		e_ai = zombie_utility::spawn_zombie( level.zombie_spawners[ 0 ] );
        e_ai._rise_spot = array::random( struct::get_array( "start_zone_spawners", "targetname" ) );
        e_ai.ignore_enemy_count = 1;
        wait(1);
	}
}


function speak_to_players( sound )
{
    players = GetPlayers(); 
    foreach( player in players )
    {
        player PlayLocalSound( sound ); 
    }
}

function increaseroundz()
{
    level.roundjaunt = level.round_number;
    level.roundjaunt++;
    zombies = GetAiSpeciesArray( level.zombie_team, "all" );
        if ( isdefined( zombies ) )
        {
            array::run_all( zombies, &Kill );
        }
    level thread zm_utility::zombie_goto_round(level.roundjaunt);
    //IPrintLnBold ("roundshifted");
}

function growoil()
{
	level.growjaunt = 0.01875;
	for(i=0;i<373;i++)
    {
    	level endon ("oiltankfilling");
    	level.growsize = level.growsize + level.growjaunt;
    	level.oilbottleteleport SetScale(level.growsize);
    	wait(0.13404826);
    }
}

function teleporttofinalposoil()
{	
		self SetElectrified( 1.0 );
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
        self EnableWeapons(); 
        self EnableOffhandWeapons(); 
        self freezecontrols( false );
        self SetOrigin(level.oilendposition[self.characterIndex].origin);
        self SetPlayerAngles(level.oilendposition[self.characterIndex].angles);
        PlayFX(level.oildisappear, self.origin);
        self StopLoopSound(1);
        wait(0.05); 
        self playlocalsound( "kino_beam_fx" );
        self setstance( "stand" );
}

function teleportplayersmoment()
{
	level.oilendposition = struct::get_array( "oilroomspawn", "targetname" );  // use structs instead of script_origins as they don't go towards the entity limit
    level.black_spots = struct::get_array( "black_orgs", "targetname" );
    level.tpamount = 0;
    level thread playerdeathcallback();
    level.black_spots_targets = []; 
    for( i=0;i<level.black_spots.size;i++ )
    {
		level.black_spots_targets[i] = struct::get( level.black_spots[i].target, "targetname" );
    }
	while(1)
	{
		if(level.teleportertimer == 0)
		{
			break;
		}
		else
		{
			level.hallwayend waittill("trigger", player);
			wait(0.01);
			player thread teleporttofinalposoil();
		}
	}
		level.screenchase StopLoopSound(0.1);
	    level notify("playerescapehall");
        VideoStop("runchase");
        level.spawnportal StopLoopSound(0.5);
        level.hallwayhint Delete();
        level.hallwayhint SetHintString("");
}

function playerdeathcallback()
{
	level endon("playerescapehall");
	level.playercallbacktimer = 12;
	level.timerend = 0;
	wait(level.playercallbacktimer);
	IPrintLnBold ("A player failed to escape");
	level notify("playerescapehall");
	wait(1);
	IPrintLnBold ("#Owned");
	level.timerend = 1;
	VideoStop("runchase");
    level.spawnportal StopLoopSound(0.5);
    level.hallwayhint Delete();
    level.hallwayhint SetHintString("");
}

function teleporttoevilhallway()
{
        level thread fade_all_players();
        level thread speak_to_players("success");
        wait(1);
        level thread disable_movement();
        level.screenchase PlayLoopSound("hallwayalarm");
        players = GetPlayers();
        foreach(player in players)
        {
        	player thread teleporttoevilhallwaynodelay();
        }
}

function teleporttoevilhallwaynodelay()
{
	oilhallway2 = struct::get_array( "evilredhallway", "targetname" );  // use structs instead of script_origins as they don't go towards the entity limit
	self EnableInvulnerability();
    self SetOrigin(oilhallway2[self.characterIndex].origin);
    self SetPlayerAngles(oilhallway2[self.characterIndex].angles);
    PlayFX(level.oildisappear, self.origin);
    wait(1);
    self DisableInvulnerability();
}

function teleporttonormalhallway()
{
		level thread fade_all_players();
        level thread speak_to_players("success");
        wait(1);
        players = GetPlayers();
        foreach(player in players)
        {
        		player thread teleporttonormalhallwaynodelay();
        }
}

function teleporttonormalhallwaynodelay()
{
		oilhallway1 = struct::get_array( "normalhallway", "targetname" );  // use structs instead of script_origins as they don't go towards the entity limit
        self EnableInvulnerability();
        self SetOrigin(oilhallway1[self.characterIndex].origin);
        self SetPlayerAngles(oilhallway1[self.characterIndex].angles);
        PlayFX(level.oildisappear, self.origin);
        wait(1);
        self DisableInvulnerability();
        break;
}

function fade_all_players()
{
foreach(player in GetPlayers())
    player thread fade_player();
}

function fade_player()
{
    	//Example: level lui::screen_flash( 0.2, 0.1, .5, 1.0, "white" ); // fade to 1.0 alpha white over 0.2s, hold for 0.5s, and fade back in over 1.0s"
    self thread lui::screen_flash( .85, 0.1, 1.2, 1.0, "white" );
}

function fade_all_players2()
{
foreach(player in GetPlayers())
    player thread fade_player2();
}

function fade_player2()
{
    	//Example: level lui::screen_flash( 0.2, 0.1, .5, 1.0, "white" ); // fade to 1.0 alpha white over 0.2s, hold for 0.5s, and fade back in over 1.0s"
   self thread lui::screen_flash( .5, 0.1, 1.5, 1.0, "white" );
}

function dimensionalbreakallplayers()
{
	foreach(player in GetPlayers())
    player thread dimensionalbreakdown();
}

function dimensionalbreakdown()
{   
	self thread teleport_aftereffect_fov();
	self shellshock( "explosion", 10 );
    self shellshock( "electrocution", 10 );
	level util::clientNotify("player_fling_blur_0");
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "stuffmanscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(1); 
	jumpscare_overlay FadeOverTime( 1 ); 
	jumpscare_overlay.alpha = 0; 
	wait( 1 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "rhettscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(0.5); 
	jumpscare_overlay FadeOverTime( 0.5 ); 
	jumpscare_overlay.alpha = 0; 
	wait( 0.5 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "pigman_jumpscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(0.25); 
	jumpscare_overlay FadeOverTime( 0.25 ); 
	jumpscare_overlay.alpha = 0; 
	wait( .25 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "rhettscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(0.25); 
	jumpscare_overlay FadeOverTime( 0.25 ); 
	jumpscare_overlay.alpha = 0; 
	wait( .25 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "stuffmanscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(0.25); 
	jumpscare_overlay FadeOverTime( 0.25 ); 
	jumpscare_overlay.alpha = 0; 
	wait( .25 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "trollscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("comicalnoise"); 
	wait(0.25); 
	jumpscare_overlay FadeOverTime( 0.25 ); 
	jumpscare_overlay.alpha = 0; 
	wait( .1 ); 
	jumpscare_overlay destroy();
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "susscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound("vineboom"); 
	wait(0.1); 
	self StopLocalSound("vineboom");
	jumpscare_overlay FadeOverTime( 0.15 ); 
	jumpscare_overlay.alpha = 0; 
	wait( .1 ); 
	jumpscare_overlay destroy();
	level notify("teleporttohall");
	level util::clientNotify("player_fling_blur_disable_0");
}

function chase_scene()
{
	level.killcheck EnableLinkTo();
	level.killcheck LinkTo(level.screenchase);
	//level.screenhurt EnableLinkTo();
	//level.screenhurt LinkTo(level.screenchase);
	level notify("teleporttohall");
	level thread teleporttonormalhallway();
	wait(20);
	level thread teleporttoevilhallway();
	level thread freezelook();
	VideoStart("moestatic",true);
	wait(1);
	level thread waitforlook();
	wait(1);
	level thread unfreezelook();
	level.screenlookat waittill("trigger", player);
	level.spawnportal PlaySound("oilappear");
	//wait(1);
	level thread enable_movement();
	level notify("moelookedat");
	level.screenchase PlaySound("usstare");
	wait(2.5);
	level.spawnportal PlayLoopSound("portal");
	VideoStop("moestatic");
	VideoStart("runchase",true);
	level.screenchase PlaySound("runrunrunrunz");
	PlayFX(level.portalopen, level.spawnportal.origin);
	wait(1);
	PlayFX(level.portalloop, level.spawnportal.origin);
	level.screenchase MoveX(2500, 10);
	level.hallwayhint Delete();
	level.teleportertimer = 1;
	level thread teleportplayersmoment();
	level thread teleportertimer();
	level thread teleporttimercancel();
}

function teleportertimer()
{
	wait(11);
	level notify("teleportplayersover");
	level.teleportertimer = 0;
}

function teleporttimercancel()
{
	level.oilroomdetect waittill("trigger", player);
	level.teleportertimer = 0;
}

function waitforlook()
{
	while(1)
	{
		level endon("moelookedat");
		level.screenchase PlaySound("hesbehindu");
		wait(3.5);
		level.screenchase PlaySound("hescoming");
		wait(3.5);
	}
}

function freezelook()
{
	players = GetPlayers();
    
    foreach (player in players)
	{
	player FreezeControls(true);
	}
}

function unfreezelook()
{
	players = GetPlayers();
    foreach (player in players)
    {
	player FreezeControls(false);
	}
}

function disable_movement()
{
	players = GetPlayers();
    //players_count = 0;
    foreach (player in players)
	//foreach(player in GetPlayers())
    {
	player setstance( "stand" );
	wait(0.1); 
	player AllowJump(false);
	player SetMoveSpeedScale(0);
	//player FreezeControls(true);
	
	}
}

function enable_movement()
{
	players = GetPlayers();
    //players_count = 0;
    foreach (player in players)
	//foreach(player in GetPlayers())
    {
	player setstance( "stand" );
	wait(0.1); 
	player SetMoveSpeedScale(1);
	player AllowJump(true);
	//player FreezeControls(false);
	} 
}

function disable_guns()
{
	players = GetPlayers();
    //players_count = 0;
    foreach (player in players)
	//foreach(player in GetPlayers())
    {
	player DisableWeapons(); 
	player DisableOffhandWeapons();
	}
}

function enable_guns()
{
	players = GetPlayers();
    //players_count = 0;
    foreach (player in players)
	//foreach(player in GetPlayers())
    {
	player EnableWeapons(); 
	player EnableOffhandWeapons(); 
	}
}

function bunnyscare()
{
	jumpscare_overlay = NewClientHudElem( self ); 
	jumpscare_overlay.alignX = "center";
	jumpscare_overlay.alignY = "center";
	jumpscare_overlay.horzAlign = "center";
	jumpscare_overlay.vertAlign = "center";
	jumpscare_overlay SetShader( "amongscare", 480, 480 ); 
	jumpscare_overlay.alpha = 1; 
	self PlayLocalSound( "loudnigra" ); 
	wait(2); 
	jumpscare_overlay FadeOverTime( 3 ); 
	jumpscare_overlay.alpha = 0; 
	wait( 4 ); 
	jumpscare_overlay destroy(); 
}

function autoexec startbunny()
{
	level.bunnydamage = GetEnt("bunnydamage","targetname");
	level.bunnydamage = GetEnt("damagebunnytrig","targetname");
	level.bunnydamage waittill("trigger", player);
	foreach(player in GetPlayers())
	{
    player thread bunnyscare();
	}
}


