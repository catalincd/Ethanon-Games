
class SwitchSettingElement
{
	
	SwitchSettingElement(){}

	bool switching = false;

	void create()
	{
		
	}
	
	void update(vector2 textPos, vector2 spritePos)
	{
		switching = false;
	}
	
	bool Switching()
	{
		return switching;
	}
}

