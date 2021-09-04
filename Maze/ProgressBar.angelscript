class ProgressBar
{
	vector2 size;
	vector2 fillSize;
	vector2 origin;
	vector2 pos;
	vector2 fillPos;
	vector2 relPos;
	Color strokeCol;
	Color fillCol;
	Color backgroundColor = Color(0xAA444444);
	vector2 textPos1;
	vector2 textPos2;
	
	ProgressBar(){}
	ProgressBar(vector2 _size, float stroke, vector2 _origin, vector2 _pos, Color a = black, Color b = green)
	{
		size = _size;
		fillSize = size - (vector2(2,2) * stroke);
		origin = _origin;
		pos = _pos;
		
		strokeCol = a;
		fillCol = b;
		
		relPos = pos - origin * size;
		fillPos = relPos + ((size - fillSize) / 2.0f);
		
		textPos1 = fillPos;
		textPos2 = fillPos + vector2(fillSize.x, 0.0f);
	}
	
	void setFillColor(Color c)
	{
		fillCol = c;
	}
	
	void create()
	{
		
	}
	
	void update(string a, string b, float bias, float scale, vector2 offset)
	{
		draw(a, b, bias, scale, offset);
	}
	
	void draw(string xa, string xb, float bias, float scale = 1.0f, vector2 offset = V2_ZERO)
	{
		DrawShapedSprite("sprites/flick.png", relPos + offset, size * scale, backgroundColor.getUInt());
		DrawShapedSprite("sprites/flick.png", fillPos + offset, fillSize * vector2(bias, 1.0f) * scale, fillCol.getUInt());
		ImageFrame@ imf = ImageFrame("sprites/stroke.png", relPos, V2_ZERO, size * scale, 0.2f, false);
		imf.draw(offset);
		
		DrawText(xa, f64, textPos1 + offset, strokeCol.getUInt(), V2_ZERO, scale * 0.8f);
		DrawText(xb, f64, textPos2 + offset, strokeCol.getUInt(), vector2(1.0f, 0.0f), scale * 0.8f);
	}
}