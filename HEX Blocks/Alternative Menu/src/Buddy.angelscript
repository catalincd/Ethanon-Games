class Buddy
{
	string spr = "sprites/buddy.png";
	string eyes = "sprites/eyes.png";
	vector2 pos;
	vector2 eyesPos;
	vector2 size = vector2(300,300);
	vector2 relSize;
	vector2 eyesOffset;
	vector2 initOffset;
	vector2 targetOffset;
	vector2 posOffset=vector2(0,0);
	vector2 relPosOffset=vector2(0,0);
	float radius;
	uint lastTime;
	bool looking = false;
	bool changingPos = false;
	vector2 initPos;
	vector2 targetPos;
	InterpolationTimer@ posTimer;
	uint stride = 1000;
	float radiusLimit;
	float angle = 0;
	float radiusAddLimit = 0.1;
	float radiusToAdd;
	InterpolationTimer@ timer;
	
	
	
	void create()
	{
		@timer = InterpolationTimer(300);
		@posTimer = InterpolationTimer(300);
		pos = vector2(360, 350)*GetScale();
		eyesPos = pos;
		radius = 30*GetScale();
		radiusLimit = 50*GetScale();
		radiusToAdd = 0.25*GetScale();
		relSize = size*GetScale();
		SetSpriteOrigin(spr, V2_HALF);
		SetSpriteOrigin(eyes, V2_HALF);
		//timer.setFilter(@smoothBeginning);
	}
	
	void draw()
	{
		vector2 off = posOffset+relPosOffset+pos;
		DrawShapedSprite(spr, off, relSize, white);
		DrawShapedSprite(eyes, off+eyesOffset, relSize, white);
		updateEyes();
		updateMovement();
		updatePos();
	}
	
	void setPositionOffset(vector2 v)
	{
		relPosOffset = v;
	}
	
	void setNewPosition(vector2 new)
	{
		initPos = relPosOffset+pos;
		relPosOffset = V2_ZERO;
		targetPos = new;
		changingPos = true;
		posTimer.reset(300);
	}
	
	void updatePos()
	{
		if(changingPos)
		{
			if(posTimer.isOver())
			{
				pos = targetPos;
				changingPos = false;
			}
			pos = interpolate(initPos, targetPos, posTimer.getBias());
		}
	}
	
	void updateMovement()
	{
		angle+=randF(-radiusAddLimit,radiusAddLimit);
		posOffset+=rotate(radiusToAdd, angle);
		if(getLength(posOffset)>radiusLimit)
			angle = float((uint(angle)+180)%360);
	}
	
	vector2 get()
	{
		return relPosOffset;
	}
	
	void set(vector2 _pos, vector2 off)
	{
		relPosOffset = off;
		pos = _pos;
	}
	
	void updateEyes()
	{
		timer.update();
		eyesOffset = interpolate(initOffset, targetOffset, timer.getBias());
		if(!looking)
		{
			if(GetTime()-lastTime>stride)
			{
					looking = true;
					uint angle = rand(360);
					initOffset = targetOffset;
					targetOffset = rotate(randF(0, radius), degreeToRadian(angle));
					lastTime = GetTime();
					stride = rand(3,6)*500;
					timer.reset(300);
			}
		}
		else
		{
				if(timer.isOver())looking = false;
			
		}
		
	}
}

Buddy buddy;