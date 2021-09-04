string pixel = "sprites/white.png";

void DrawRectangleStroke(vector2 p1, vector2 p2, float size, uint color)
{
	float offset = size/2;
	DrawLine(p1, vector2(p2.x, p1.y), color, color, size);//up
	DrawLine(p1+vector2(offset,0), vector2(p1.x+offset, p2.y), color, color, size);//left
	DrawLine(vector2(p1.x, p2.y), p2, color, color, size);//down
	DrawLine(vector2(p2.x-offset, p1.y), p2-vector2(offset,0), color, color, size);//right
}


void DrawRectangleSpriteStroke(vector2 p1, vector2 p2, float size, uint color)
{
	float SizeX = abs(p2.x-p1.x);
	float SizeY = abs(p2.y-p1.y);
	vector2 offset = vector2(size,size)/2;
	DrawShapedSprite(pixel, p1-offset, vector2(SizeX, size), color); //up
	DrawShapedSprite(pixel, vector2(p1.x, p2.y)-offset, vector2(SizeX, size), color); //down
	DrawShapedSprite(pixel, p1-offset, vector2(size, SizeY), color); //left
	DrawShapedSprite(pixel, vector2(p2.x, p1.y)-offset, vector2(size, SizeY+size), color); //right	
}

void DrawText(string text, string font, uint color, vector2 pos, vector2 origin, float tscale)
{
	vector2 size = ComputeTextBoxSize(font, text)*tscale*origin;
	DrawText(pos-size, text, font, color, tscale);
}