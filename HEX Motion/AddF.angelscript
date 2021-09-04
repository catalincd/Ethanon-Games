//int funcNum = 5;
int Add1(int pos, ETHEntityArray& arr)
{	
	for(int i=0;i<4;i++)
		for(int j=0;j<5;j++)
			{
				ETHEntity@ en;
				AddEntity("block.ent", vector3(100+(j*500*randF(0,1)),pos*70+(i*-140),0)*GetScale(), 0, en, "block.ent", 1);
				en.SetUInt("f", i%2+1);
				en.SetFloat("y", (pos*70+(i*-140))*GetScale());
				arr.Insert(en);
			}
	return 8; 
	
}





/*
int Add(int pos, ETHEntityArray& arr)
{
	return ;
}
*/