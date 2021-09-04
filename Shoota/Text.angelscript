string text128 = "Code128.fnt";
string text64 = "Code64.fnt";
string sans64 = "sans64.fnt";
string sans128 = "sans128.fnt";



void DrawFadingCenteredTextY(float y, string text, string font, uint color, uint lifetime, float scale)
{
	vector2 size = ComputeTextBoxSize(font, text) * scale / 2;
	vector2 pos = vector2(GetScreenSize().x/2, y)- size;
	DrawFadingText(pos, text, font, color, lifetime, scale);
}


void DrawText(string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawText(relPos, text, font, color, newScale);
}

vector2 DrawSizeText(string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawText(relPos, text, font, color, newScale);
	return size;
}

void DrawFadingText(uint lifetime, string text, string font, vector2 pos, uint color = white, vector2 origin = V2_HALF, float scale = 1.0f)
{
	float newScale = scale * GetScale();
	vector2 size = ComputeTextBoxSize(font, text) * newScale;
	vector2 relPos = pos - (size * origin);
	DrawFadingText(relPos, text, font, color, lifetime, newScale);
}