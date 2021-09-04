void DrawGauge(vector2 pos, float bias, float scale, uint pinColor = red, uint gaugeColor = AQUA_BLUE)
{
	//float finalScale = scale * GetScale();
	vector2 finalSize = V2_256 * scale;
	uint angle = uint(interpolate(330, 30, bias));
	DrawShapedSprite("sprites/gauge_pin.png", pos, finalSize, pinColor, angle);
	DrawShapedSprite("sprites/gauge_back_glow.png", pos, finalSize, gaugeColor);
}