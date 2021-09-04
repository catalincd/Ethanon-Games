class Text : Element
{
	string text;
	string font;
	
	
	Text(string _text, string _font, vector2 _pos, Color _color = white, vector2 _origin = V2_HALF, float _scale = 1.0f, float _angle = 0.0f)
	{
		text = _text;
		font = _font;
		pos = _pos;
		color = _color;
		origin = _origin;
		scale = _scale;
		angle = _angle;
		
		size = ComputeTextBoxSize(font, text);
		updatePolygon();
	}
	
	void create()
	{
		Element::create();
		@effect = DefaultEffect(this);
		@fadeIn = DefaultFadeIn(this);
	}
	
	void update()
	{
		Element::update();
		draw();
	}
	
	void setText(string _text)
	{
		text = _text;
		size = ComputeTextBoxSize(font, text);
		updatePolygon();
	}
	
	void draw(vector2 offset = V2_ZERO)
	{
		DrawText(text, font, pos, size, color.getUInt(), origin, scale, angle);
	}
}




void DrawText(string text, string font, vector2 pos, vector2 size, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f, float angle = 0.0f)
{
	vector2 nSize = size * scale;
	vector2 relPos = pos - (nSize * origin);
	DrawText(relPos, text, font, color, scale);
}

void DrawText(string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawText(relPos, text, font, color, newScale);
}
