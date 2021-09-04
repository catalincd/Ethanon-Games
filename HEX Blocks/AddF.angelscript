//int funcNum = 5;
int Add1(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
		for(int j=0;j<3;j++)
			{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"3.ent", vector3(80+(j*280),pos*70+(i*-140),0)*GetScale(), 0, en, "block3.ent", 1);
				en.SetUInt("f", i%2+1);
				en.SetFloat("y", (pos*70+(i*-140))*GetScale());
				arr.Insert(en);
			}
	return 8; 
	
}

int Add2(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 3);
				en.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-210)*GetScale()));
				en.SetFloat("radius", 210*GetScale());
				en.SetAngle(i*90);
				arr.Insert(en);
	}
	return 9;
}


int Add3(int pos, ETHEntityArray& arr)
{

	for(int i=0;i<4;i++)
	{
		for(int j=0;j<3-(i%2);j++)
		{
			ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"3.ent", vector3(80+(j*280)+((i%2)*140), pos*70-(i*175),0)*GetScale(), 0, en, "block3.ent", 1);
			en.SetFloat("y", (pos*70+(i*-175))*GetScale());

			arr.Insert(en);
		}
	}
	return 10;
}

int Add4(int pos, ETHEntityArray& arr)
{	
	for(int i=0;i<3;i++)
	{
		ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"3.ent", vector3(80+(i*280), pos*70-70,0)*GetScale(), 0, en, "block3.ent", 1);
			en.SetUInt("f", 4);
			en.SetFloat("y", (pos*70-70)*GetScale());
			arr.Insert(en);
	}

	return 4;
}

int Add5(int pos, ETHEntityArray& arr)
{	
	for(int i=0;i<3;i++)
	{
		ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"3.ent", vector3(80+(i*280), pos*70-70,0)*GetScale(), 0, en, "block3.ent", 1);
			en.SetUInt("f", 5);
			en.SetFloat("y", (pos*70-70)*GetScale());
			arr.Insert(en);
	}

	return 4;
}


int Add6(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 1);
				en.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-210)*GetScale()));
				en.SetFloat("radius", 210*GetScale());
				en.SetFloat("angle", i*90);
				arr.Insert(en);
	}
	ETHEntity@ xen, xen2, xen3, xen4;
			AddEntity(dataBase.BLOCK+"3.ent", vector3(35*GetScale(), (pos*70-210)*GetScale(), 0), 0, xen, "block3.ent", 1);
			xen.SetFloat("y", (pos*70)*GetScale());
			AddEntity(dataBase.BLOCK+"3.ent", vector3(35*GetScale(), (pos*70-420)*GetScale(), 0), 0, xen2, "block3.ent", 1);
			xen2.SetFloat("y", (pos*70-420)*GetScale());
			AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X-35*GetScale(), (pos*70-210)*GetScale(), 0), 0, xen3, "block3.ent", 1);
			xen3.SetFloat("y", (pos*70)*GetScale());
			AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X-35*GetScale(), (pos*70-420)*GetScale(), 0), 0, xen4, "block3.ent", 1);
			xen4.SetFloat("y", (pos*70-420)*GetScale());

	arr.Insert(xen);
	arr.Insert(xen2);
	arr.Insert(xen3);
	arr.Insert(xen4);

	return 9;
}

int Add7(int pos, ETHEntityArray& arr)
{
	ETHEntity@ center;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X2, (pos*70-280)*GetScale(),0), 0,center, "block3.ent", 1);
	center.SetFloat("y",(pos*70-280)*GetScale());
	for(int i=0;i<2;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 2);
				en.SetFloat("radius", 280*GetScale());
				en.SetAngle(i*180);
				en.SetObject("target", @center);
				arr.Insert(en);
	}
	arr.Insert(center);
	return 11;
}

int Add8(int pos, ETHEntityArray& arr)
{
	ETHEntity@ center;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X2, (pos*70-280)*GetScale(),0), 0, center, "block3.ent", 1);
	center.SetFloat("y",(pos*70-280)*GetScale());
	for(int i=0;i<3;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 2);
				en.SetFloat("radius", 280*GetScale());
				en.SetAngle(i*120);
				en.SetObject("target", @center);
				arr.Insert(en);
	}
	arr.Insert(center);
	return 11;
}

int Add9(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
		if(i%2==0)
			for(int j=0;j<3;j++)
			{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(80+(j*280),pos*70+(i*-140),0)*GetScale(), 0, en, "block2.ent", 1);
				en.SetUInt("f", i%2+4);
				en.SetFloat("y", (pos*70+(i*-140))*GetScale());
				arr.Insert(en);
			}
		else
			for(int j=0;j<3;j++)
			{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"3.ent", vector3(80+(j*280),pos*70+(i*-140),0)*GetScale(), 0, en, "block3.ent", 1);
				en.SetUInt("f", i/2%2+1);
				en.SetFloat("y", (pos*70+(i*-140))*GetScale());
				arr.Insert(en);
			}
	return 8; 
	
}

int Add10(int pos, ETHEntityArray& arr)
{

	for(int i=0;i<4;i++)
	{
		for(int j=0;j<3-(i%2);j++)
		{
			ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"2.ent", vector3(80+(j*280)+((i%2)*140), pos*70-(i*175),0)*GetScale(), 0, en, "block2.ent", 1);
			en.SetFloat("y", (pos*70+(i*-175))*GetScale());
			en.SetUInt("f", i%2+4);
			arr.Insert(en);
		}
	}
	return 10;
}


int Add11(int pos, ETHEntityArray& arr)
{	
	for(int i=0;i<3;i++)
	{
		ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"2.ent", vector3(80+(i*280), pos*70-70,0)*GetScale(), 0, en, "block2.ent", 1);
			en.SetUInt("f", 6);
			en.SetFloat("y", (pos*70-70)*GetScale());
			arr.Insert(en);
	}

	return 4;
}

int Add12(int pos, ETHEntityArray& arr)
{	
	for(int i=0;i<3;i++)
	{
		ETHEntity@ en;
			AddEntity(dataBase.BLOCK+"2.ent", vector3(80+(i*280), pos*70-70,0)*GetScale(), 0, en, "block2.ent", 1);
			en.SetUInt("f", 7);
			en.SetFloat("y", (pos*70-70)*GetScale());
			arr.Insert(en);
	}

	return 4;
}

int Add13(int pos, ETHEntityArray& arr)
{	
	ETHEntity@ p1,p2,p3,p4,p5;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(640, pos*70,0)*GetScale(), 0, p5, "block3.ent", 1);
	p5.SetFloat("y", pos*70*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(80, pos*70-560,0)*GetScale(), 0, p4, "block3.ent", 1);
	p4.SetFloat("y", (pos*70-560)*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(220, pos*70-140,0)*GetScale(), 0, p3, "block3.ent", 1);
	p3.SetFloat("y", (pos*70-140)*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(500, pos*70-420,0)*GetScale(), 0, p2, "block3.ent", 1);
	p2.SetFloat("y", (pos*70-420)*GetScale());
	AddEntity(dataBase.BLOCK+"2.ent", vector3(150, pos*70-490,0)*GetScale(), 0, p1, "block2.ent", 1);
	p1.SetUInt("a", 1);
	p1.SetUInt("f", 8);
	p1.SetInt("up", -1);
	p1.SetFloat("limitL", 150*GetScale());
	p1.SetFloat("limitR", 570*GetScale());
	arr.Insert(p1);
	arr.Insert(p2);
	arr.Insert(p3);
	arr.Insert(p4);
	arr.Insert(p5);
	//arr.insert(p2);

	return 11;
}

int Add14(int pos, ETHEntityArray& arr)
{	
	ETHEntity@ p1,p2,p3,p4,p5,p6;
	AddEntity(dataBase.BLOCK+"2.ent", vector3(80, pos*70-490,0)*GetScale(), 0, p6, "block2.ent", 1);
	AddEntity(dataBase.BLOCK+"2.ent", vector3(80, pos*70-70,0)*GetScale(), 0, p5, "block2.ent", 1);
	AddEntity(dataBase.BLOCK+"2.ent", vector3(640, pos*70-490,0)*GetScale(), 0, p4, "block2.ent", 1);
	AddEntity(dataBase.BLOCK+"2.ent", vector3(640, pos*70-70,0)*GetScale(), 0, p3, "block2.ent", 1);
	AddEntity(dataBase.BLOCK+"2.ent", vector3(360, pos*70-280,0)*GetScale(), 0, p2, "block2.ent", 1);
	AddEntity(dataBase.BLOCK+"2.ent", vector3(150, pos*70-490,0)*GetScale(), 0, p1, "block2.ent", 1);
	p1.SetUInt("f", 8);
	p1.SetInt("up", -1);
	p1.SetFloat("limitL", 150*GetScale());
	p1.SetFloat("limitR", 570*GetScale());
	
	p2.SetUInt("f", 9);
	p2.SetInt("up", -1);
	p2.SetFloat("limitL", 150*GetScale());
	p2.SetFloat("limitR", 570*GetScale());
	
	p1.SetUInt("a", 1);
	p2.SetUInt("a", 1);
	p3.SetUInt("a", 1);
	p4.SetUInt("a", 1);
	p5.SetUInt("a", 1);
	p6.SetUInt("a", 1);
	
	arr.Insert(p1);
	arr.Insert(p2);
	arr.Insert(p3);
	arr.Insert(p4);
	arr.Insert(p5);
	arr.Insert(p6);

	return 9;
}

int Add15(int pos, ETHEntityArray& arr)
{
	ETHEntity@ center;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X2, (pos*70-280)*GetScale(),0), 0, center, "block3.ent", 1);
	center.SetFloat("y",(pos*70-280)*GetScale());
	for(int i=0;i<3;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 2);
				en.SetFloat("radius", 280*GetScale());
				en.SetAngle(i*120);
				en.SetObject("target", @center);
				arr.Insert(en);
	}
	for(int i=0;i<3;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 2);
				en.SetUInt("a2", 1);
				en.SetFloat("radius", 100*GetScale());
				en.SetAngle(i*120);
				en.SetObject("target", @center);
				arr.Insert(en);
	}
	arr.Insert(center);
	return 11;
}

int Add16(int pos, ETHEntityArray& arr)
{
	ETHEntity@ p1,p2,p3,p4;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(220*GetScale(), (pos*70-70)*GetScale(),0), 0, p1, "block3.ent", 1);
	AddEntity(dataBase.BLOCK+"3.ent", vector3(220*GetScale(), (pos*70-350)*GetScale(),0), 0, p2, "block3.ent", 1);
	AddEntity(dataBase.BLOCK+"3.ent", vector3(500*GetScale(), (pos*70-70)*GetScale(),0), 0, p3, "block3.ent", 1);
	AddEntity(dataBase.BLOCK+"3.ent", vector3(500*GetScale(), (pos*70-350)*GetScale(),0), 0, p4, "block3.ent", 1);
	
	
	p1.SetFloat("radius", 210*GetScale());
	p2.SetFloat("radius", 210*GetScale());
	p3.SetFloat("radius", 210*GetScale());
	p4.SetFloat("radius", 210*GetScale());
	
	p1.SetFloat("angle", 0);
	p2.SetFloat("angle", 90);
	p3.SetFloat("angle", 180);
	p4.SetFloat("angle", 270);
	
	p1.SetUInt("f", 10);
	p2.SetUInt("f", 10);
	p3.SetUInt("f", 10);
	p4.SetUInt("f", 10);
	
	p1.SetFloat("factor", 1);
	p2.SetFloat("factor", 1);
	p3.SetFloat("factor", 1);
	p4.SetFloat("factor", 1);
	
	p1.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-280)*GetScale()));
	p2.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-280)*GetScale()));
	p3.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-280)*GetScale()));
	p4.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-280)*GetScale()));
	
	arr.Insert(p1);
	arr.Insert(p2);
	arr.Insert(p3);
	arr.Insert(p4);
	
	ETHEntity@ xen, xen2, xen3, xen4;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(35*GetScale(), (pos*70-70)*GetScale(), 0), 0, xen, "block3.ent", 1);
	xen.SetFloat("y", (pos*70-70)*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(35*GetScale(), (pos*70-490)*GetScale(), 0), 0, xen2, "block3.ent", 1);
	xen2.SetFloat("y", (pos*70-490)*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X-35*GetScale(), (pos*70-70)*GetScale(), 0), 0, xen3, "block3.ent", 1);
	xen3.SetFloat("y", (pos*70-70)*GetScale());
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X-35*GetScale(), (pos*70-490)*GetScale(), 0), 0, xen4, "block3.ent", 1);
	xen4.SetFloat("y", (pos*70-490)*GetScale());

	arr.Insert(xen);
	arr.Insert(xen2);
	arr.Insert(xen3);
	arr.Insert(xen4);
	
	return 9;
}

int Add17(int pos, ETHEntityArray& arr)
{
	ETHEntity@ center;
	AddEntity(dataBase.BLOCK+"3.ent", vector3(SCREEN_SIZE_X2, (pos*70-350)*GetScale(),0), 0, center, "block3.ent", 1);
	center.SetFloat("y", (pos*70-350)*GetScale());
	arr.Insert(center);

	for(int i=0;i<8;i++)
	{
		ETHEntity@ en;
		AddEntity(dataBase.BLOCK+"3.ent", vector3(220*GetScale(), (pos*70-70)*GetScale(),0), 0, en, "block3.ent", 1);
		en.SetFloat("radius", 280*GetScale());
		en.SetFloat("angle", i*45);
		en.SetFloat("factor", 0.5);
		en.SetUInt("f", 10);
		en.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-350)*GetScale()));
		arr.Insert(en);
	}

	return 13;
}

int Add18(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 10);
				en.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-280)*GetScale()));
				en.SetFloat("radius", 210*GetScale());
				en.SetAngle(i*90);
				en.SetInt("up", -1);
				arr.Insert(en);
	}
	return 11;
}

int Add19(int pos, ETHEntityArray& arr)
{

	for(int i=0;i<4;i++)
	{
				ETHEntity@ en;
				AddEntity(dataBase.BLOCK+"2.ent", vector3(SCREEN_SIZE_X2+75*i, pos*70*GetScale(),0), 0, en, "block2.ent", 1);
				en.SetUInt("f", 11);
				en.SetInt("up", 1);
				en.SetVector2("center", vector2(SCREEN_SIZE_X2, (pos*70-315)*GetScale()));
				en.SetFloat("radius", 210*GetScale());
				en.SetFloat("angle", i*90);
				arr.Insert(en);
	}
	
	
	return 12;
}

int Add20(int pos, ETHEntityArray& arr)
{
	for(int i=0;i<4;i++)
	{
		ETHEntity@ p1, p2;
		
		float xOffset = (float(i)/5)*300;
		
		AddEntity(dataBase.BLOCK+"3.ent", vector3(80+xOffset, pos*70-(i*175),0)*GetScale(), 0, p1, "block3.ent", 1);
		p1.SetFloat("y", (pos*70+(i*-175))*GetScale());
		
		AddEntity(dataBase.BLOCK+"3.ent", vector3(640-xOffset, pos*70-(i*175),0)*GetScale(), 0, p2, "block3.ent", 1);
		p2.SetFloat("y", (pos*70+(i*-175))*GetScale());

		
		arr.Insert(p1);
		arr.Insert(p2);
	}
	
	return 10;
}

/*
int Add(int pos, ETHEntityArray& arr)
{
	return ;
}
*/