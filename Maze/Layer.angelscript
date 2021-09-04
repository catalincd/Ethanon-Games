class Layer
{
	float depth;
	Element@[] elements;
	uint id;
	
	void init()
	{
		elements.resize(0);
	}
	
	uint insertElement(Element@ e)
	{
		e.id = elements.length();
		elements.insertLast(e);
		return e.id;
	}
	
	Element@ e(uint _id)
	{
			if(_id < elements.length())
				return elements[_id];
		return null;
	}
	
	void create()
	{
		for(uint i=0;i<elements.length();i++)
			elements[i].create();
	}

	void update()
	{
		for(uint i=0;i<elements.length();i++)
			elements[i].update();
	}

	

}