class MenuButton
{
	private string m_text;
	private string m_font;
	private vector2 m_pos;
	private vector2 m_origin;
	private vector2 m_size;
	private bool m_isPressed;
	private vector2 m_offset;
	private vector2 m_offsetRnd;
	private float m_scale;
	private uint m_color;
	private bool m_float;
	private PositionRandomizer pr;

	MenuButton(const string _text, const vector2 &in _pos, const float _scale, const bool&in fl = true, const vector2 &in _origin = vector2(0.5f, 0.5f))
	{
		m_float = fl;
		m_origin = _origin;
		m_scale = _scale;
		m_text = _text;
		m_pos = _pos;
		m_font = "Verdana64.fnt";
		m_size = ComputeTextBoxSize(m_font, m_text);
		m_scale = GetScale() * 2.0f;
		m_offset = V2_ZERO;
		m_isPressed = false;
		m_color = black;
		m_offsetRnd = V2_ZERO;
		pr.create(0.1,0.5*GetScale(), 50*GetScale());
	}

	vector2 getPos()
	{
		return m_pos;
	}

	void setPos(const vector2 _pos)
	{
		m_pos = _pos;
	}

	void setColor(uint c)
	{
		m_color = c;
	}

	void setOffset(vector2 v)
	{
		m_offset = v;
	}
	
	void setOffset(float v)
	{
		m_offset = vector2(v,0);
	}
	
	void draw()
	{
		vector2 f_pos =  m_pos + m_offsetRnd + m_offset - (m_size*m_origin*m_scale);
		DrawText(f_pos, m_text, m_font, m_color, m_scale);
	}


	vector2 getSize() const
	{
		return m_size;
	}

	bool isPointInButton(const vector2 &in p) const
	{
		return (isPointInRect(p, m_pos+m_offset+m_offsetRnd, m_size*m_scale, m_origin));
	}

	void update()
	{
		draw();
		if(m_float)
		{
			pr.update();
			m_offsetRnd = pr.getOffset();
		}
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			vector2 pos = GetInputHandle().GetTouchPos(0);
			if(isPointInButton(pos))
				m_isPressed = true;
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

uint black = 0xFF000000;