float OFFSET_LIMIT = 0.4f;
uint TIME_LIMIT = 250;

float OFFSET_LIMIT_REL = 0.3f;
uint TIME_LIMIT_REL = 500;

float ALREADY_RATIO = 0.0015f;
float ALREADY_RATIO_REL = 0.0007f;

class Swyper
{
	private int pos = 0;
	private float m_offset = 0;
	private uint m_touchTime;
	private bool m_allowed = false;
	private float m_touchPos;
	private float m_currentTouchPos;
	private vector2 touchPauseLimit = 32;
	
	Swyper()
	{
		m_offset = 0;
	}
	
	void limitPos()
	{
		if(pos < -1) pos = -1;
		if(pos > 1) pos = 1;
	}
	
	void create()
	{
		pos = 0;
		touchPauseLimit = GetScreenSize() - vector2(100,100)*GetScale();
	}
	

	
	void update()
	{
		if(WINDOWS)
		{
			ETHInput@ input = GetInputHandle();
			if(input.GetKeyState(K_A)==KS_HIT)
			{
				pos--;
				limitPos();
			}
			else if(input.GetKeyState(K_D)==KS_HIT)
			{
				pos++;
				limitPos();
			}
			
		}
		if(!g_pauseManager.pause)
		updateAndroid();
	}
	
	void updateAndroid()
	{
		if(TOUCH_CONTROLS)
			updateAndroidTouch();
		else 
			updateAndroidSwype();
	}
	
	float getOffset()
	{
		return abs(m_currentTouchPos - m_touchPos) / GetScreenSize().x;
	}
	
	float getSign()
	{
		return sign(m_currentTouchPos - m_touchPos);
	}
	
	uint getElapsed()
	{
		return GetTime() - m_touchTime;
	}
	
	
	void updateAndroidTouch()
	{
		const float xHalf = GetScreenSize().x/2;
		ETHInput@ input = GetInputHandle();
		if(input.GetTouchState(0) == KS_HIT)
		{
			int thisSign = 1;
			vector2 touchPos = input.GetTouchPos(0);
			if(touchPos.x < xHalf)
				thisSign = -1;
			if(touchPos.x > touchPauseLimit.x && touchPos.y > touchPauseLimit.y)
			{
				thisSign = 0;
			}
			pos += thisSign;
			limitPos();
		}
	}
	
	void updateAndroidSwype()
	{
		const vector2 screenSize(GetScreenSize());
		ETHInput@ input = GetInputHandle();
		const KEY_STATE touchState = input.GetTouchState(0);
		if (touchState == KS_HIT)
		{
			m_touchTime = GetTime();
			m_touchPos = input.GetTouchPos(0).x;
			m_allowed = true;
		}
		else if (touchState == KS_DOWN)
		{
			m_currentTouchPos = input.GetTouchPos(0).x;
			
			if(m_allowed)
			{
				bool passedBy = (getOffset() > OFFSET_LIMIT && getElapsed() < TIME_LIMIT);
				bool alreadyPassed = getOffset() / max(1,float(getElapsed())) > ALREADY_RATIO;
				if(passedBy || alreadyPassed)
				{
					pos += getSign();
					limitPos();
					m_allowed = false;
				}
			}
			
		}
		if (touchState == KS_RELEASE)
		{
			if(m_allowed)
			{
				bool passedBy = (getOffset() > OFFSET_LIMIT_REL && getElapsed() < TIME_LIMIT_REL);
				bool alreadyPassed = getOffset() / max(1,float(getElapsed())) > ALREADY_RATIO_REL;
				//bool underTime = (getElapsed() < 120);
				if(passedBy || alreadyPassed)
				{
					pos += getSign();
					limitPos();
				}
			}
		}
		
	}
	
	int getPos()
	{
		return pos;
	}
	
}