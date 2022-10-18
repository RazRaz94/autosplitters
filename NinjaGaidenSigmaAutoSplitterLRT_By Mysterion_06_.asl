// Autosplitter by Mysterion_06_
// Commissioned by LonerHero
state("NINJA GAIDEN SIGMA"){
    byte cutscene: 0xC5B7C0; // 1 = Cutscenes; 2 = Going thru doors (buggy though)
    byte loading: 0x40BE034; // 1 = loading doors; 0 = gameplay
    byte ItemPickloading: 0x3ECFA94; // 1 = loading 0= gameplay
    byte start1: 0x3674120; // 1 = during costume selection; 0 = on the proceed button for 1st mission
    byte start2: 0x40BE442; // 1 = on the proceed button for 1st mission; 0 = when pressed proceed
    byte chapter: 0xC6024A; // Current chapter value; e.g. current chapter is 10, pointer = 10 / Exception: Chapter 1-7 = 0-6
    byte chapterEnd: 0x3EC82A1; // 1 = result screen; 0 = gameplay
    byte map: 0x3E5F75C;    // 1 = when pressing select; 0 = gameplay
    short curBossHP: 0xB9E1A8;
    short maxBossHP: 0xD632B4;
    int keyItem: 0x3EC1DE4; // Indicates the id of the last picked up item; e.g. 191 = Great Spirit of Elixir
    int KarmaScore: 0xCBE58C;
    int CurrentWaveKillCount: 0xCBE59C;
    int moneyRyu: 0xCBE5F0;
    int moneyRachel: 0xCBFA40;
    byte ScarabsHeld: 0xCBEDE0;
    byte TotalScarabsCollected: 0xCBE5F4;
}

init{
	vars.completedSplitsInt = new List<int>();
}

startup{
    vars.KeyItems = new List<int>()
    {189, 218, 408, 154, 208, 260, 281, 409, 299, 275, 440, 219, 122, 98, 202, 102, 441, 158, 124, 103, 95, 248, 272, 47, 274, 107, 172, 105, 188, 104, 108, 457, 458, 69, 113, 70, 72, 71, 125, 117, 282, 118, 119, 123,
     120, 121};
    
    vars.KeyItemsSettings = new List<String>()
    {"Fangs of the Samurai", "Key of Courage", "Technique Scroll: Flying Swallow", "The Art of the Fire Wheels", "Technique Scroll: Counter Attacks", "Wing Key", "ID Card",
	 "Dragon's Claw & Tiger's Fang", "Lunar", "Lily Key", "Dworku Monastery Key", "Key of Pegasus", "Stone Tablet (Right)", "Book of the Eons", "Vigoorian Flail",
	 "Holy Grail", "Blades of Ouroboros", "The Art of Ice Storm", "Wolf, Deity of Wisdom", "Skull Key", "Stone Tablet (Top)", "Strong bow", "Warehouse Key",
	 "Shutter Control Card Key", "Control Room Key", "Key of Insect", "The Art of the Inazuma", "Red Tablet of Stream", "Statue of the Water Spirit", "Blue Tablet of Stream", "Brand of Valor",
	 "Key of Triton", "Mysterious Stone Tablet", "Shield of Vigoor", "Stone Tablet (Left)", "Cog of Vigoor", "Eye of Ice", "Eye of Flame", "Devil, Deity of Immorality", "Serpent, Deity of Creation",
	 "Griffon Key", "Key of Lion", "Key of Lioness", "Raptor, Deity of Sentiment", "Key of the Decayed Soul", "Demon, Deity of Destruction"};

    settings.Add("DRI", false,"Deactivate Reset if you will return to the main menu during runs");
    settings.Add("chapter", false, "Chapter Splits");
    settings.Add("IS", false,"Item Splits");
    settings.Add("GS", false,"Golden Scarab");
    for(int i = 0; i < 46; i++){
        settings.Add("" + vars.KeyItems[i].ToString(), false, "" + vars.KeyItemsSettings[i].ToString(), "IS");
    }
}

update
{
	//Reset variables when the timer is reset.
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplitsInt.Clear();
	}
}


start{
    if(current.start1 == 0 && old.start2 == 1 && current.start2 == 0 && current.chapter == 0){
        return true;
    }
}

split{
    // Chapter Splits
    if(settings["chapter"]){
        if(current.chapterEnd == 0 && old.chapterEnd == 1){
            return true;
        }
    }

    // Final Split
    if(current.chapter == 19 && current.curBossHP == 0 && current.maxBossHP == 12000){
        return true;
    }

    // Item Splits
    if(settings["IS"]){
        if(settings[current.keyItem.ToString()] && !vars.completedSplitsInt.Contains(current.keyItem) && current.keyItem != old.keyItem){ // vars.KeyItems.Contains(current.keyItem)
            vars.completedSplitsInt.Add(current.keyItem);
            return true;
        }
    }
    
    // Golden Scarab Splits
    if(settings["GS"]){
       if(current.TotalScarabs > old.TotalScarabs){
	return true;
	}
}
}

/*
reset{
    if(current.chapter < old.chapter){
        return true;
    }
}*/

isLoading{
    if(current.cutscene == 1 || current.loading == 1 || current.map == 1 || current.ItemPickloading == 1){
        return true;
    } else{
        return false;
    }
}
