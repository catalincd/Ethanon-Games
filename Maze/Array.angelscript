void swap(uint &in a, uint &in b)
{
	uint c = a;
	a = b;
	b = c;
}

void swap(float &in a, float &in b)
{
	float c = a;
	a = b;
	b = c;
}


float[] getArrayFromString(string str)
{
	string[] splitted = split(str, ",");
	float[] arr;
	for(uint i=0;i<splitted.length();i++)
	{
		arr.insertLast(parseFloat(splitted[i]));
	}
	return arr;
}

string getStringFromArray(float[] arr)
{
	string str = ""+arr[0];
	for(uint i=1;i<arr.length();i++)
	{
		str += "," + arr[i];
	}
	return str;
}

void sort(float[]& v, bool ascending = true)
{
	uint len = v.length();
	uint len_it = v.length()-1;
	for(uint i=0;i<len_it;i++)
	{
		for(uint j=i+1;j<len;j++)
		{
			bool smaller = v[i] > v[j];
			if(ascending? smaller : !smaller)
			{
				float new = v[i];
				v[i] = v[j];
				v[j] = new;
			}
		}
	}
}