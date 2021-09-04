﻿#include "isPointInRect.angelscript"

class Bar
{	private uint m_last;
	private string m_spriteName;
	private vector2 m_pos;
	private vector2 toch;
	private vector2 m_origin;
	private vector2 m_size;
	private bool m_isPressed;
	private vector2 m_size2;
	private uint m_alpha;
	private vector2 m_mpos;

	Bar(const string _spriteName, const vector2 &in _pos, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_origin = _origin;
		m_spriteName = _spriteName;
		m_pos = _pos;
		LoadSprite(m_spriteName);
		m_size = GetSpriteFrameSize(m_spriteName);
		m_size2 = m_size;
		m_isPressed = false;
		m_alpha = ARGB(255, 255, 255, 255);
	}
	
	void SetV2(vector2 _v2)
	{
	toch=_v2;
	}
	
	vector2 getPos()
	{
		return m_pos;
	}

	void setPos(const vector2 _pos)
	{
		m_pos = _pos;
	}

	void setButtonBitmap(const string &in _spriteName)
	{
		m_spriteName = _spriteName;
	}

	string getButtonBitmap()
	{
		return m_spriteName;
	}

	void putBar()
	{
		putButton(vector2(0,0));
	}

	void putButton(const vector2 &in offset)
	{
		update();
		draw(offset);
	}

	void draw()
	{
		draw(vector2(0,0));
	}

	void draw(const vector2 &in offset)
	{
		SetSpriteOrigin(m_spriteName, m_origin);
		DrawShapedSprite(m_spriteName, m_pos + offset, m_size2, m_alpha);
	}

	vector2 getSize() const
	{
		return m_size;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, m_pos, m_size, m_origin));
	}

	void update()
	{
		ETHInput@ input = GetInputHandle();

		// check if any touch (or mouse) input is pressing the button
		const uint touchCount = input.GetMaxTouchCount();
		for (uint t = 0; t < touchCount; t++)
		{
		if (input.GetKeyState(K_LMOUSE) == KS_HIT)
		{m_last=GetTime();}
			if (input.GetKeyState(K_LMOUSE) == KS_DOWN)
			{
				if (isPointInButton(input.GetCursorPos()))
				{
					move();
				}
			}
		}
		
		if (isPointInButton(input.GetCursorPos()))
				{
					m_alpha=ARGB(255,202,202,202);
					
				}
		
	}
	
	void move()
	{
	int x=(GetTime()-m_last)/100;
	toch.x+=x;
	}
	
	bool isPressed()
	{
		return m_isPressed;
	}

	void setPressed(const bool pressed)
	{
		m_isPressed = pressed;
	}
}













