class TextButton
{
	vector2 pos, i_pos;
	vector2 origin, i_origin;
	vector2 offset, i_offset;
	vector2 size;
	float scale, i_scale;
	Color color, i_color;
	string text;
	string font;
	Timer@ timer;
	bool fadeIn, fadeOut;
	
	//TO DO : substr text with timer and animate box
	
	TextButton(){}
	
	TextButton(string _text, vector2 _pos, string _font = f64, Color _color = white, vector2 _origin = V2_HALF, float _scale = 1.0f, vector2 _offset = V2_ZERO)
	{
		text = _text;
		font = _font;
		pos = i_pos = _pos;
		origin = i_origin = _origin;
		offset = i_offset = V2_ZERO;
		color = i_color = _color;
		scale = i_scale = _scale;
		fadeIn = true;
		fadeOut = false;
		size = ComputeTextBoxSize(font, text);
		@timer = Timer(A_NORMAL, 100);
	}
	
	void resetFade(){fadeIn = true;fadeOut = false;}
	void FadeIn(){ fadeIn = true; }
	void FadeOut(){ fadeOut = true; }
	
	vector2 getSize()
	{
		return GetScale() * scale * size;
	}
	
	bool isHit()
	{
		bool touch = GetInputHandle().GetTouchState(0) == KS_HIT;
		if(touch)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			return isPointInRect(touchPos, pos, getSize(), origin);
		}
		return false;
	}
	
	void draw()
	{
		vector2 relativePos = pos + offset - (getSize() * origin);
		DrawText(relativePos, text, font, color.getUInt(), scale * GetScale());
	}
	
	void update()
	{
		if(fadeIn || fadeOut)
			timer.update();
		
		if(fadeIn)
		{
			float bias = timer.getBias();
			scale = interpolate(0.0f, i_scale, bias);
			color.setAlpha(interpolate(0.0f, 1.0f, bias));
			if(timer.isOver())
			{
				fadeIn = false;
				timer.reset();
			}
		}
		
		if(fadeOut)
		{
			float bias = 1 - timer.getBias();
			scale = interpolate(0.0f, i_scale, bias);
			color.setAlpha(interpolate(0.0f, 1.0f, bias));
			if(timer.isOver())
			{
				fadeOut = false;
				timer.reset();
			}
		}
		
		draw();
	}

	void setDelay(uint ms)
	{
		timer.setDelay(ms);
	}

}