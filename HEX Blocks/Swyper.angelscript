class Swyper
{
	int m_currentPage = 1;
	float touchPos;
	float offset = 0;
	float xoffset = 0;
	float offsetFinal = 0;
	uint touchTime;
	float touchLen;
	bool resuming = false;
	float speed = UnitsPerSecond(4000);
	Swyper(){}
	
	float getOffset()
	{
		xoffset = offset+offsetFinal;
		if(m_currentPage == 0)xoffset = max(xoffset, 0);
		if(m_currentPage == 2)xoffset = min(xoffset, 0);
		return resuming? offsetFinal:xoffset;
	}
	
	bool touch()
	{
		return (float(getOffset()/GetScreenSize().x)<0.0075);
	}
	
	void updateMain()
	{
		float xxx=float(getOffset()/GetScreenSize().x);
		DrawText(vector2(0,100), ""+touchLen+" OF:"+offset+" RATIO:"+xxx, "Verdana30.fnt", black);
		if(resuming)
		{
			if(abs(offsetFinal)<3.0)
			{
				offsetFinal = 0;
				resuming = false;
				offset = 0;
			}
			offsetFinal -= speed*sign(offset);
		}
		
		KEY_STATE state = GetInputHandle().GetTouchState(0);
		if(state == KS_HIT)
		{
			resuming = false;
			offset = 0;
			touchTime = GetTime();
			touchPos = GetInputHandle().GetTouchPos(0).x;
		}
		if(state == KS_DOWN)
		{
			offset = GetInputHandle().GetTouchPos(0).x-touchPos;
		}
		if(state == KS_RELEASE)
		{
			touchLen = float(GetTime()-touchTime);
			offsetFinal += offset;
			check();
		}
	}
	 
	void check()
	{
		if(abs(offset)/GetScreenSize().x<0.3)
			resuming = true;
		
	}
}