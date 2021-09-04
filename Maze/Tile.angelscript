class Tile : Element
{
	ImageFrame@ img;
	string spriteName;

	Tile(){}

	Tile(string _spriteName, vector2 _pos, vector2 _size, vector2 _origin = V2_HALF, Color _color = white, float _scale = 1.0f, float _angle = 0.0f)
	{
		spriteName = _spriteName;
		pos = _pos;
		origin = _origin;
		color = _color;
		scale = _scale;
		size = _size;
		angle = _angle;
		@img = ImageFrame(spriteName, pos, origin, size, scale, false);
	}
	
	void create()
	{
		LoadSprite(spriteName);
		Element::create();
	}
	
	void update()
	{
		Element::update();
		img.setColor(color);
		draw();
	}
	
	void draw(vector2 offset = V2_ZERO)
	{
		img.draw(offset);
	}
}