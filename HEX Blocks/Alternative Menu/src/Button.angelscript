

class Button
{
	private string m_spriteName;
	private string m_text;
	private string m_text2;
	private string m_font;
	private vector2 m_pos;
	private vector2 m_origin;
	private vector2 m_size;
	private vector2 m_lockoffset;
	private vector2 m_textoffset;
	private vector2 m_textoffset2;
	private bool m_isPressed;
	private float m_scale;
	private float m_scale_final;
	private uint m_color;
	private uint m_color_2;
	private uint m_color_3;
	private uint m_color_f;
	private uint lockCol;
	private bool sec = false;
	private bool text = false;
	private bool text2 = false;
	private string sec_spriteName;
	bool locked = false;
	bool new = false;
	uint bounceTime;
	bool bUp = false;
	bool bouncing = false;
	private InterpolationTimer@ timer;
	
	Button(const string _spriteName, const vector2 &in _pos, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_origin = _origin;
		m_spriteName = _spriteName;
		m_pos = _pos;
		LoadSprite(m_spriteName);
		m_size = GetSpriteFrameSize(m_spriteName);
		setSpriteOrigin(m_spriteName, m_origin);
		m_isPressed = false;
		m_scale = 1.0f;
		m_scale_final = 1.0f;
		bounceTime = 350;
		m_color = white;
		m_color_2 = black;
		m_color_3 = SEC.getUInt();
		text = false;
		text2 = false;
		locked = false;
		new = false;
		lockCol = PRIM.getUInt();
		m_lockoffset = vector2(0,30);
		m_font = "Text25.fnt";
	}
	
	void setTextColor(uint col)
	{
		m_color_3 = col;
	}

	void setSecondarySprite(string path)
	{
		sec = true;
		sec_spriteName = path;
		setSpriteOrigin(sec_spriteName, m_origin);
		LoadSprite(sec_spriteName);
	}

	void setLock()
	{
		locked = true;
		m_color_2 = 0xFF999999;
		LoadSprite("sprites/lock.png");
		setSpriteOrigin("sprites/lock.png", V2_HALF);
	}
	
	void seen()
	{
		new = false;
		m_scale = m_scale_final;
	}
	
	void setNew(uint delay)
	{
		new = true;
		bouncing = true;
		@timer = InterpolationTimer(delay);
	}

	void setText(string text_)
	{
		m_text = text_;
		text = true;
		m_textoffset = (ComputeTextBoxSize(m_font, m_text)/2+vector2(0,40))*GetScale();
	}

	void setText2(string text_)
	{
		m_text2 = text_;
		text2 = true;
		m_textoffset2 = (ComputeTextBoxSize(m_font, m_text2)/2 - vector2(0,45))*GetScale();
	}
	
	vector2 getPos()
	{
		return m_pos;
	}
	
	void setColor(uint col)
	{
		m_color = col;
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

	void setScale(float sc)
	{
		m_scale_final = sc;
		if(!bouncing)
		m_scale = sc;
	}

	void putButton()
	{
		putButton(vector2(0,0));
	}

	void putButton(const vector2 &in offset)
	{
		draw(offset);
		if(!locked)
			update();
		else drawLock();
		if(text)
			drawText();
		if(text2)
			drawText2();
	}
	
	void drawOnly()
	{
		draw();
		if(locked)
			 drawLock();
		if(text)
			drawText();
		if(text2)
			drawText2();
	}
	
	void drawText()
	{
		uint alpha =(0xFF000000 & m_color) >> 24;
		uint m_c3 = ARGB(alpha, SEC);
		uint m_textColor = locked? (m_c3 & black):m_c3;
		DrawText(m_pos-m_textoffset*m_scale, m_text, m_font, m_textColor, GetScale()*m_scale);
	}
	
	void drawText2()
	{
		uint alpha =(0xFF000000 & m_color) >> 24;
		uint m_c3 = ARGB(alpha, SEC);
		DrawText(m_pos-m_textoffset2*m_scale, m_text2, m_font, m_c3, GetScale()*m_scale);
	}

	void drawLock()
	{
		uint alpha =(0xFF000000 & m_color) >> 24;
		uint m_c3 = ARGB(alpha, SEC);
		drawSprite("sprites/lock.png", m_pos+m_lockoffset*m_scale, m_scale*0.7*GetScale(), m_c3);
	}

	void draw()
	{
		draw(vector2(0,0));
	}

	void draw(const vector2 &in offset)
	{
		
		m_color_f = new? (m_color&paleRed):m_color;
		drawSprite(m_spriteName, m_pos + offset, m_scale, m_color_f);
		if(sec)
		{
			if(locked)
				m_color_2 = m_color & grey;
			else 
				m_color_2 = m_color;
			
			drawSprite(sec_spriteName, m_pos + offset, m_scale, m_color_2);
		}
	}

	vector2 getSize() const
	{
		return m_size;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, m_pos, m_size*m_scale*GetScale(), m_origin));
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
		
		if(new && bouncing)
		{
			timer.update();
			if(timer.isOver())
			{
				timer.reset(bounceTime);
				bUp = !bUp;
			}
			m_scale = m_scale_final + (0.1*(bUp? timer.getBias():1.0-timer.getBias()));
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




class TextButton
{
	private string m_text;
	private string m_font;
	private vector2 m_pos;
	private vector2 m_origin;
	private vector2 m_size;
	private bool m_isPressed;
	private float m_scale;
	private uint m_color;
	private bool m_ascending = true;
	private float m_opBias = 0;
	private uint m_timeCount = 0;
	bool m_itWas = false;
	uint hitTime;
	bool m_switchingColors = false;
	private vector2 textBoxSize2;
	FloatColor m_primaryColor;
	FloatColor m_secondaryColor;
	INTERPOLATION_FILTER@ m_filter;
	
	TextButton(const string _text, string _font,const vector2 &in _pos, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_origin = _origin;
		m_text = _text;
		m_pos = _pos;
		m_font = _font;
		m_size = ComputeTextBoxSize(m_font, m_text);
		textBoxSize2 = m_size/2;
		m_isPressed = false;
		m_scale = 1.0f;
		m_color = PRIM.getUInt();
		m_timeCount = 0;
		@m_filter = smoothEnd;
	}

	vector2 getPos()
	{
		return m_pos;
	}
	
	void setFilter(INTERPOLATION_FILTER@ _filter)
	{
		@m_filter = _filter;
	}
	void setColor(uint col)
	{
		m_color = col;
		m_switchingColors = false;
	}
	
	vector2 getTextSize()
	{
		return textBoxSize2*GetScale();
	}

	void setPos(const vector2 _pos)
	{
		m_pos = _pos;
	}
	
	void setSecondaryColor(uint col)
	{
		m_secondaryColor.setColor(col);
		m_primaryColor.setColor(m_color);
		m_switchingColors = true;
	}
	
	void setScale(float sc)
	{
		m_scale = sc;
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
		
		vector2 xpos = m_pos - (m_origin*m_size*GetScale());
		DrawText(xpos, m_text, m_font, m_color, m_scale*GetScale());
	}

	vector2 getSize() const
	{
		return m_size;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, m_pos, m_size*m_scale*GetScale(), m_origin));
	}

	void update()
	{
		ETHInput@ input = GetInputHandle();
		if(m_switchingColors)
		{
			if(m_ascending)
			{
				m_opBias += UnitsPerSecond(2);
				if(m_opBias>1)
				{
					m_opBias = 1;
					m_ascending = false;
				}
			}
			else
			{
				m_opBias -= UnitsPerSecond(2);
				if(m_opBias<0)
				{
					m_opBias = 0;
					m_ascending = true;
				}
			}
			m_color = getUInt(interpolate(m_primaryColor, m_secondaryColor, m_filter(m_opBias)));
		
		}
	
		// check if any touch (or mouse) input is pressing the button
		const uint touchCount = input.GetMaxTouchCount();
		for (uint t = 0; t < touchCount; t++)
		{
			if (input.GetTouchState(t) == KS_HIT)
			{
				if (isPointInButton(input.GetTouchPos(t)))
				{
					m_isPressed = true;
					hitTime = GetTime();
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




class UseButton
{
	private string m_spriteName;
	private vector2 m_pos;
	private vector2 m_origin;
	private vector2 m_size;
	private float m_scale;
	private bool m_isPressed;
	private bool locked = false;
	private string text;
	private vector2 textSize;
	private string font;
	bool stroke;
	uint m_color;
	float m_factor;

	UseButton(const vector2 &in _pos, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_origin = _origin;
		m_pos = _pos;
		m_isPressed = false;
		locked = false;
		font = "Text50.fnt";
		text = "SELECT";
		m_scale = 1;
		m_factor = 1.2;
		textSize = ComputeTextBoxSize(font, text)*GetScale();
		stroke = true;
		m_color = black;
	}

	void setColor(uint _color)
	{
		m_color = _color;
	}
	
	void setScale(float _scale)
	{
		m_scale = _scale;
	}
	
	void lock()
	{
		text = "SELECTED";
		textSize = ComputeTextBoxSize(font, text)*GetScale();
		locked = true;
	}
	
	void lock(string txt)
	{
		text = txt;
		textSize = ComputeTextBoxSize(font, text)*GetScale();
		locked = true;
	}
	
	void setText(string txt, string fnt)
	{
		text = txt;
		font = fnt;
		textSize = ComputeTextBoxSize(font, text)*GetScale();
		locked = false;
	}
	

	vector2 getPos()
	{
		return m_pos;
	}

	void setPos(const vector2 _pos)
	{
		m_pos = _pos;
	}


	void putButton()
	{
		putButton(vector2(0,0));
	}

	void putButton(const vector2 &in offset)
	{
		if(!locked)
		update();
		draw(offset);
	}

	void draw()
	{
		draw(vector2(0,0));
	}

	void draw(const vector2 &in offset)
	{
		//SetSpriteOrigin(m_spriteName, m_origin);
		//DrawSprite(m_spriteName, m_pos + offset);
		uint alpha = (0xFF000000 & m_color) >> 24;
		uint m_fcolor = locked? ARGB(alpha, 128, 128, 128):m_color;
		DrawText(m_pos-(textSize*m_origin*m_scale), text, font, m_fcolor, GetScale()*m_scale);
		
		if(stroke)
			DrawRectangleSpriteStroke(m_pos-(textSize*m_origin*m_factor*m_scale)+vector2(0,uint(7*GetScale())), m_pos+(textSize*(V2_ONE-m_origin)*m_factor*m_scale), uint(7*GetScale()), m_fcolor);
	}


	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, m_pos, textSize*m_scale*m_factor, m_origin));
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

	void setPressed(const bool pressed)
	{
		m_isPressed = pressed;
	
	}
}
