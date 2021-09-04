class Layer
{
	Battery@ m_battery;
	TimeText@ m_timeText;
	float m_bias = 1;

	void create()
	{
		@m_battery = Battery();
		@m_timeText = TimeText();
	}
	
	void update()
	{
		//m_battery.update();
		m_timeText.update();
		g_scoreManager.DrawText(m_bias);
		g_gTimeManager.update(m_bias);
	}
	
	void set(float bias)
	{
		m_bias = bias;
	}
}

Layer g_layer;


class TimeText
{
	vector2 pos;
	Text@ m_text;
	string time;
	
	TimeText()
	{
		pos = vector2(g_scale.xOffset, g_scale.SCREEN_SIZE_Y-g_scale.xOffset);
		vector2 size = vector2(43,-15)*GetScale();
		@m_text = Text(pos+size, "", "Verdana30.fnt");
	}
	
	string minutes(uint q)
		{
			if(q<10)
				return "0"+q;
			else return ""+q;
		}
	
	void update()
	{
		dateTime dt;
		
		
		string str = ""+dt.getHours() + ":" +  minutes(dt.getMinutes());
		
		if(time != str)
		{
			time = str;
			m_text.resize(time);
		}
		
		m_text.draw();
	}
	
}



class Battery
{
	uint level = 0;
	bool charging = false;
	string batterySprite = "sprites/battery.png";
	string chargingSprite = "sprites/charging.png";
	string fill = "sprites/level.png";
	vector2 spritePos;
	vector2 spriteSize;
	vector2 fillPos;
	float fillSize;
	vector2 fillSizeF;
	Text@ m_text;
	
	Battery()
	{
		SetSpriteOrigin(batterySprite, vector2(0.5f, 1.0f));
		SetSpriteOrigin(chargingSprite, vector2(0.5f, 1.0f));
		SetSpriteOrigin(fill, vector2(0.5f, 1.0f));
		spritePos = vector2(1170*GetScale(), g_scale.SCREEN_SIZE_Y-g_scale.xOffset);
		fillPos = spritePos-vector2(0,2.14f*GetScale());
		spriteSize = vector2(17.5, 30)*GetScale();
		fillSize = 21.8f*GetScale();
		@m_text = Text(g_scale.SCREEN_SIZE-g_scale.xOffset, "", "Verdana30.fnt", white, 1, vector2(1.0f, 1.0f));
		
	}
	
	void update()
	{
		uint batteryLevel = parseUInt(GetSharedData("battery"));
		bool charging = GetSharedData("charging") == "TRUE";
		update(batteryLevel, charging);
	}
	
	void update(uint _level, bool charging)
	{
		if(level != _level)
		{
			level = _level;
			m_text.resize(""+level+"%");
			fillSizeF = vector2(spriteSize.x, float(level)/100*fillSize);
		}
		
		
		DrawShapedSprite(batterySprite, spritePos, spriteSize, white);
		DrawShapedSprite(fill, fillPos, fillSizeF, white);
		if(charging)
		{
			DrawShapedSprite(chargingSprite, spritePos, spriteSize, black);
		}
		m_text.draw();
	}
	
	
	
}
