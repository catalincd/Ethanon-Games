class Text
{
	string m_text;
	string m_font;
	float m_scale;
	vector2 m_pos;
	vector2 m_relativePos;
	vector2 m_size;
	vector2 m_origin;
	uint m_color;
	Text(){}
	Text(vector2 _pos, string _text, string&in _font = fnt, uint&in _color = white, float&in _scale = 1.0f, vector2&in _origin = V2_HALF)
	{
		m_text = _text;
		m_font = _font;
		m_scale = _scale;
		m_pos = _pos;
		m_origin = _origin;
		m_color = _color;
		m_size = ComputeTextBoxSize(m_font, m_text)*m_scale*GetScale();
		m_relativePos = m_pos-(m_size*m_origin*m_scale);
	}
	
	void resize(string str)
	{
		m_text = str;
		m_size = ComputeTextBoxSize(m_font, m_text)*m_scale*GetScale();
		m_relativePos = m_pos-(m_size*m_origin*m_scale);
	}
	
	void draw()
	{
		DrawText(m_relativePos, m_text, m_font, m_color, m_scale*GetScale());
	}
	
	void drawColored(uint color)
	{
		DrawText(m_relativePos, m_text, m_font, color, m_scale*GetScale());
	}
	
	void draw(vector2 _pos, float _scale, uint _color)
	{
		DrawText(_pos-(m_size*m_origin*m_scale), m_text, m_font, _color, _scale*GetScale());
	}
	
	bool buttonDraw(uint _color,float&in oof = 1)
	{
		drawColored(_color);
		if(GetInputHandle().GetTouchState(0)==KS_HIT)
			return isPointInRect(GetInputHandle().GetTouchPos(0), m_pos, m_size*oof, m_origin);
		else
			return false;
	}
	
	bool buttonDraw(vector2 _pos, float _scale,uint _color,float&in oof = 1)
	{
		DrawText(_pos-(m_size*m_origin*m_scale), m_text, m_font, _color, _scale*GetScale());
		if(GetInputHandle().GetTouchState(0)==KS_HIT)
			return isPointInRect(GetInputHandle().GetTouchPos(0), _pos, m_size*_scale*oof, m_origin);
		else
			return false;
	}
	
	void setScale(float f)
	{
		m_scale = f;
		m_relativePos = m_pos-(m_size*m_origin*m_scale);
	}
	
	
	
}



class TextManager
{
	Text@[] m_texts;
	uint len = 0;
	uint insert(Text@ _text)
	{
		m_texts.insertLast(_text);
		return len++;
	}
	
	Text@ get(uint id)
	{
		return @m_texts[id];
	}
	
	void draw(uint id)
	{
		m_texts[id].draw();
	}
	
	void drawColored(uint id, uint color)
	{
		m_texts[id].drawColored(color);
	}
	
	void init()
	{
		insert(Text(GetScreenSize()/2 - (vector2(0,100*GetScale())),"TOUCH TO PLAY"));
		insert(Text(GetScreenSize()/2 + (vector2(0,100*GetScale())),"SETTINGS"));
		insert(Text(GetScreenSize()/2 + (vector2(0,200*GetScale())),"SUPPORT"));
	}
	
	void initMenu()
	{
		insert(Text(GetScreenSize()/2 - (vector2(0,100*GetScale())),"TOUCH TO RETURN"));
		insert(Text(GetScreenSize()/2 + (vector2(0,100*GetScale())),"SETTINGS"));
		insert(Text(GetScreenSize()/2 + (vector2(0,300*GetScale())),"SUPPORT"));
	}
	
	uint getTouchId(vector2 pos, float m_scale)
	{
		for(uint i=1;i<len;i++)
		{
			Text@ t = get(i);
			if(isPointInRect(pos, t.m_pos, t.m_size*m_scale, t.m_origin))
				return i;
		}
		return 0;
	}
	
	uint getTouchId(vector2 pos)
	{
		return getTouchId(pos, 1.2);
	}
}

TextManager g_textManager;
TextManager g_textManagerMenu;
string fnt = "Verdana64.fnt";