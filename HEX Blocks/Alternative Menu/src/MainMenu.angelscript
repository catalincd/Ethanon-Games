class MainMenu
{

	MenuButton@[] m_buttons;
	uint len = 3;
	
	
	void create()
	{
		m_buttons.resize(0);
		m_buttons.insertLast(MenuButton("START", vector2(360, 750)*GetScale(), GetScale()));
		m_buttons.insertLast(MenuButton("OPTIONS", vector2(360, 900)*GetScale(), GetScale()));
		m_buttons.insertLast(MenuButton("SUPPORT", vector2(360, 1050)*GetScale(), GetScale()));
	
	}

	void update(float offset, bool touch, vector2 touchPos)
	{
		float bias = max(0,(150-abs(offset)/GetScale())/180.0);
		float bias2 = min(1, bias*1.5);
		uint b_color = ARGB(uint(255.0*bias2), 0,0,0);
		for(uint i=0;i<len;i++)
		{
			m_buttons[i].setOffset(offset);
			m_buttons[i].update(touch, touchPos);
			m_buttons[i].setColor(b_color);
			if(m_buttons[i].isPressed())
			{
				print(i);
				m_buttons[i].setPressed(false);
			}
		}
	}
}


MainMenu mainMenu;