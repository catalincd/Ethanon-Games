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
	uint colorNow;
	vector2 position;
	vector2 relativePosition;
	vector2 size;
	vector2 origin;
	bool m_isPressed;
	bool enabled = true;
	bool fadeOut = false;
	bool fading = false;
	float m_scale = 1.0f;
	InterpolationTimer@ fadeTimer = InterpolationTimer(300);
	
	TextButton(vector2 _pos, string _text, string&in _font="Verdana30.fnt", uint&in _color=white, bool fade = false, vector2 &in _origin=V2_HALF)
	{
		position = _pos;
		text = _text;
		font = _font;
		color = _color;
		colorNow = color;
		origin = _origin;
		size = ComputeTextBoxSize(font, text) * GetScale();
		relativePosition = position - (size * origin);
		m_isPressed = false;
		enabled = true;
		fadeOut = fade;
		fading = false;
		m_scale = 1.0f;
	}
	
	void resetAnim()
	{
		fading = false;
		m_scale = 1.0f;
		colorNow = color;
	}

	
	void setPosition(vector2 pos)
	{
		position = pos;
		relativePosition = position - (size * origin * m_scale);
	}
	
	void setScale(float sc)
	{
		m_scale = sc;
		relativePosition = position - (size * origin * m_scale);
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
		size = ComputeTextBoxSize(font, text) * GetScale();
		relativePosition = position - (size * origin);
		m_isPressed = false;
	}
	
	void setColor(uint col)
	{
		color = col;
		colorNow = color;
	}
	
	void update()
	{
		updateInput();
		draw();
		if(fadeOut && fading)
		{
			fadeTimer.update();
			colorNow = interpolateColor(color, FADE_WHITE, fadeTimer.getBias());
			setScale(interpolate(1.0f, 1.5f, fadeTimer.getBias()));
		}
	}
	
	void startFading()
	{
		fadeTimer.reset(300);
		fading = true;
	}
	
	
	void draw()
	{
		if(enabled)
			DrawText(relativePosition, text, font, colorNow, GetScale() * m_scale);
		else
		{
			vector2 newRelativePosition = position - (size * origin * 0.75);
			DrawText(newRelativePosition, text, font, greyB, GetScale()*0.75);
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
					if(fadeOut && !fading) 
						startFading();
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


class ItemSelectorButton
{
	string sprite;
	uint id;
	uint buttonId;
	bool enabled = false;
	bool selected = false;
	bool main = false;
	vector2 pos;
	vector2 size;

	//ItemSelectorButton(){}

	ItemSelectorButton(string spriteN, vector2 posN, uint idN, uint buttonIdN, bool mainN = false, bool enabledN = true)
	{
		sprite = spriteN;
		pos = posN;
		id = idN;
		enabled = enabledN;
		main = mainN;
		buttonId = buttonIdN;
		selected = false;
		size = V2_100 * 1.5f;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, pos, size, V2_HALF));
	}

	void update()
	{

		if(enabled)
		{
			ETHInput@ input = GetInputHandle();
			if(input.GetTouchState(0) == KS_HIT)
			{
				vector2 touchPos = input.GetTouchPos(0);
				if(isPointInButton(touchPos))
				{
					selected = !selected;
					if(main)
						g_itemSelector.push(id, buttonId);
					else
						g_itemSelector.pushAuto(id, buttonId);
				}
			}
			drawEnabled();
		}
		else
			drawDisabled();
	}

	void drawEnabled()
	{
		DrawShapedSprite(sprite, pos, size, white);
		DrawShapedSprite("sprites/stroke_item.png", pos, size, selected? (main? blue:red):black);
	}

	void drawDisabled()
	{
		DrawShapedSprite(sprite, pos, size, grey);
		DrawShapedSprite("sprites/stroke_item.png", pos, size, grey);
	}

	void enable()
	{
		enabled = true;
	}

}




class MarketButton
{
	string sprite;
	uint turretId;
	uint arrayId;
	vector2 pos;
	vector2 size;
	bool main = false;
	bool enabled = false;
	bool selected;
	//ItemSelectorButton(){}

	MarketButton(string spriteN, vector2 posN, uint idN, uint buttonIdN, bool mainN = false)
	{
		sprite = spriteN;
		pos = posN;
		turretId = idN;
		arrayId = buttonIdN;
		main = mainN;
		selected = false;
		enabled = false;
		size = V2_100 * 1.5f;
	}
	
	void setPosition(vector2 p)
	{
		pos = p;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, pos, size, V2_HALF));
	}

	void update()
	{

		ETHInput@ input = GetInputHandle();
		if(input.GetTouchState(0) == KS_HIT)
		{
			vector2 touchPos = input.GetTouchPos(0);
			if(isPointInButton(touchPos))
			{
				selected = !selected;
				g_market.select(arrayId);
			}
		}
		if(enabled)
			drawEnabled();
		else
			drawDisabled();
	}
	
	void deselect()
	{
		selected = false;
	}
	
	void enable()
	{
		enabled = true;
	}

	void drawEnabled()
	{
		DrawShapedSprite(sprite, pos, size, white);
		DrawShapedSprite("sprites/stroke_item.png", pos, size, selected? DEEP_ORANGE:black);
	}

	void drawDisabled()
	{
		DrawShapedSprite(sprite, pos, size, grey);
		DrawShapedSprite("sprites/stroke_item.png", pos, size, selected? AQUA_BLUE:grey);
	}

}



bool putButton(string sprite, vector2 pos, float scale, vector2 origin = V2_HALF, uint color = white, float angle = 0.0f)
{
	vector2 size = GetSpriteSize(sprite) * scale;
	vector2 relPos = pos - (size * origin);
	bool pressed = false;
	if(GetInputHandle().GetTouchState(0) == KS_HIT)
	{
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		pressed = isPointInRect(touchPos, pos, size, origin);
	}
	color = pressed? color & grey : color;
	DrawShapedSprite(sprite, relPos, size, color, angle);
	return pressed;
}