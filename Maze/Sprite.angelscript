class Sprite : Element
{
	string spriteName;

	Sprite(){}

	Sprite(string _spriteName, vector2 _pos, vector2 _size, vector2 _origin = V2_HALF, Color _color = white, float _scale = 1.0f, float _angle = 0.0f)
	{
		spriteName = _spriteName;
		pos = _pos;
		origin = _origin;
		color = _color;
		scale = _scale;
		size = _size;
		angle = _angle;
	}
	
	void create()
	{
		LoadSprite(spriteName);
		SetSpriteOrigin(spriteName, origin);
		Element::create();
		@effect = BasicTap(this);
	}
	
	void update()
	{
		Element::update();
		draw();
	}
	
	void draw(vector2 offset = V2_ZERO)
	{
		DrawShapedSprite(spriteName, pos, size * scale, color.getUInt(), angle);
	}
	
}