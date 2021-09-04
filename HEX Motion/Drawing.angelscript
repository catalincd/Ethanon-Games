void DrawCenteredText(string text, string font, uint color)
{
	vector2 offset = (ComputeTextBoxSize(font, text)*GetScale())/2;
	DrawText(g_scale.SCREEN_SIZE_2-offset, text, font, color, GetScale());
}

void DrawCenteredText(vector2 pos, string text, string font, uint color)
{
	vector2 offset = (ComputeTextBoxSize(font, text)*GetScale())/2;
	DrawText(pos-offset, text, font, color, GetScale());
}

string boolToStr(bool q)
{
	return q? "TRUE":"FALSE";
}

void drawScaledSprite(string name, vector2 pos, vector2 origin)
{
	vector2 size = GetSpriteSize(name)*GetScale();
	DrawShapedSprite(name, pos-size*origin, size, white);
}

bool putButton(string name, vector2 pos, vector2 origin, uint color)
{
	vector2 size = GetSpriteSize(name)*GetScale();
	DrawShapedSprite(name, pos-size*origin, size, color);
	
	if(GetInputHandle().GetTouchState(0)==KS_HIT)
	{
		return isPointInRect(GetInputHandle().GetTouchPos(0), pos, size, origin);
	}
	
	return false;
}

void DrawText()
{
	string str1 = GetSharedData("SET");
	string str2 = GetResourceDirectory();
	DrawText(vector2(50,0), str1, "Verdana30.fnt", white);
	DrawText(vector2(50,50), str2, "Verdana30.fnt", white);
	//DrawText(vector2(50,100), str3, "Verdana30.fnt", white);
	//DrawText(vector2(0,150), "4"+boolToStr(FileInPackageExists(fileName2)), "Verdana30.fnt", white);
	//DrawText(vector2(0,250), "#"+GetResourceDirectory(), "Verdana30.fnt", white);
	//DrawText(vector2(0,300), "#"+GetExternalStorageDirectory(), "Verdana30.fnt", white);



}