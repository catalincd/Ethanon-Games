#include "isPointInRect.angelscript"

class Button
{
	private string m_spriteName;
	private vector2 m_pos;
	private vector2 m_origin;
	private vector2 m_size;
	private bool m_isPressed;
	private bool m_isReleased;

	Button(const string _spriteName, const vector2 &in _pos, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_origin = _origin;
		m_spriteName = _spriteName;
		m_pos = _pos;
		LoadSprite(m_spriteName);
		m_size = GetSpriteFrameSize(m_spriteName);
		m_isPressed = false;
		m_isReleased = false;
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

	void putButton()
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
		DrawSprite(m_spriteName, m_pos + offset);
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
			if (input.GetTouchState(t) == KS_HIT)
			{
				if (isPointInButton(input.GetTouchPos(t)))
				{
					m_isPressed = true;
				}
			}
			
		}
		
	}

	bool isPressed()
	{
		return m_isPressed;
	}

	bool isReleased()
	{
		return true;
	}

	void setPressed(const bool pressed)
	{
		m_isPressed = pressed;
	}
}



class TextButton
{
	string text;
	string font;
	uint color;
	vector2 position;
	vector2 relativePosition;
	vector2 size;
	vector2 origin;
	bool m_isPressed;
	bool enabled = true;
	float scale = 1.0f;
	
	TextButton(vector2 _pos, string _text, string&in _font="Verdana30.fnt", uint&in _color=white, vector2 &in _origin=V2_HALF)
	{
		position = _pos;
		text = _text;
		font = _font;
		color = _color;
		origin = _origin;
		size = ComputeTextBoxSize(font, text) * GetScale();
		relativePosition = position - (size * origin);
		m_isPressed = false;
		enabled = true;
		scale = 1.0f;
	}
	
	void setScale(float scl)
	{
		scale = scl;
		size = ComputeTextBoxSize(font, text) * GetScale() * scale;
		relativePosition = position - (size * origin);
	}
	
	vector2 getSize()
	{
		return size;
	}
	
	void disable()
	{
		enabled = false;
	}
	
	void enable()
	{
		enabled = true;
	}
	
	void setText(string _text)
	{
		text = _text;
		size = ComputeTextBoxSize(font, text) * GetScale() * scale;
		relativePosition = position - (size * origin);
		m_isPressed = false;
	}
	
	void setColor(uint col)
	{
		color = col;
	}
	
	void update()
	{
		updateInput();
		draw();
	}
	
	void draw()
	{
		if(enabled)
			DrawText(relativePosition, text, font, color, GetScale() * scale);
		else
		{
			vector2 newRelativePosition = position - (size * origin * 0.75 * scale);
			DrawText(newRelativePosition, text, font, greyB, GetScale()*0.75*scale);
		}
		//uint xcolor = ARGB(100,255,255,255);
		//DrawRectangle(relativePosition, size, xcolor,xcolor,xcolor,xcolor);
	}
	
	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, position, vector2(size.x*1.2, size.y), origin));
	}

	void updateInput()
	{
		ETHInput@ input = GetInputHandle();

		const uint touchCount = input.GetMaxTouchCount();
		for (uint t = 0; t < touchCount; t++)
		{
			if (input.GetTouchState(t) == KS_HIT)
			{
				if (isPointInButton(input.GetTouchPos(t)))
				{
					m_isPressed = true;
				}
			}
			
		}
		
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
