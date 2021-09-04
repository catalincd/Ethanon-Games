void execGameOver()
{
	if(!GAME_OVER)
	{
		GAME_OVER = true;
		o_jumper.destroy();
		scoreManager.addNewScore(o_trap.getCamInt());
	}
}


class GameOverManager : GameObject
{
	void create()
	{
		GAME_OVER = false;
	}
	
	void update()
	{
	
	}
	
	void resume()
	{
	
	}
	
	string getTag()
	{
		return "GameOver";
	}
}

GameOverManager o_gameOver;