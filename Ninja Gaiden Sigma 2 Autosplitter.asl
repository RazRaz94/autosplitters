// Autosplitter by LonerHero and Mysterion_06_
state("NINJA GAIDEN SIGMA2"){
    byte chapter: 0x64BCCAE; // Current chapter value; e.g. current chapter is 10, pointer = 10 / Exception: Chapter 1-7 = 0-6
    byte cutscene: 0x1E67630; // 1 = If game plays any cutscene. Used for final cutscene against Archfiend and start timer
    byte BOTAKill: 0x2FDE960; // Total Kill count for Ryu's Dual Sword weapon. Used to fetch Boss's HP
    short curBossHP: 0x67A6550; //  Real Time Boss HP
    short ArchFiendmaxHP: 0x31B3E74; //This variable is focused on Archfiend's max hp which is the final boss of the game HP Acolyte and Warrior HP is 11250 13500 for Mentor MN HP is 16875
}


start{
	if(current.chapter == 0 && current.cutscene == 1){
        return true;
    }
}


split{
    // Chapter Splits
    if(current.chapter > old.chapter){
        return true;
    }

    // Final Split
    if((old.ArchFiendmaxHP == 11250 || old.ArchFiendmaxHP == 13500 ||old.ArchFiendmaxHP == 16875) && current.curBossHP == 0 && current.chapter == 16 && current.cutscene == 1){
        return true;
    }

}		
