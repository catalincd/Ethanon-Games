uint A_FAST = 200;
uint A_NORMAL = 300;
uint A_SLOW = 500;


class KeyFrame
{
	float value = 1.0f;
	float bias = 1.0f;
	Filter@ filter = smoothEnd;
	KeyFrame(float _value, float _bias)
	{
		value = _value;
		bias = bias;
	}
	KeyFrame(){}
}

KeyFrame START = KeyFrame(0.0f, 0.0f);
KeyFrame END = KeyFrame(1.0f, 1.0f);


class Animation
{
	KeyFrame first;
	KeyFrame last;
	
	KeyFrame frames;
	
	int current = 0;


}



