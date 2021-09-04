void DrawText(string text, string font, vector2 pos, vector2&in origin = V2_HALF, uint&in color = COLOR_WHITE, float&in scale = 1.0f)
{
	vector2 size = ComputeTextBoxSize(font, text) * GetScale() * scale;
	vector2 offset = size * origin;
	
	DrawText(pos-offset, text, font, color, GetScale()*scale);
}


void DrawCenteredText(string text, string&in font = "Verdana64.fnt", uint&in color = COLOR_WHITE, float&in scale = 1.0f, float yOffset = 0.0f)
{
	vector2 size = ComputeTextBoxSize(font, text)*GetScale()*scale;
	vector2 pos = (GetScreenSize()-size)/2 + vector2(0, yOffset);
	DrawText(pos, text, font, color, GetScale()*scale);
}

void DrawCenteredPosText(string text, string&in font = "Verdana64.fnt", uint&in color = COLOR_WHITE, float&in scale = 1.0f, float yPos = 0.0f)
{
	vector2 size = ComputeTextBoxSize(font, text)*GetScale()*scale;
	vector2 pos = vector2((GetScreenSize().x-size.x)/2, yPos);
	DrawText(pos, text, font, color, GetScale()*scale);
}


void DrawCenteredLines(string text, float&in scale = 1.0f, string&in font = "Verdana64.fnt", uint&in color = COLOR_WHITE)
{
	string[] lines = split(text, "\n");
	float offset = 0;
	for(uint t=0;t<lines.length();t++)
	{
		DrawCenteredText(lines[t], font, color, scale, offset);
		offset += ComputeTextBoxSize(font, lines[t]).y * GetScale() * scale;
	}
}

void DrawCenteredPosLines(string text, float yPos = 0, float&in scale = 1.0f, string&in font = "Verdana64.fnt", uint&in color = COLOR_WHITE)
{
	string[] lines = split(text, "\n");
	float offset = 0;
	for(uint t=0;t<lines.length();t++)
	{
		DrawCenteredPosText(lines[t], font, color, scale, offset+yPos);
		offset += ComputeTextBoxSize(font, lines[t]).y * GetScale() * scale;
	}
}