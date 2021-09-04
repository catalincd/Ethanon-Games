class Waypoint
{
	vector2[] points;
	uint last = 0;
	uint current = 0;
	float m_factor = 0;
	//point ++ and then resize
	void insert(vector2 v)
	{
		points.insertLast(v);
		//AddEntity("dot.ent", vector3(v,0), 0);
		last++;
	}
	
	void setFactor(float f)
	{
		m_factor = f;
	}
	
	vector2 getLast()
	{
		return points[0];
	}
	
	void remove(ETHEntity@ thisEntity)
	{
		if(last>0)
		if(thisEntity.GetPositionY()<points[0].y)
		{
			points.removeAt(0);
			last--;
		}
	}
	
	float getFirstAngle()
	{
		if(last>2)
		return radianToDegree(getAngle(normalize(points[1]-points[0])));
		return 0;
	}
	
	void follow(ETHEntity@ thisEntity)
	{
		vector2 cv = points[0];
		//putPixel(cv-GetCameraPos(), yellow, 50);
		//DrawLine(cv-GetCameraPos(), thisEntity.GetPositionXY()-GetCameraPos(), yellow, yellow, 10);
		float desired = radianToDegree(getAngle(normalize(cv-thisEntity.GetPositionXY())));
		if(abs(absoluteAngle(thisEntity.GetAngle()-180)-absoluteAngle(desired))>5)
			thisEntity.AddToAngle(unitsPerSecond(225)*sign(absoluteAngle(desired)-absoluteAngle(thisEntity.GetAngle()-180)));
		vector2 direction(0.0f,-1.0f);
		direction = rotate(direction, degreeToRadian(thisEntity.GetAngle()));
		thisEntity.AddToPositionXY(direction * unitsPerSecond(150) * m_factor);
		if(close(cv, thisEntity.GetPositionXY()))
		{
			points.removeAt(0);
			last--;
		}
		
	}
	
	
		
}


Waypoint g_waypoint;