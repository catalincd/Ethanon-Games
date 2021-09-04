class ScoreManager
{
	bool newAchievement = false;
	bool weHaveNew = false;
	uint[] newAch;

	void onCreate()
	{
		dataBase.loadMisc();
	}

	void updateData()
	{
		
		if(!scoreAdder.added)
		{
			CURRENT_LEVEL_XP = scoreAdder.toAdd;
			scoreAdder.toAdd = 0;
			CURRENT_TOTAL_XP+=CURRENT_LEVEL_XP;
			if(CURRENT_LEVEL_XP > BEST_XP)
			{
				oldBest = BEST_XP;
				BEST_XP = CURRENT_LEVEL_XP;
			}
			scoreAdder.added = true;
		}
		dataBase.saveMisc();
		checkForNewAch();
		if(weHaveNew)
		{
			weHaveNew = false;
			g_achievementManager.save();
		}
	}
	
	void checkForNewAch()
	{
		if(CURRENT_TOTAL_XP>g_achievementManager.getXpReq() && g_achievementManager.getXpReq()!=0)
		{
		g_achievementManager.newAchievement();
		checkForNewAch();
		weHaveNew = true;
		}
	}
	
	

}

ScoreManager g_scoreManager;