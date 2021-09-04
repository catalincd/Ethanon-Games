class Setting
{
	string name;
	bool enabled = false;
	void enable(){}
	void disable(){}
}

class SlideSetting : Setting
{
	string setName;
	//string name;
	uint current;
	uint length;
	string[] names;
	string path;
	bool selected = false;
	bool deselectOther = false;
	vector2 pos;
	Text @m_text;
	Text @m_option;
	vector2 leftArrow;
	vector2 rightArrow;
	
	void next()
	{
		current++;
		current%=length;
		updateX();
	}
	
	void prev()
	{
		if(current>0)
			current--;
		else 
			current = length-1;
		updateX();
	}
	
	void deselect()
	{
		selected = false;
	}
	
	bool deselectOthers()
	{
		return deselectOther;
	}
	
	void save()
	{
	
	}
	
	SlideSetting(uint id, string _setName, uint len, string[] _names, uint _current, string _path)
	{
		length = len;
		path = _path;
		setName = _setName;
		names = _names;
		current = _current;
		pos = vector2(200,id*75+200)*GetScale();
		@m_text = Text(pos, setName, "Verdana30.fnt", white, 1, vector2(0, 0.5));
		@m_option = Text(pos+vector2(500*GetScale(),0),names[current], "Verdana30.fnt");
		leftArrow = pos+vector2(350*GetScale(),0);
		rightArrow = pos+vector2(650*GetScale(),0);
		//setSpriteOrigin("sprites/arrow_left.png", vector2(0.5,0.5));
		//setSpriteOrigin("sprites/arrow_right.png", vector2(0.5,0.5));
	}
	
	void updateX()
	{
		@m_option = Text(pos+vector2(500*GetScale(),0),names[current], "Verdana30.fnt");
	}
	
	void update(float bias)
	{
		//name = setName + names[current];
		if(selected)
		{
			deselectOther = false;
			uint color = ARGB(bias,whiteF);
			m_text.drawColored(color);
			m_option.drawColored(color);
			bool left = putButton("sprites/arrow_left.png", leftArrow, V2_HALF, color);
			bool right = putButton("sprites/arrow_right.png", rightArrow, V2_HALF, color);
			if(left)
				prev();
			if(right)
				next();
		}
		else
		{
			bool q = m_text.buttonDraw(pos, 0.75, ARGB(bias, greyF),1.2);
			if(q)
			{
				deselectOther=true;
				selected = true;
			}
		}
	}
}




class CheckSetting : Setting
{
	string setName;
	bool selected = false;
	bool deselectOther = false;
	vector2 pos;
	vector2 tickbox;
	Text @m_text;
	Text @m_option;


	
	void enable()
	{
		enabled = true;
		m_option.resize("ENABLED");
	}
	
	
	void disable()
	{
		enabled = false;
		m_option.resize("DISABLED");
	}
	
	void deselect()
	{
		selected = false;
	}
	
	bool deselectOthers()
	{
		return deselectOther;
	}
	
	CheckSetting(uint id, string _setName, bool enabled)
	{
		setName = _setName;
		pos = vector2(200,id*75+275)*GetScale();
		@m_text = Text(pos, setName, "Verdana30.fnt", white, 1, vector2(0, 0.5));
		@m_option = Text(pos+vector2(500*GetScale(),0),enabled? "ENABLED":"DISABLED", "Verdana30.fnt");
		//setSpriteOrigin("sprites/arrow_left.png", vector2(0.5,0.5));
		//setSpriteOrigin("sprites/arrow_right.png", vector2(0.5,0.5));
	}
	
	
	void update(float bias)
	{
		//name = setName + names[current];
		if(selected)
		{
			deselectOther = false;
			uint color = ARGB(bias,whiteF);
			m_text.drawColored(color);
			bool q = m_option.buttonDraw(color);
			if(q)
			{
				if(enabled)disable();
				else enable();
				
			}
			
		}
		else
		{
			bool q = m_text.buttonDraw(pos, 0.75, ARGB(bias, greyF),1.2);
			if(q)
			{
				deselectOther=true;
				selected = true;
			}
		}
	}
}



