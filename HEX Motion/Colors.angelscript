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

vector3 greyV3 = COL(grey);
vector3 greyDarkV3 = COL(greyDark);
vector3 blackV3 = vector3(0,0,0);
vector3 whiteV3 = vector3(1,1,1);
uint grey = 0xFFAAAAAAA;
uint greyB = 0xFF999999;
uint greyDark = 0xFF2F2F2F;
uint greyMid = 0xFF777777;
uint paleRed = 0xFFFF0000;
uint cyan = COL(0,255,255);
uint white = COL(255,255,255);
uint black = COL(0,0,0);
uint magenta = COL(255,0,255);
uint yellow = COL(255,255,0);
uint green = 0xFF76EE00;
uint orange = 0xFFFF7F00;
uint blue = 0xFF0000FF;
uint indigo = 0xFF4B0082;
uint violet = 0xFF9400D3;

uint GetColorFromIdx(uint idx)
{
	switch(idx)
	{
		case 1: return cyan;
		case 2: return magenta;
		case 3: return yellow;
		case 4: return indigo;
		case 5: return paleRed;
		case 6: return blue;
		case 7: return green;
	}
	
	return white;
}

vector3 GetColorV3(uint idx)
{
	return COL(GetColorFromIdx(idx));
}

uint[] color = {cyan, magenta, yellow, green};

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
