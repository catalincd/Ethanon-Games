string tip0 =  "YOU CAN SWITCH BETWEEN COLORS\nAND OVERLAYS IN THE SETTINGS";
string tip1 =  "IF YOU ARE ANNOYED WITH THE ADS,\nYOU CAN DISABLE THEM IN THE SETTINGS";
string tip2 =  "YOU CAN CHOOSE NOT TO DRAW\nTHE EYES OR THE OVERLAYS IN-GAME";
string tip3 =  "YOU CAN ALWAYS GO THROUGH THE TUTORIAL \nAGAIN, JUST TURN IT ON IN THE SETTINGS";
string tip4 =  "IF YOU DO NOT FEEL COMFORTABLE WITH THE \nSWIPE CONTROLS, YOU MAY WANT TO SWITCH TO\nTOUCH CONTROLS";

string[] tips = {tip0, tip1, tip2, tip3, tip4};

class TipManager
{

	float tipPos = 250;
	uint currentTip = 0;
	float tipScale = 1.0f;
	uint lastTip = 0;

	void create()
	{
		tipPos = 225*GetScale();
		currentTip = rand(0, tips.length()-1);
	}
	
	void update(uint color)
	{
		if(SHOW_TIPS)
			if(GAMES_PLAYED != 0)
				DrawCenteredPosLines(tips[currentTip], tipPos, tipScale, "Verdana30.fnt", color);
		if(GetInputHandle().GetKeyState(K_DOWN) == KS_HIT)
		{
			lastTip = currentTip;
			while(currentTip==lastTip)
				currentTip = rand(0, tips.length()-1);
		}
	}
}

TipManager g_tipManager;