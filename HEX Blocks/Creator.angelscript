int create(int pos, ETHEntityArray& arr)
{
	int len = 0;
	//int k = rand(16,20);
	//k=1;
	int k = g_trapManager.getIndex();
	switch(k){
		case 1: return Add1(pos, arr);
		case 2: return Add2(pos, arr);
		case 3: return Add3(pos, arr);
		case 4: return Add4(pos, arr);
		case 5: return Add5(pos, arr);
		case 6: return Add6(pos, arr);
		case 7: return Add7(pos, arr);
		case 8: return Add8(pos, arr);
		case 9: return Add9(pos, arr);
		case 10: return Add10(pos, arr);
		case 11: return Add11(pos, arr);
		case 12: return Add12(pos, arr);
		case 13: return Add13(pos, arr);
		case 14: return Add14(pos, arr);
		case 15: return Add15(pos, arr);
		case 16: return Add16(pos, arr);
		case 17: return Add17(pos, arr);
		case 18: return Add18(pos, arr);
		case 19: return Add19(pos, arr);
		case 20: return Add20(pos, arr);
	}
	return len;
}

class TrapManager
{
	int maximum = 5;
	
	int[] v = {2,3,4,5,9,10,11,12,7,8,13,14,6,15,20,18,19,1,16,17};
	
	
	void onUpdate(float score)
	{
		maximum = 5-int(score/1500/GetScale());
		maximum = min(v.length()-1, maximum);
		//DrawText(vector2(0,300), ""+maximum, dataBase.font30, black);
	}
	
	int getIndex()
	{
		return v[rand(1,maximum)];
		//return 20;
	
	}
	
}

TrapManager g_trapManager;