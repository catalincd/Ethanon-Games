float ENTITY_OFFSET_X = 16;

class Effector : GameObject
{
	uint lastMilestone = 0;
	bool effect = false;
	bool shutDown = false;
	uint effectId = 0;
	uint effectTime = 500;
	uint lastScoreMilestone = 0;
	float eyesRadius = 2.5;
	vector2 spriteSize = vector2(64,64);
	InterpolationTimer@ effectTimer = InterpolationTimer(effectTime);

	string getTag()
	{
		return "Effector";
	}
	
	void create()
	{
		ENTITY_OFFSET_X = 32 * GetScale();
		lastMilestone = 0;
		lastScoreMilestone = 0;
		effect = false;
		effectTimer.reset(effectTime);
		eyesRadius = 2.5 * GetScale();
		spriteSize = vector2(64,64) * GetScale();
	}
	
	void update()
	{
		checkMilestones();
		if(effect)
		{
			
			//SetBackgroundColor(COL(interpolate(vector3(0.5,0,0), V3_ZERO, effectTimer.getBias())));
			
			if(shutDown)
			{
				shutDown = false;
				effect = false;
			}
			
			effectTimer.update();
			if(effectTimer.isOver())
			{
				shutDown = true;
			}
			
		}
		//if(GetInputHandle().GetKeyState(K_LMOUSE)==KS_HIT)
		//	initEffect();
	}
	
	void checkMilestones()
	{
		uint milestone = GetScore() / EFFECT_RATE;
		if(milestone > lastMilestone)
		{
			lastMilestone = milestone;
			if(!isEnergyOn())
			initEffect();
		}
		
		uint thisScore  = GetScore() + GetScore(SCORE_OFFSET_UNITS);
		uint score_milestone = thisScore / SHAKE_RATE;
		if(score_milestone > lastScoreMilestone && thisScore < SCORE_TO_RAINBOW)
		{
			lastScoreMilestone = score_milestone;
			if(!isEnergyOn())
				g_cameraManager.shake(score_milestone);
		}
	}
	
	void initEffect()
	{
		shutDown = false;
		effect = true;
		effectId = rand(0,15);
		//effectId = 15;
		effectTimer.reset(effectTime);
	}
	
	
	void resume()
	{
		
	}	
	
	void updateEntity(ETHEntity@ thisEntity)
	{
		if(effect)
		{
			if(effectId == 0)
				updateScale(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 1)
				updateAngleRight(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 2)
				updateAngleLeft(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 3)
				updateBounce(thisEntity, effectTimer.getUnfilteredBias());	
			if(effectId == 4)
				updateBounceHorizontal(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 5)
				updateThreeSixtyRight(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 6)
				updateThreeSixtyLeft(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 7)
				updateHorizontalShake(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 8)
				updateRescaleRotate(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 9)
				updateShake(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 10)
				updateScaleRotateReverse(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 11)
				updateScaleRotate(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 12)
				updateRescaleRotateReverse(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 13)
				updateScaleShake(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 14)
				updateRandomScale(thisEntity, effectTimer.getUnfilteredBias());
			if(effectId == 15)
				updateDizzyRotate(thisEntity, effectTimer.getUnfilteredBias());
			//updateVerticalShake(thisEntity, effectTimer.getUnfilteredBias());
			
		}
	}
	
	void updateRainbow(ETHEntity@ thisEntity)
	{
		uint currentId = thisEntity.GetUInt("cId");
		uint elapsed = thisEntity.GetUInt("eLa");
		
		//next
		if(elapsed > uint(RAINBOW_STRIDE))
		{
			currentId++;if(currentId > 7)currentId = 0;
			elapsed = 0;
			thisEntity.SetUInt("cId", currentId);
		}
		
		vector3 currentColor = GetV3ColorFromIdx(currentId);
		vector3 nextColor = GetV3ColorFromIdx(currentId+1);
		float currentBias = (float(elapsed) / RAINBOW_STRIDE);
		thisEntity.SetColor(interpolate(currentColor, nextColor, currentBias));
		elapsed += GetLastFrameElapsedTime();
		thisEntity.SetUInt("eLa", elapsed);
	}
}

Effector g_effector;


void updateScale(ETHEntity@ thisEntity, float bias)
{
	thisEntity.SetScale(interpolate(0.6, 1, squeeze(bias)));
}

uint currentAngleCycle = 0;
string currentAngleCycleStr = "f0";

void updateAngleRight(ETHEntity@ thisEntity, float bias)
{

	float initAngle = 0;
	float targetAngle = initAngle + 90;
	thisEntity.SetAngle(interpolate(initAngle, targetAngle, easyEaseOutBack(bias)));
}


void updateAngleLeft(ETHEntity@ thisEntity, float bias)
{
	float initAngle = 0;
	float targetAngle = initAngle - 90;
	thisEntity.SetAngle(interpolate(initAngle, targetAngle, easyEaseOutBack(bias)));
}

void updateBounce(ETHEntity@ thisEntity, float bias)
{
	thisEntity.SetScale(bounceVertical(bias));
}

void updateBounceHorizontal(ETHEntity@ thisEntity, float bias)
{
	thisEntity.SetScale(bounceHorizontal(bias));
}

void updateThreeSixtyRight(ETHEntity@ thisEntity, float bias)
{
	float targetAngle = + 360;
	thisEntity.SetAngle(interpolate(0, targetAngle, easyEaseOutBack(bias)));
}

void updateThreeSixtyLeft(ETHEntity@ thisEntity, float bias)
{
	float targetAngle = - 360;
	thisEntity.SetAngle(interpolate(0, targetAngle, easyEaseOutBack(bias)));
}

void updateHorizontalShake(ETHEntity@ thisEntity, float bias)
{
	float thisBias = mod(bias, 0.125)/0.25;
	float newOffset = boolToSign(flickerCycles(bias)) * thisBias * smoothEnd(1-bias) * ENTITY_OFFSET_X;
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + vector2(newOffset, 0));
}

void updateDizzyRotate(ETHEntity@ thisEntity, float bias)
{
	float thisBias = mod(bias, 0.1f)/0.2f;
	//float newOffset = boolToSign(flickerCycles(bias)) * thisBias * smoothEnd(1-bias) * ENTITY_OFFSET_X;
	float newAngle = thisBias * boolToSign(flickerCycles(bias, 0.1f)) * 25;
	thisEntity.SetAngle(newAngle);
}



void updateVerticalShake(ETHEntity@ thisEntity, float bias)
{
	float thisBias = mod(bias, 0.125)/0.125;
	float newOffset = boolToSign(flickerCycles(bias)) * thisBias * smoothEnd(1-bias) * ENTITY_OFFSET_X;
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + vector2(0, newOffset));
}

void updateShake(ETHEntity@ thisEntity, float bias)
{
	float newOffset = smoothEnd(1-bias) * ENTITY_OFFSET_X / 4;
	vector2 thisOffset = vector2(randF(-1.0f, 1.0f), randF(-1.0f, 1.0f)) * newOffset;
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + thisOffset);
}

void updateScaleRotate(ETHEntity@ thisEntity, float bias)
{
	float radius = chopLimits(bias) * ENTITY_OFFSET_X ;
	float angle = bias * 360;
	
	vector2 offset = rotateAround(degreeToRadian(angle), radius);
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + offset);
	thisEntity.SetAngle(angle);
}

void updateScaleRotateReverse(ETHEntity@ thisEntity, float bias)
{
	float radius = chopLimits(bias) * ENTITY_OFFSET_X ;
	float angle = (1.0f - bias) * 360;
	
	vector2 offset = rotateAround(degreeToRadian(angle), radius);
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + offset);
	thisEntity.SetAngle(angle);
}

void updateRescaleRotate(ETHEntity@ thisEntity, float bias)
{
	float chopped = chopLimits(bias);
	float chopped2 = 1.0f - (chopped / 3);
	float radius = chopped * ENTITY_OFFSET_X ;
	float angle = bias * 360;
	
	vector2 offset = rotateAround(degreeToRadian(angle), radius);
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + offset);
	thisEntity.SetAngle(angle);
	thisEntity.SetScale(chopped2);
}

void updateRescaleRotateReverse(ETHEntity@ thisEntity, float bias)
{
	float chopped = chopLimits(bias);
	float chopped2 = 1.0f - (chopped / 3);
	float radius = chopped * ENTITY_OFFSET_X ;
	float angle = (1.0f - bias) * 360;
	
	vector2 offset = rotateAround(degreeToRadian(angle), radius);
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + offset);
	thisEntity.SetAngle(angle);
	thisEntity.SetScale(chopped2);
}

void updateRandomScale(ETHEntity@ thisEntity, float bias)
{
	vector2 currentScale = thisEntity.GetScale() / GetScale();
	vector2 newScale;

	if(bias < 0.7f)
	{
		newScale = currentScale + vector2(randF(-1.0f, 1.0f) * 0.1f);
		thisEntity.SetVector2("ls", newScale);
	}
	else
	{
		float newBias = (bias - 0.7f) / 0.3f;
		newScale = interpolate(thisEntity.GetVector2("ls"), 1.0f, newBias);
	}
	
	thisEntity.SetScale(newScale);
}


void updateScaleShake(ETHEntity@ thisEntity, float bias)
{
	float newOffset = smoothEnd(1-bias) * ENTITY_OFFSET_X / 4;
	vector2 thisOffset = vector2(randF(-1.0f, 1.0f), randF(-1.0f, 1.0f)) * newOffset;
	thisEntity.SetPositionXY(thisEntity.GetVector2("pos") + thisOffset);
	
	updateRandomScale(thisEntity, bias);
}


float chopLimits(float v, float limit1 = 0.2f, float limit2 = 0.4)
{
	if(v < limit1)
		return v / limit1;
	if(v > 1.0f - limit2)
		return (1.0f - v) / limit2;
		
	return 1.0f;
}
