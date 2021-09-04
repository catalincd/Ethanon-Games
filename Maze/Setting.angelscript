class Setting
{
	string name;
	string entity;
	uint type;
	bool hidden = false;
	
	
	Setting(){}
	Setting(string _name, string _entity)
	{
		name = _name;
		entity = _entity;
		hidden = false;
	}

	void load(){}
	void save(){}
	
	void create(vector2 a, vector2 b){}
	void update(float s, Color x){}
}



class SwitchSetting : Setting
{
	bool defaultValue;
	bool ON;
	string displayName;
	vector2 textPos, spritePos;

	SwitchSetting(){}
	
	SwitchSetting(Setting@ set)
	{
		super();
	}

	SwitchSetting(string _display, string _name, string _entity, bool _default = true)
	{
		type = 0;
		super(_name, _entity);
		defaultValue = _default;
		ON = defaultValue;
		displayName = _display;
	}
	
	void load() override
	{
		ON = data.loadBoolean(entity, name, defaultValue);
	}
	
	void save() override
	{
		data.saveBoolean(entity, name, ON);
	}
	
	void create(vector2 l, vector2 r) override
	{
		textPos = l;
		spritePos = r;
	}
	
	void update(float scale, Color c) override
	{	
		if(!hidden)
		{
			vector2 spriteOrigin = vector2(0.5f, 0.5);
			vector2 textOrigin = vector2(0.0f, 0.5);
			float finalScale = scale;
			vector2 size = scale * GetScale() * vector2(200, 75);
			vector3 spriteColor = ON? green.getVector3() : red.getVector3();
			
			float angle = ON? 0 : 180;
			
			bool switchin = SpriteButton("sprites/switch.png", spritePos, size, spriteOrigin, Color(c.getAlpha(), spriteColor), finalScale, angle);
			ON = switchin? !ON : ON;
			
			DrawText(displayName, f64, textPos, black.getUInt(), textOrigin, finalScale);		
		}
		
	}
}

class FloatSetting : Setting
{
	float defaultValue;
	float VALUE;
	string displayName;
	float left,right;
	vector2 textPos,spritePos;
	Slider@ slider;

	FloatSetting(){}

	FloatSetting(string _display, string _name, string _entity, float _l, float _r, float _default = 0.0f)
	{
		type = 1;
		super(_name, _entity);
		defaultValue = _default;
		VALUE = defaultValue;
		displayName = _display;
		left = _l;
		right = _r;
	}
	
	void load() override
	{
		VALUE = data.loadFloat(entity, name, defaultValue);
	}
	
	void save() override
	{
		data.saveFloat(entity, name, VALUE);
	}
	
	void create(vector2 r, vector2 l) override
	{
		textPos = r;
		spritePos = l;
		@slider = Slider(spritePos, left, right, VALUE);
		//slider.create(spritePos);
	}
	
	void update(float scale, Color c) override
	{	
		if(!hidden)
		{
			vector2 spriteOrigin = vector2(1.0f, 0.5f);
			vector2 textOrigin = vector2(0.0f, 0.5);
			float finalScale = scale;
			
			slider.update(c.getAlpha(), scale);
			VALUE = slider.getValue();
			
			DrawText(displayName, f64, textPos, black.getUInt(), textOrigin, finalScale);	
		}
		
	}
}

class StringSetting : Setting
{
	string defaultValue;
	string VALUE;

	StringSetting(){}

	StringSetting(string _name, string _entity, string _default = "UNDEFINED")
	{	
		type = 2;
		super(_name, _entity);
		defaultValue = _default;
		VALUE = defaultValue;
	}
	
	void load() override
	{
		VALUE = data.loadValue(entity, name, defaultValue);
	}
	
	void save() override
	{
		data.loadValue(entity, name, VALUE);
	}
}


//value
//uint array