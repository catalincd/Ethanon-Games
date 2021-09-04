class TrapManager : GameObject
{
	
	Trap@[] traps;
	uint added = 0;
	
	float spaces = 1.25f;
	
	ETHEntityArray allEntities;
	
	float lastUp = 0;
	float addOffset = GetScreenSize().y;
	float heightFactor;

	void create()
	{
		traps.resize(0);
		traps.insertLast(Static2());
		traps.insertLast(VerticalSwipe());
		traps.insertLast(RotatinSwipe());
		traps.insertLast(HorizontalSwipe());
		traps.insertLast(HorizontalFullSwipe());
		
		added = 0;
		lastUp = 0;
		
		heightFactor = 144 * GetScale();
	}
	
	
	void update()
	{
		if(!GAME_OVER)
		{
			float currentCamPos = GetCameraPos().y;
		
			if(abs(lastUp - currentCamPos) < addOffset)
			{
				uint Id = rand(0, traps.length() - 1);
				//Id = 4;
				traps[Id].create(lastUp + (spaces * heightFactor), allEntities);
				lastUp -= (traps[Id].heightUnits + spaces * 2) * heightFactor;
				added++;
			}
			
			float limit = GetCameraPos().y + outerScreen3.y;
			
			for(uint i=0;i<allEntities.Size();i++)
			{
				if(allEntities[i].GetPositionY() > limit)
					DeleteEntity(allEntities[i]);
			}
			
			allEntities.RemoveDeadEntities();
		}
		
		DrawText(vector2(18,18) * GetScale(), ""+getCamInt(), "Verdana64.fnt", 0xFF000000, GetScale() * 1.5f);
		//DrawText(V2_ZERO, ""+GetFPSRate(), "Verdana30.fnt", 0xFF000000);
	}
	
	uint getCamInt()
	{
		return uint(abs(GetCameraPos().y) / heightFactor);
	}
	
	void resume()
	{
	
	}
	
	string getTag()
	{
		return "Trap";
	}
}



TrapManager o_trap;



class Trap
{
	Trap(){}

	void create(float height, ETHEntityArray& q){}
	void update(){}
	
	bool isOut(){return false;}
	void remove(){}
	
	int heightUnits;

	
}



