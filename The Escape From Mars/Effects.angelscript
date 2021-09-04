class STimeManager
{
	private float m_factor;

	STimeManager()
	{
		m_factor = 1.0f;
	}
	
	bool isPaused() const
	{
		return (m_factor == 0.0f);
	}

	void pause()
	{
		setFactor(0.0f);
	}

	void resume()
	{
		setFactor(1.0f);
	}

	float getFactor() const
	{
		return m_factor;
	}

	uint getLastFrameElapsedTime()
	{
		return uint(float(GetLastFrameElapsedTime()) * m_factor);
	}

	void setFactor(float _factor)
	{
		m_factor = _factor;
		SetTimeStepScale(m_factor);
	}

	float unitsPerSecond(const float speed)
	{
		return float(double(speed) * double(min(GetLastFrameElapsedTime(), 200)) / 1000.0) * m_factor;
	}

	vector2 unitsPerSecond(const vector2 dir)
	{
		return vector2(unitsPerSecond(dir.x), unitsPerSecond(dir.y));
	}

	float scaledUnitsPerSecond(const float speed)
	{
		return unitsPerSecond(speed) * GetScreenSize().y / 480;
	}

	vector2 scaledUnitsPerSecond(const vector2 speed)
	{		
		return vector2(scaledUnitsPerSecond(speed.x), scaledUnitsPerSecond(speed.y));
	}
}

STimeManager g_timeManager;


void blinkColor(ETHEntity@ thisEntity, const vector3 &in colorA, const vector3 &in colorB, const uint stride = 300)
{
	if (thisEntity.CheckCustomData("blinkElapsedTime") == DT_NODATA)
	{
		thisEntity.SetUInt("blinkElapsedTime", 0);
	}

	thisEntity.AddToUInt("blinkElapsedTime", g_timeManager.getLastFrameElapsedTime());
	const uint elapsedTime = thisEntity.GetUInt("blinkElapsedTime");

	const bool invert = (((elapsedTime / stride) % 2) == 1);
	float bias = float(elapsedTime % stride) / float(stride);
	bias = invert ? 1.0f - bias : bias;
	const vector3 color(interpolate(colorA, colorB, bias));

	thisEntity.SetColor(color);
}

void blinkEmissive(ETHEntity@ thisEntity, const vector3 &in colorA, const vector3 &in colorB, const uint stride = 300)
{
	if (thisEntity.CheckCustomData("blinkElapsedTime") == DT_NODATA)
	{
		thisEntity.SetUInt("blinkElapsedTime", 0);
	}

	thisEntity.AddToUInt("blinkElapsedTime", g_timeManager.getLastFrameElapsedTime());
	const uint elapsedTime = thisEntity.GetUInt("blinkElapsedTime");

	const bool invert = (((elapsedTime / stride) % 2) == 1);
	float bias = float(elapsedTime % stride) / float(stride);
	bias = invert ? 1.0f - bias : bias;
	const vector3 color(interpolate(colorA, colorB, bias));

	thisEntity.SetEmissiveColor(color);
}

void bounce(ETHEntity@ thisEntity, const vector2 &in scaleA, const vector2 &in scaleB, const uint stride = 300)
{
	if (thisEntity.CheckCustomData("blinkElapsedTime") == DT_NODATA)
	{
		thisEntity.SetUInt("blinkElapsedTime", 0);
	}

	thisEntity.AddToUInt("blinkElapsedTime", g_timeManager.getLastFrameElapsedTime());
	const uint elapsedTime = thisEntity.GetUInt("blinkElapsedTime");

	const bool invert = (((elapsedTime / stride) % 2) == 1);
	float bias = float(elapsedTime % stride) / float(stride);
	bias = invert ? 1.0f - bias : bias;
	const vector2 scale(interpolate(scaleA, scaleB, smoothEnd(bias)));

	thisEntity.SetScale(GetScreenSize().y / 480*scale);
}

/*
Requires two properties:
float stride
float speed
*/
void linearMotion(ETHEntity@ thisEntity, const bool vertical, const float angle = 0.0f, const float startAngle = 0.0f)
{
	if (thisEntity.CheckCustomData("originalPos") == DT_NODATA)
	{
		thisEntity.SetVector3("originalPos", thisEntity.GetPosition());
		thisEntity.SetFloat("angle", startAngle);
	}

	const float speed = thisEntity.GetFloat("speed");
	thisEntity.AddToFloat("angle", UnitsPerSecond(speed));
	if (thisEntity.GetFloat("angle") > PI * 2)
	{
		thisEntity.AddToFloat("angle",-PI * 2);
	}

	const float stride = thisEntity.GetFloat("stride");
	const float offset = cos(thisEntity.GetFloat("angle")) * stride * sign(speed);

	matrix4x4 m = rotateZ(degreeToRadian(angle));
	const vector3 offsetV3 = multiply((vertical) ? vector3(0, offset, 0) : vector3(offset, 0, 0), m);

	thisEntity.SetPosition(thisEntity.GetVector3("originalPos") + (offsetV3 * GetScale()));
}

void followUp(ETHEntity@ thisEntity, const vector2 destPos, const uint interpStride = 600, const uint updateRate = 100, const bool dontPause = true)
{
	if (thisEntity.CheckCustomData("switchTime") == DT_NODATA)
	{
		PositionInterpolator@ interp = PositionInterpolator(thisEntity.GetPositionXY(), destPos, interpStride, dontPause);
		@(interp.m_filter) = @smoothEnd;
		thisEntity.SetObject("interp", @interp);
		thisEntity.SetUInt("switchTime", 0);
	}
	PositionInterpolator@ interp;
	thisEntity.GetObject("interp", @interp);
	if (thisEntity.GetPositionXY() != destPos && thisEntity.GetUInt("switchTime") > updateRate)
	{
		interp.reset(interp.getCurrentPos(), destPos, interpStride);
		thisEntity.SetUInt("switchTime", 0);
	}
	thisEntity.AddToUInt("switchTime", (dontPause) ? GetLastFrameElapsedTime() : g_timeManager.getLastFrameElapsedTime());
	interp.update();
	thisEntity.SetPositionXY(interp.getCurrentPos());
}

void forceFollowUpPosition(ETHEntity@ thisEntity, const vector2 &in pos)
{
	PositionInterpolator@ interp;
	thisEntity.GetObject("interp", @interp);
	interp.forcePointA(pos);
	interp.forcePointB(pos);
	thisEntity.SetPositionXY(pos);
}

void scaleToSize(ETHEntity@ entity, const vector2 &in size)
{
	const vector2 currentSize(entity.GetSize());
	entity.Scale(vector2(size.x / currentSize.x, size.y / currentSize.y));
}

void addProjectileEntity(const string &in name, const vector3 &in pos, const vector2 &in dir, const float speed, const float scaleValue)
{
	ETHEntity@ entity;
	AddEntity(name, pos, @entity);
	entity.Scale(scaleValue);
	entity.SetVector2("direction", normalize(dir));
	entity.SetFloat("speed", speed * scaleValue);
}

void projectileBehaviour(ETHEntity@ thisEntity)
{
	const vector2 dir(thisEntity.GetVector2("direction"));
	thisEntity.SetAngle(radianToDegree(getAngle(dir)));
	thisEntity.AddToPositionXY(g_timeManager.unitsPerSecond(dir * thisEntity.GetFloat("speed")));
}


funcdef float INTERPOLATION_FILTER(const float v);

float defaultFilter(const float v) { return v; }
float smoothEnd(const float v)      { return sin(v * (PIb)); }
float smoothBeginning(const float v) { return (1.0f - smoothEnd(1.0f - v)); }
float smoothBothSides(const float v) { return smoothBeginning(smoothEnd(v)); }

float elastic(const float n)
{
	if (n == 0.0f || n == 1.0f)
	{
		return n;
	}
	double p = 0.3f, s = p / 4.0f;
	return pow(2.0f, -10.0f * n) * sin((n - s) * (2 * PI) / p) + 1;
}

float interpolate(const float a, const float b, const float bias)
{
	return a + ((b - a) * bias);
}

vector2 interpolate(const vector2 &in a, const vector2 &in b, const float bias)
{
	return a + ((b - a) * bias);
}

vector3 interpolate(const vector3 &in a, const vector3 &in b, const float bias)
{
	return a + ((b - a) * bias);
}



class InterpolationTimer
{
	InterpolationTimer(const uint _millisecs, const bool dontPause)
	{
		reset(_millisecs);
		@m_filter = @smoothEnd;
		m_dontPause = dontPause;
	}
	
	void update()
	{
		if (m_dontPause)
			m_elapsedTime += GetLastFrameElapsedTime();
		else
			m_elapsedTime += g_timeManager.getLastFrameElapsedTime();
	}

	float getBias() const
	{
		return (!isOver()) ? m_filter(min(max(float(m_elapsedTime) / float(m_time), 0.0f), 1.0f)) : 1.0f;
	}

	float getUnfilteredBias() const
	{
		return (!isOver()) ? (min(max(float(m_elapsedTime) / float(m_time), 0.0f), 1.0f)) : 1.0f;
	}

	void reset(const uint _millisecs)
	{
		m_time = _millisecs;
		m_elapsedTime = 0;
	}

	bool isOver() const
	{
		return (m_elapsedTime > m_time);
	}

	void setFilter(INTERPOLATION_FILTER@ filter)
	{
		@m_filter = @filter;
	}

	uint m_elapsedTime;
	uint m_time;
	INTERPOLATION_FILTER@ m_filter;
	bool m_dontPause;
}

class PositionInterpolator : InterpolationTimer
{
	private vector2 m_a;
	private vector2 m_b;

	PositionInterpolator()
	{
		super(0, false);
	}

	PositionInterpolator(const vector2 &in _a, const vector2 &in _b, const uint _millisecs, const bool dontPause = false)
	{
		super(_millisecs, dontPause);
		reset(_a, _b, _millisecs);
	}

	void reset(const vector2 &in _a, const vector2 &in _b, const uint _millisecs)
	{
		InterpolationTimer::reset(_millisecs);
		m_a = _a;
		m_b = _b;
	}

	void forcePointA(const vector2 &in a)
	{
		m_a = a;
	}

	void forcePointB(const vector2 &in b)
	{
		m_b = b;
	}

	vector2 getCurrentPos() const
	{
		if (m_elapsedTime > m_time)
		{
			return m_b;
		}
		else
		{
			const float bias = getBias();
			return interpolate(m_a, m_b, bias);
		}
	}
}