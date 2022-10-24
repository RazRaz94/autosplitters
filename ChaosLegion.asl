// Autosplitter by LonerHero
state("ChaosLegion"){
    byte GameStart: 0x174EF16; // Gets value for Timer start on Game Start Prompt
	byte Stage: 0x6FD935; // Gets current Stage
	byte Cutscene: 0x27332A; // Checks if the game plays cutscene, required for the last 3 bosses Needs to be used as an option to turn on or off.
	short BossMaxHP: 0x6D614E; // Grabs Max HP boss without reduction if hit
	short BossHP: 0x2733F2; // Gets current boss HP state
}


startup{

 settings.Add("FS", false,"Final Split. Final Stage must be broken down into 5 splits");

}

start{
	if(old.GameStart == 76 && current.GameStart == 0){
        return true;
    }
}


split{
	bool FinalStageCutscene = current.Stage == 14 && old.Cutscene == 0 && current.Cutscene == 1;
    // Stage Splits
    if(current.Stage > old.Stage){
        return true;
    }
	
	// Final Split
	if(settings["FS"]){
	 if(FinalStageCutscene){
	 return true;
	}
	}
	
}