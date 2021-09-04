uint CONTROL_TYPE = 0;
bool GAME_OVER = false;
bool PAUSE = false;
bool FROM_GAME = false;
uint LAST_SCORE;
uint BEST_SCORE = 0;
uint BEST_XP = 0;
uint oldBest;
uint GAMES_PLAYED = 0;
uint CURRENT_LEVEL = 0;
float CURRENT_TOTAL_TIME = 0;
uint CURRENT_TOTAL_XP = 0;
uint CURRENT_LEVEL_XP = 0;
uint numAch = 5;
vector2 SCREEN_SIZE = getScreenSize();
vector2 SCREEN_SIZE_2 = getScreenSize()/2;
vector2 V2_ONE = vector2(1.0,1.0);
vector2 V2_HALF = vector2(0.5,0.5);
float SCREEN_SIZE_X = getScreenSize().x;
float SCREEN_SIZE_X2 = getScreenSize().x/2;
float SCREEN_SIZE_Y = getScreenSize().y;
float SCREEN_SIZE_Y2 = getScreenSize().y/2;
bool GO_LEFT = false;
bool GO_RIGHT = false;
float scale_factor = 1;
vector2 CAM_END_POS;

bool uintToBool(uint t)
{
	return t!=0;
}

uint boolToUInt(bool t)
{
	return t? 1:0;
}

bool stringToBool(string t)
{
	return (t=="TRUE" || t=="true");
}

string boolToString(bool t)
{
	return t? "TRUE":"FALSE";
}

//float SC = GetScale();


//////////////////////////////////////
/////////////////////////// ON RESUME RE SWITCH BACKGROUND COLOR TO WHITE
///////////////////LOAD STATS BEFORE GAME AND IT IS ZERO SCORE



class ScoreAdder
{
	bool added = false;
	uint toAdd;
}

ScoreAdder scoreAdder;

