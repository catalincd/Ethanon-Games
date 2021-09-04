void putPixel(vector2 pos, uint color, float radius)
{
	DrawLine(pos, pos+vector2(0,1), color, color, radius);
}

uint COL(uint32 a, uint32 b, uint32 c)
{
	return ARGB(255,a,b,c);
}

uint COL(vector3 color)
{
	return ARGB(255, uint(color.x*255.0f), uint(color.y*255.0f), uint(color.z*255.0f));
}

vector3 COL(uint color)
{
		uint _r, _g, _b;
		
		_r = (0x00FF0000 & color) >> 16;
		_g = (0x0000FF00 & color) >> 8;
		_b = (0x000000FF & color);
		
	return vector3(float(_r) / 255.0f, float(_g) / 255.0f, float(_b) / 255.0f);
}

vector3 greyDarkV3 = COL(greyDark);
vector3 blackV3 = vector3(0,0,0);
vector3 whiteV3 = vector3(1,1,1);
vector3 V3_RED = vector3(1,0,0);

vector3 getReverseCol(vector3 col)
{
	return V3_ONE - col;
}

vector3 normalizeCol(vector3 v)
{
	float maxCol = max(v.x, max(v.y, v.z));
	return v / maxCol;
}

vector3 negative(vector3 col)
{
	return normalizeCol(getReverseCol(col));
}

uint greyB = 0xFF999999;
uint grey2 = 0xFF333333;
uint greyDark = 0xFF2F2F2F;
uint greyMid = 0xFF777777;
uint paleRed = 0xFFFF0000;
uint cyan = COL(0,255,255);
uint white = COL(255,255,255);
uint black = COL(0,0,0);
uint magenta = COL(240,0,255);
uint green = 0xFF76EE00;
uint orange = 0xFFFF7F00;
uint indigo = 0xFF4B0082;
uint violet = 0xFF9400D3;
uint grey = 0xFFAAAAAA;
uint red = 0xFFFF0000;
uint blue = 0xFF0000FF;
uint yellow = 0xFFFFFF00;


uint darkGreen = 0xFF6A9307;
uint lightGreen = 0xFFC4FA33;


uint multiply(uint color, vector3 colorMult)
{
	float r = (0x00FF0000 & color) >> 16;
	float g = (0x0000FF00 & color) >> 8;
	float b = (0x000000FF & color);
	
	r *= colorMult.x;
	g *= colorMult.y;
	b *= colorMult.z;
	
	return ARGB(255, r * 255.0f, g * 255.0f, b * 255.0f);
}



uint[] colorsArray = {red, violet, white, blue, green, yellow};
uint[] enemyColors = {green, darkGreen, lightGreen};



FloatColor blackF(black);
FloatColor greyF(grey);
FloatColor whiteF(white);
FloatColor PRIM(black);
FloatColor SEC(white);

uint ARGB(uint a, FloatColor f)
{
	return ARGB(a, f.rU, f.gU, f.bU);
}

uint ARGB(float a, FloatColor f)
{
	return ARGB(uint(a*255), f.rU, f.gU, f.bU);
}

uint ARGB(uint a, uint col)
{
	return ARGB(a, FloatColor(col));
}




uint interpolateColor(uint x, uint y, float bias)
{
	uint _a, _r, _g, _b, a, r, g, b;
	_a = (0xFF000000 & x) >> 24;
	_r = (0x00FF0000 & x) >> 16;
	_g = (0x0000FF00 & x) >> 8;
	_b = (0x000000FF & x);
	
	a = (0xFF000000 & y) >> 24;
	r = (0x00FF0000 & y) >> 16;
	g = (0x0000FF00 & y) >> 8;
	b = (0x000000FF & y);
	
	a = interpolate(_a, a, bias);
	r = interpolate(_r, r, bias);
	g = interpolate(_g, g, bias);
	b = interpolate(_b, b, bias);
	
	return ARGB(a, r, g, b);
}


class FloatColor
{
	FloatColor()
	{
	}

	FloatColor(const vector3 &in color)
	{
		a = 1.0f;
		r = color.x;
		g = color.y;
		b = color.z;
	}
	FloatColor(const float _a, const vector3 &in color)
	{
		a = _a;
		r = color.x;
		g = color.y;
		b = color.z;
	}
	FloatColor(uint color)
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
		rU = _r;
		gU = _g;
		bU = _b;
	}
	void setColor(const vector3 &in color)
	{
		r = color.x;
		g = color.y;
		b = color.z;
	}
	void setColor(uint color)
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
	}
	vector3 getVector3() const
	{
		return vector3(r, g, b);
	}
	float getAlpha() const
	{
		return a;
	}
	uint getUInt() const
	{
		return ARGB(uint(a * 255.0f), uint(r * 255.0f), uint(g * 255.0f), uint(b * 255.0f));
	}
	uint getUInt2() const
	{
		return ARGB(uint(a * 255.0f), rU, gU, bU);
	}
	FloatColor opMul(FloatColor color)
	{
		return FloatColor(color.a * a, vector3(color.r * r, color.g * g, color.b *b));
	}
	
	void opEqual(uint color)
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
	}
	
	float a;
	float r;
	float g;
	float b;
	uint rU;
	uint gU;
	uint bU;
}

uint getUInt(FloatColor fl)
{
	return fl.getUInt();
}
