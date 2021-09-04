string[] split(string str, const string c)
{
	string[] v;
	uint pos;
	while ((pos = str.find(c)) != NPOS)
	{
		v.insertLast(str.substr(0, pos));
		str = str.substr(pos + c.length(), NPOS);
	}
	v.insertLast(str);
	return v;
}



float[] getFloatArrayFromString(string str)
{
	string[] splitted = split(str, ",");
	float[] arr;
	for(uint i=0;i<splitted.length();i++)
	{
		arr.insertLast(parseFloat(splitted[i]));
	}
	return arr;
}

string getStringFromFloatArray(float[] arr)
{
	string str = ""+arr[0];
	for(uint i=1;i<arr.length();i++)
	{
		str += "," + arr[i];
	}
	return str;
}





