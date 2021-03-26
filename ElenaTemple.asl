state("ElenaTemple") {
	bool transitionStarted: "UnityPlayer.dll", 0x00FEE990, 0x14, 0x8, 0x1C, 0x1C, 0x80, 0x18, 0x30; 
    bool chaliceCollected: "mono.dll", 0x1F56AC, 0x50, 0xF54, 0x3C, 0x14;
	bool spiderCollected: "mono.dll", 0x1F56AC, 0x50, 0xF54, 0x40, 0x14;
	int orbShardsCollected : "mono.dll", 0x1F56AC, 0x50, 0xF54, 0xB8;
	int gemsCollected: "mono.dll", 0x1F56AC, 0x50, 0xF54, 0xB0;
    int gameMode : "mono.dll", 0x1F56AC, 0x50, 0xF54, 0xF0;
    float chaliceTimer : "mono.dll", 0x1F56AC, 0x50, 0xF54, 0x10, 0x10;
    float spiderTimer : "mono.dll", 0x1F56AC, 0x50, 0xF54, 0x10, 0x14;
    float orbTimer : "mono.dll", 0x1F56AC, 0x50, 0xF54, 0x10, 0x18;
	float timePntr : "mono.dll", 0x1F56AC, 0x50, 0xF54;
}

startup {
    // id, state, description, parent
	settings.Add("Orb Inbound Mod");
    settings.Add("Orb Inbound Mod 0", true, "(0,0)", "Orb Inbound Mod");
    settings.Add("Orb Inbound Mod 1", true, "(1,0)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 2", true, "(1,1)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 3", true, "First Orb Shard", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 4", true, "(2,2)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 5", true, "(2,3)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 6", true, "Platform Clip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 7", true, "Portal Clip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 8", true, "Exit Skip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 9", true, "Button Skip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 10", true, "(3,1)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 11", true, "Third Orb Shard", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 12", true, "(5,1)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 13", true, "Prepare for the run to end", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 14", true, "Double Platform Superclip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 15", true, "Final Orb Shard", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 16", true, "(4,0)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 17", true, "(4,1)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 18", true, "(4,2)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 19", true, "(3,2)", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 20", true, "Maze Skip", "Orb Inbound Mod");
	settings.Add("Orb Inbound Mod 21", true, "The Orb of Life", "Orb Inbound Mod");
	
	settings.Add("Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 0", false, "First Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 1", false, "Second Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 2", false, "Third Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 3", false, "Fourth Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 4", false, "Fifth Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 5", false, "Sixth Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 6", false, "Seventh Gem", "Chalice Inbound NoMo");
	settings.Add("Chalice Inbound NoMo 7", false, "Final Gem", "Chalice Inbound NoMo");
	
	settings.Add("Spider Inbound Mod");
	settings.Add("Chalice Inbound Mod");
	settings.Add("Chalice Any% Mod");
	
	vars.time = 0f;
}

start {
	return (
		(current.gameMode == 0 && current.chaliceTimer > .1 && current.chaliceTimer < .15
		|| current.gameMode == 1 && current.spiderTimer > .1 && current.spiderTimer < .15
		|| current.gameMode == 2 && current.orbTimer > .1 && current.orbTimer < .15)
	);
}

split {
    return (
		(old.transitionStarted == false && current.transitionStarted == true && settings["Orb Inbound Mod"]) ||
		(old.gemsCollected < current.gemsCollected && old.chaliceTimer>5 && settings["Chalice Inbound NoMo"])
		|| (old.transitionStarted == false && current.transitionStarted == true && current.chaliceCollected == true && settings["Chalice Inbound NoMo"])
	);
}

gameTime {
	if(current.gameMode == 0){
		return TimeSpan.FromSeconds(current.chaliceTimer);
	}
	else if(current.gameMode == 1){
		return TimeSpan.FromSeconds(current.spiderTimer);
	}
	else if(current.gameMode == 2){
		return TimeSpan.FromSeconds(current.orbTimer);
	}
}

reset
{
	if(current.gameMode == 0 && current.chaliceTimer > .15){
		vars.time = current.chaliceTimer;
	}
	else if(current.gameMode == 1 && current.spiderTimer > .15){
		vars.time = current.spiderTimer;
	}
	else if(current.gameMode == 2 && current.orbTimer > .15){
		vars.time = current.orbTimer;
	}
	
	return (
		(current.orbTimer>.1 && current.orbTimer<.15 && vars.time > .15f)
		|| (current.spiderTimer>.1 && current.spiderTimer<.15 && vars.time > .15f)
		|| (current.chaliceTimer>.1 && current.chaliceTimer<.15 && vars.time > .15f)
	);
}