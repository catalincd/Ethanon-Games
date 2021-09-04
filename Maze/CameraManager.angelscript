class CameraManager
{
	bool shaking = false;
	vector2 initPos = V2_ZERO;
	vector2 offset;
	uint shakeStride = 300;
	uint shakeElapsed = 0;
	float shakeBias;
	float shakeAmplitude;
	
	void reset()
	{
		shaking = false;
		shakeElapsed = 0;
	}

	void create()
	{
		reset();
	}
	
	void update()
	{
		if(GetInputHandle().GetKeyState(K_SPACE) == KS_HIT)
			shake(50);
	
		if(shaking)
		{
		
			shakeBias = float(shakeElapsed) / float(shakeStride);
			
			float currentAmpBias = smoothBeginning(ShakeFilter(shakeBias));
			
			offset = vector2(randF(-1.0f, 1.0f), randF(-1.0f, 1.0f)) * currentAmpBias * shakeAmplitude * GetScale();

			shakeElapsed += GetLastFrameElapsedTime();
			
			if(shakeElapsed > shakeStride)
				shaking = false;			
		}
		else offset = V2_ZERO;
		
		SetCameraPos(initPos + offset);
	}
	
	vector2 getOffset() const
	{
		return offset;
	}
	
	void shake(float amp = 1.0f, float stride = 1000)
	{
		shakeAmplitude = amp;
		shakeElapsed = 0;
		shakeStride = 1000;
		shaking = true;
	}
	
	void resume()
	{
		reset();
	}
}

CameraManager g_camera;

float ShakeFilter(float bias)
{
	return topBias(bias, 0.3f);
}

float topBias(float bias, float top)
{
	return bias < top? (bias / top) : ((1.0f - (bias - top)) / (1.0f - top));
}


