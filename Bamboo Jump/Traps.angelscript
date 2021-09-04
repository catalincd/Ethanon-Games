class Static2 : Trap
{
	Static2()
	{
		heightUnits = 3;
	}

	void create(float height, ETHEntityArray& q) override
	{
		ETHEntity@ b1,b2;
		AddEntity("bamboo.ent", vector3(GetScreenSize().x * 0.25f, height, 0), @b1);
		AddEntity("bamboo.ent", vector3(GetScreenSize().x * 0.75f, height, 0), @b2);
		
		
		
		b1.Scale(1.875f);
		b2.Scale(1.875f);
		
		q.Insert(b1);		
		q.Insert(b2);				
	}
	
	void update() override
	{
		int q = 1;
	}
}

class VerticalSwipe : Trap
{
		VerticalSwipe()
	{
		heightUnits = 4;
	}

	void create(float height, ETHEntityArray& q) override
	{
		ETHEntity@ b1,b2,b3;
		
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.2f, height, 0), @b1);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.6, height, 0), @b2);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x, height, 0), @b3);
		
		b1.SetUInt("f", 1);b1.SetFloat("y", height);
		b2.SetUInt("f", 1);b2.SetFloat("y", height);
		b3.SetUInt("f", 1);b3.SetFloat("y", height);
		
		b1.Scale(1.875f);
		b2.Scale(1.875f);
		b3.Scale(1.875f);
		
		q.Insert(b1);		
		q.Insert(b2);		
		q.Insert(b3);		
	}
}

class HorizontalSwipe : Trap
{
	HorizontalSwipe()
	{
		heightUnits = 3;
	}

	void create(float height, ETHEntityArray& q) override
	{
		ETHEntity@ b1,b2,b3;
		
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.0f, height, 0), @b1);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.5f, height, 0), @b2);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x, height, 0), @b3);
		
		b1.SetUInt("f", 2);b1.SetFloat("y", height);
		b2.SetUInt("f", 2);b2.SetFloat("y", height);
		b3.SetUInt("f", 2);b3.SetFloat("y", height);
		
		b1.Scale(1.875f);
		b2.Scale(1.875f);
		b3.Scale(1.875f);
		
		q.Insert(b1);		
		q.Insert(b2);		
		q.Insert(b3);		
	}
}

class HorizontalFullSwipe : Trap
{
	HorizontalFullSwipe()
	{
		heightUnits = 3;
	}

	void create(float height, ETHEntityArray& q) override
	{
		ETHEntity@ b1,b2,b3;
		
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.2f, height, 0), @b1);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.5f, height, 0), @b2);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.8f, height, 0), @b3);
		
		b1.SetUInt("f", 4);b1.SetFloat("y", height);
		b2.SetUInt("f", 4);b2.SetFloat("y", height);
		b3.SetUInt("f", 4);b3.SetFloat("y", height);
		
		b1.Scale(1.875f);
		b2.Scale(1.875f);
		b3.Scale(1.875f);
		
		q.Insert(b1);		
		q.Insert(b2);		
		q.Insert(b3);		
	}
}

class RotatinSwipe : Trap
{
	RotatinSwipe()
	{
		heightUnits = 3;
	}

	void create(float height, ETHEntityArray& q) override
	{
		ETHEntity@ b1,b2,b3;
		
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.0f, height, 0), @b1);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x * 0.5f, height, 0), @b2);
		AddEntity("bamboo_dynamic.ent", vector3(GetScreenSize().x, height, 0), @b3);
		
		uint qq = rand(0,9);
		uint qq2 = rand(0,9);
		int dir = (qq % 2 == 0? -1:1);
		int dir2 = (qq % 2 == 0? -1:1);
		
		b1.SetUInt("f", 3);b1.SetFloat("y", height);b1.SetInt("dir", dir);b1.SetInt("dir2", dir2);
		b2.SetUInt("f", 3);b2.SetFloat("y", height);b2.SetInt("dir", dir);b2.SetInt("dir2", dir2);
		b3.SetUInt("f", 3);b3.SetFloat("y", height);b3.SetInt("dir", dir);b3.SetInt("dir2", dir2);
		
		
		
		b1.Scale(1.875f);
		b2.Scale(1.875f);
		b3.Scale(1.875f);
		
		q.Insert(b1);		
		q.Insert(b2);		
		q.Insert(b3);		
	}
}
//