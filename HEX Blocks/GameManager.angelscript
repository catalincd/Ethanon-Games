class GameManager
{
	string m_mainBall = "ball";
	string sufix = "_w";
	string m_mainPlayer = m_mainBall+sufix;
	string png = sufix+".png";
	string tray = "tray_none";
	string blockS = "sprites/block"+png;
	uint background = 0;
	uint color;
	uint rotate = 1;
	
	void parseColors()
	{
		PRIM = FloatColor(black);
		SEC = FloatColor(white);
	}
	
	
	
	void setMainColorWhite()
	{
		PRIM = FloatColor(white);
		SEC = FloatColor(black);
		sufix = "_w";
		refresh();
	}
	
	void setMainColorBlack()
	{
		PRIM = FloatColor(black);
		SEC = FloatColor(white);
		sufix = "_b";
		refresh();
	}
	
	void setColor(uint i)
	{
		if(i==1){setMainColorBlack();color=1;}
		if(i==0){setMainColorWhite();color=0;}
	}
	
	void refresh()
	{
		g_effector.background = background;
		g_effector.rotate = rotate;
		m_mainPlayer = m_mainBall+sufix;
		png = sufix+".png";
		blockS = "sprites/blockx"+png;
		dataBase.BLOCK = dataBase.BLOCK_I+sufix;
	}

	void select(uint type, string arg)
	{
		if(type==1)m_mainBall = arg;
		if(type==2)tray = arg;
		if(type==3)blockS = arg;
		if(type==4)background = parseUInt(arg);
		if(type==5)rotate = parseUInt(arg);
		refresh();
		dataBase.saveMisc();
	}
	
	bool check(uint type, string arg)
	{
		if(type==1 && arg==m_mainBall)return true;
		if(type==2 && arg==tray)return true;
		if(type==3 && arg==blockS)return true;
		if(type==4 && parseUInt(arg)==background)return true;
		if(type==5 && parseUInt(arg)==rotate)return true;
		return false;
	}
	
	string getType(uint type)
	{
		if(type==1)return "SKIN";
		if(type==2)return "EFFECT";
		if(type==3)return "BLOCK";
		if(type==4)return "BACKGROUND";
		if(type==5)return "ROTATION";
		return "";
	}
}

FloatColor PRIM;
FloatColor SEC;


GameManager g_gameManager;
