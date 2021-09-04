//1
uint emerald = 0xFF00C957;
uint turquoise = 0xFF00C78C;
uint paleGreen = 0xFF00C78C;

//2
uint deepPink = 0xFF8B0A50;
uint blueviolet = 0xFF8A2BE2;
uint red = 0xFFFF0000;

//3
uint aqua = 0xFF00FFFF;
uint blue = 0xFF0000FF;
uint steelBlue = 0xFF1E90FF;

//4
uint grey = 0xFF999999;
uint darkGrey = 0xFF777777;
uint lightGrey = 0xFFBBBBBB;

//5

uint yellow = 0xFFFFFF00;
uint darkYellow = 0xFFF0E68C;
uint gold = 0xFFFFD700;

//6
uint orangeContrast = 0xFFCD8500;
uint orangePale = 0xFFEEAD0E;
uint orangeRed = 0xFFFF7000;


class ColorManager : GameObject
{
	string getTag()
	{
		return "Colors";
	}
	
	uint idx = 0;
	uint[] allColors = {white, white, white, emerald, turquoise, paleGreen, deepPink, blueviolet, red, aqua, blue, steelBlue, grey, darkGrey, lightGrey,
						yellow, darkYellow, gold ,orangeContrast, orangePale, orangeRed};
	vector3[] currentColors;
	
	
	void create()
	{
		idx = 0;
		currentColors.resize(0);
		uint cycles = allColors.length() / 3;
		 cycles = 8;
		for(uint t=0;t<cycles;t++)
		{
			//vector3 currentColor = COL(allColors[t*3 + rand(0,2)]);
			currentColors.insertLast(COL(GetColorFromIdx(t)));
		}
	}
	
	void update()
	{
		
	}
	
	void resume()
	{
	
	}
	
	vector3 getCurrentColor()
	{
		uint ratio = GetScore() / 75000;
		return currentColors[min(ratio, 7)];
	}
	
	vector3 getCurrentColor(uint pos)
	{
		uint ratio = GetScore(pos) / 75000;
		return currentColors[min(ratio, 7)];
	}

}

ColorManager g_colorManager;