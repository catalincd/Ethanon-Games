class Color
{
	Color()
	{
	}

	Color(const vector3 &in color)
	{
		a = 1.0f;
		r = color.x;
		g = color.y;
		b = color.z;
		u = computeUInt();
	}
	Color(const float _a, const vector3 &in color)
	{
		a = _a;
		r = color.x;
		g = color.y;
		b = color.z;
		u = computeUInt();
	}
	Color(uint color)
	{
		uint _a, _r, _g, _b;
		_a = (0xFF000000 & color) >> 24;
		_r = (0x00FF0000 & color) >> 16;
		_g = (0x0000FF00 & color) >> 8;
		_b = (0x000000FF & color);
		a = float(_a) / 255.0f;
		r = float(_r) / 255.0f;
		g = float(_g) / 255.0f;
		b = float(_b) / 255.0f;
		
		u = color;
	}
	void setColor(const vector3 &in color)
	{
		r = color.x;
		g = color.y;
		b = color.z;
		u = computeUInt();
	}
	
	vector3 getVector3() const
	{
		return vector3(r, g, b);
	}
	
	float getAlpha() const
	{
		return a;
	}
	
	void setAlpha(const float _a)
	{
		a = _a;
		u = computeUInt();
	}
	
	uint computeUInt() const
	{
		return ARGB(uint(a * 255.0f), uint(r * 255.0f), uint(g * 255.0f), uint(b * 255.0f));
	}
	
	uint getUInt() const
	{
		return u;
	}
	
	Color opMul(Color color)
	{
		return Color(color.a * a, vector3(color.r * r, color.g * g, color.b *b));
	}
	
	Color opAdd(Color color)
	{
		return interpolate(color, this, 0.5f);
	}
	
	float a;
	float r;
	float g;
	float b;
	uint u;
}

Color interpolate(Color a, Color b, const float bias)
{
	return Color(interpolate(a.a, b.a, bias), interpolate(a.getVector3(), b.getVector3(), bias));
}


