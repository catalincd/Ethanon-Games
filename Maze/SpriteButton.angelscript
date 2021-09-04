bool SpriteButton(string sprite, vector2 pos, vector2 size, vector2 origin, Color color = white, float scale = 1.0f, float angle = 0.0f)
{
	vector2 newSize = size * scale;
	vector2 relativePos = pos - (newSize * origin);
	
	SetSpriteOrigin(sprite, origin);
	
	DrawShapedSprite(sprite, pos, newSize, color.getUInt(), angle);
	
	bool touched = (GetInputHandle().GetTouchState(0) == KS_HIT);
	
	if(touched)
	{
		vector2 touchPos = GetInputHandle().GetTouchPos(0);
		return isPointInRect(touchPos, pos, newSize, origin);
	}
	
	return false;
}



class Slider
{
	bool sliding = false;
	vector2 spritePos;
	vector2 spriteSize;
	vector2 sliderSize;
	float sliderY;
	float sliderX;
	float sliderOffY;
	float sliderMax;
	float sliderMin;
	uint sliderColor;
	float bias,left,right;
	
	Slider(vector2 pos, float l, float r, float current)
	{
		left = l;
		right = r;
	
		spritePos = pos + vector2(150,-5) * GetScale();
		spriteSize = vector2(300, 30) * GetScale();
		sliderSize = vector2(67.5, 105) * GetScale();
		setSpriteOrigin("sprites/white.png", vector2(1.0f, 0.5f));
		setSpriteOrigin("sprites/slider.png", vector2(0.5f, 0.53f));
		sliderColor = 0xFFFFFFFF;
		
		sliderMax = spritePos.x;
		sliderMin = sliderMax - spriteSize.x;
		
		
		sliderX = (current - left) / (right - left) * spriteSize.x + sliderMin;
		sliderY = spritePos.y;
		sliderOffY = spritePos.y + 30 * GetScale();
	}
	
	void create(vector2 pos)
	{
		
	}
	
	void updateSlider()
	{
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		
		if(touchState == KS_HIT)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			sliding = isPointInRect(touchPos, vector2(sliderX, sliderY), sliderSize, V2_HALF);
		}
		
		if(touchState == KS_DOWN && sliding)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			sliderX = touchPos.x;
			sliderX = max(sliderMin, min(sliderX, sliderMax));
		}
		
		if(touchState == KS_RELEASE)
		{
			sliding = false;
		}
		
		bias = (sliderX - sliderMin) / spriteSize.x;
		sliderColor = sliding? white.getUInt() : green.getUInt();
	}
	
	float getValue()
	{
		return interpolate(left, right, bias);
	}
	

	void update(float alpha, float scale)
	{
		updateSlider();
		DrawShapedSprite("sprites/white.png", spritePos, spriteSize, black.getUInt());
		DrawShapedSprite("sprites/slider.png", vector2(sliderX, sliderY), sliderSize, sliderColor);
		
		//left
		DrawText(""+left+"  ", f64, vector2(sliderMin, sliderY), black.getUInt(),  vector2(1.0f, 0.5f), scale);
		//right
		DrawText("  "+right+"", f64, vector2(sliderMax, sliderY), black.getUInt(),  vector2(0.0f, 0.5f), scale);
		//mid
		DrawText(""+setPrecision(getValue(), 1), f64, vector2(sliderX, sliderOffY), sliderColor,  vector2(0.5f, 0.0f), scale);
	}

}

class UIntSlider
{
	bool sliding = false;
	vector2 spritePos;
	vector2 spriteSize;
	vector2 sliderSize;
	float sliderY;
	float sliderX;
	float sliderOffY;
	float sliderMax;
	float sliderMin;
	uint sliderColor;
	float bias,left,right;
	
	UIntSlider(vector2 pos, float l, float r, float current)
	{
		left = l;
		right = r;
	
		spritePos = pos + vector2(0,-5) * GetScale();
		spriteSize = vector2(800, 30) * GetScale();
		sliderSize = vector2(67.5, 105) * GetScale();
		setSpriteOrigin("sprites/white.png", vector2(0.5f, 0.5f));
		setSpriteOrigin("sprites/slider.png", vector2(0.5f, 0.53f));
		sliderColor = 0xFFFFFFFF;
		
		sliderMax = spritePos.x + (spriteSize.x / 2);
		sliderMin = sliderMax - spriteSize.x;
		
		
		sliderX = (current - left) / (right - left) * spriteSize.x + sliderMin;
		sliderY = spritePos.y;
		sliderOffY = spritePos.y + 30 * GetScale();
	}
	
	void create(vector2 pos)
	{
		
	}
	
	void updateSlider()
	{
		KEY_STATE touchState = GetInputHandle().GetTouchState(0);
		
		if(touchState == KS_HIT)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			sliding = isPointInRect(touchPos, vector2(sliderX, sliderY), sliderSize, V2_HALF);
		}
		
		if(touchState == KS_DOWN && sliding)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			sliderX = touchPos.x;
			sliderX = max(sliderMin, min(sliderX, sliderMax));
		}
		
		if(touchState == KS_RELEASE)
		{
			sliding = false;
		}
		
		bias = (sliderX - sliderMin) / spriteSize.x;
		sliderColor = sliding? white.getUInt() : red.getUInt();
	}
	
	uint getValue()
	{
		return uint(interpolate(left, right, bias));
	}
	

	void update(float alpha, float scale)
	{
		updateSlider();
		DrawShapedSprite("sprites/white.png", spritePos, spriteSize, black.getUInt());
		DrawShapedSprite("sprites/slider.png", vector2(sliderX, sliderY), sliderSize, sliderColor);
		
		//left
		DrawText(""+left+"  ", f64, vector2(sliderMin, sliderY), black.getUInt(),  vector2(1.0f, 0.5f), scale);
		//right
		DrawText("  "+right+"", f64, vector2(sliderMax, sliderY), black.getUInt(),  vector2(0.0f, 0.5f), scale);
		//mid
		DrawText(""+setPrecision(getValue(), 0), f64, vector2(sliderX, sliderOffY), sliderColor,  vector2(0.5f, 0.0f), scale);
	}

}

float setPrecision(float a, uint digits)
{
	float ten = pow(10, digits);
	return float(uint(a * ten)) / ten;
}