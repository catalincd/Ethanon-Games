float defaultFilter(const float v) { return v; }
float smoothEnd(const float v)      { return sin(v * (PIb)); }
float smoothBeginning(const float v) { return (1.0f - smoothEnd(1.0f - v)); }
float smoothBothSides(const float v) { return smoothBeginning(smoothEnd(v)); }

float easeOut(const float v) { return sqrt((2 - v) * v);}
float easeIn(const float v) { return (1.0f - easeOut(1.0f - v)); }
float circularEaseInOut(const float p) {
	if(p < 0.5f)
	{
		return 0.5f * (1 - sqrt(1 - 4 * (p * p)));
	}
	else
	{
		return 0.5f * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1);
	}
}

float boolToSign(float x)
{
	return uint(x)<1? -1.0f:1.0f;
}

float flickerCycles(const float v, const float cycles)
{
	return float(uint(v / cycles) % 2);
}

float flickerCycles(const float v)
{
	return flickerCycles(v, 0.125f);
}


float backOut(const float p)
{
	if(p < 0.5f)
	{
		float f = 2 * p;
		return 0.5f * (f * f * f - f * sin(f * PI));
	}
	else
	{
		float f = (1 - (2*p - 1));
		return 0.5f * (1 - (f * f * f - f * sin(f * PI))) + 0.5f;
	}
}

float bounceOut(const float p)
{
	if(p < 4/11.0f)
	{
		return (121 * p * p)/16.0f;
	}
	else if(p < 8/11.0f)
	{
		return (363/40.0f * p * p) - (99/10.0f * p) + 17/5.0f;
	}
	else if(p < 9/10.0f)
	{
		return (4356/361.0f * p * p) - (35442/1805.0f * p) + 16061/1805.0f;
	}
	else
	{
		return (54/5.0f * p * p) - (513/25.0f * p) + 268/25.0f;
	}
}



float a = 0.1;


float elastic(const float n)
{
	if (n == 0.0f || n == 1.0f)
	{
		return n;
	}
	double p = 0.3f, s = p / 4.0f;
	return pow(2.0f, -10.0f * n) * sin((n - s) * (2 * PI) / p) + 1;
}

float Euler = 2.71828f;

float e(float x)
{
	return pow(Euler,x);
}

float easeExponent(const float v)
{
	return (e(a * v) - 1.0f) / (e(a) - 1.0f);
}

float smoothStep(const float v)
{
	return (v * v * (3 - 2 * v));
}

float smootherStep(const float v)
{
	return ((v) * (v) * (v) * ((v) * ((v) * 6 - 15) + 10));
}

float smoothestStep(const float v)
{
	return smootherStep(smootherStep(v));
}


float catmullrom(float t, float p0, float p3)
{
	float p1 = 0.0f;
	float p2 = 1.0f;
return 0.5f * (
              (2 * p1) +
              (-p0 + p2) * t +
              (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
              (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t
              );
}

float easeOutBack(const float v)
{
	return catmullrom(v, -15, 1);
}

float easyEaseOutBack(const float v)
{
	return catmullrom(v, -10, 1);
}

float squeeze(const float v)
{
	if(v < 0.5f)
		return 1-smootherStep(v * 2.0f);
	else
		return easeOutBack((v - 0.5f) * 2.0f);
}

float heartbeat(const float v)
{
	if(v < 0.5f)
		return 1-smoothBeginning(v * 2.0f);
	else
		return smoothEnd((v - 0.5f) * 2.0f);
}




vector2 bounceHorizontal(const float v)
{
	vector2 m_bounceScaleA = vector2(1.5, 1);
	vector2 m_bounceScaleB = vector2(1, 1);
	float bias = (v < 0.5f? 1-v * 2.0f : (v - 0.5f)*2);
	return interpolate(m_bounceScaleA, m_bounceScaleB, smootherStep(smoothEnd(bias)));
}

vector2 bounceVertical(const float v)
{
	vector2 m_bounceScaleA = vector2(1, 1.5);
	vector2 m_bounceScaleB = vector2(1, 1);
	float bias = (v < 0.5f? 1-v * 2.0f : (v - 0.5f)*2);
	return interpolate(m_bounceScaleA, m_bounceScaleB, smootherStep(smoothEnd(bias)));
}