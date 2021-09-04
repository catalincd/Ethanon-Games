class ScoreManager : GameObject
{

	bool SAVED = false;
	uint lastScore = 0;
	uint timePlayed = 0;
	
	string getTag()
	{
		return "ScoreManager";
	}
	
	void create()
	{
		SAVED = false;
		timePlayed = 0;
	}
	
	void update()
	{
		
		timePlayed += GetLastFrameElapsedTime();
		
	}
	
	void resume()
	{
	
	}
	
	void saveScore()
	{
		uint total = CURRENT_SCORE_AVG * CURRENT_SCORE_COUNT;
		CURRENT_SCORE_COUNT++;
		CURRENT_SCORE_AVG = (total + lastScore)/CURRENT_SCORE_COUNT;
		
		TOTAL_BOOST_COINS += BOOST_COINS;
		
		if(lastScore > HIGH_SCORE)
		{
			HIGH_SCORE = lastScore;
			NEW_HIGH_SCORE = true;
		}
		
		uint thisScoreUnlocks = GetLastUnlockedByScore(lastScore);
		if(thisScoreUnlocks > UNLOCKED_COLORS)
		{
			UNLOCKED_COLORS = thisScoreUnlocks;
			NEW_COLOR_UNLOCKED = true;
			g_dataManager.save();
		}
	
		uint thisScoreUnlocksOv = GetLastUnlockedByCoins(TOTAL_BOOST_COINS);
		if(thisScoreUnlocksOv > UNLOCKED_OVERLAYS)
		{
			UNLOCKED_OVERLAYS = thisScoreUnlocksOv;
			NEW_OVERLAY_UNLOCKED = true;
			g_dataManager.save();
		}
			
		GAMES_PLAYED++;
		
		g_userDataManager.saveScore();
	}
}

ScoreManager g_scoreManager;

class PlayedTimeManager
{
	uint timePlayed;
	uint initTimeAlreadyPlayed;

	void create()
	{
		g_userDataManager.saveTime();
		timePlayed = 0;
		initTimeAlreadyPlayed = TIME_PLAYED_SECONDS;
	}
	
	void update()
	{
		timePlayed += GetLastFrameElapsedTime();
		TIME_PLAYED_SECONDS = initTimeAlreadyPlayed + (timePlayed / 1000);
	}
	
}

PlayedTimeManager g_playedTimeManager;

string GetTimePlayedString()
{
	string str = "";
	uint minutes = (TIME_PLAYED_SECONDS / 60);
	uint hours = minutes / 60;
	minutes %= 60;
	if(hours > 0)
	{
		str += ""+hours+"HR ";
		str += ""+minutes+"MIN";
	}
	else str += ""+minutes+" MINUTES";
	return str;
}

float GetScoreF()
{
	return (abs(GetCameraPos().y*10/GetScale()))- GetScreenSize().y/GetScale();
}

uint GetScore()
{
	return uint(max(0,GetScoreF()));
}

uint GetScore(uint certainPos)
{
	return (abs(certainPos*10/GetScale()))- GetScreenSize().y/GetScale();
}

uint GetLastUnlockedByScore(uint score)
{
	return min(score / 75000, 7);
}

uint GetLastUnlockedByCoins(uint coins)
{
	return min(coins / 30, 5);
}