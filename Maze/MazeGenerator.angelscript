class MazeGenerator
{
	Cell@[] cells;
	Wall@[] walls;
	ETHEntityArray arr;

	uint currentId;
	uint lastId;
	uint visitedNow = 0;
	uint lastVisitedToSpawn;
	
	uint WIDTH = 5;
	uint WIDTHSQ = WIDTH * WIDTH;

	void createMaze(uint startingPoint = 9999, uint newWidth = 5)
	{
		SetGravity(V2_ZERO);
		
		WIDTH = newWidth;
		WIDTHSQ = WIDTH * WIDTH;
		
		arr.RemoveDeadEntities();
		cells.resize(0);
		for(uint i=0;i<arr.Size();i++)
		{
			DeleteEntity(arr[i]);
		}
		arr.RemoveDeadEntities();
		
		for(uint i=0;i<WIDTHSQ;i++)
		{
			cells.insertLast(Cell(vector2(i%WIDTH, i/WIDTH), i));
		}
		uint randId = startingPoint == 9999? rand(0, WIDTHSQ-1) : startingPoint;
		cells[randId].visited = true;
		currentId = randId;
		lastId = randId;
		visitedNow = 1;
		lastVisitedToSpawn = 9999;
		while(visitedNow < WIDTHSQ)
			next();
		generateWalls();
		addWalls();
		
		//getAllRoutes(randId);
		//uint x = getNextStart(randId);
		
		
		g_gameBackground.change();
		ui.setText();
		g_ball.add(getPos(vector2(randId%WIDTH, randId/WIDTH)), getPos(vector2(lastVisitedToSpawn%WIDTH, lastVisitedToSpawn/WIDTH)));
		
	
	}
	
	void update()
	{
		
	}
	
	void recreate()
	{
		createMaze(lastVisitedToSpawn, MAZE_WIDTH);
	}
	
	
	uint getAllRoutes(uint initCell)
	{
		Counter@[] counters;
		Counter@ init = Counter(1);
		counters.insertLast(init);
		
		getMaxRoute(initCell, counters, 0);

		print(counters.length());
	
		return 0;
	}
	
	void getMaxRoute(uint initCell, Counter@[]& counters, uint counterId)
	{
		vector2 last = getV2(counters[counterId].lastCell());
		vector2 p = cells[initCell].pos;
		vector2 top = p + vector2(0,-1);  //1
		vector2 down = p + vector2(0,1);  //2
		vector2 left = p + vector2(-1,0); //3
		vector2 right = p + vector2(1,0); //4
		
		uint added = 0;
		
		

		Counter@ current = counters[counterId];
		counters.removeAt(counterId);

		if(top != last && bound(p, top))
		{
			uint newTop = getId(top);
			counters.insertLast(current.get(newTop));
			getMaxRoute(newTop, counters, counters.length()-1);
			added++;
		}
		
		if(down != last && bound(p, down))
		{
			uint newTop = getId(down);
			counters.insertLast(current.get(newTop));
			getMaxRoute(newTop, counters, counters.length()-1);
			added++;
		}
		
		if(left != last && bound(p, left))
		{
			uint newTop = getId(left);
			counters.insertLast(current.get(newTop));
			getMaxRoute(newTop, counters, counters.length()-1);
			added++;
		}
		
		if(right != last && bound(p, right))
		{
			uint newTop = getId(right);
			counters.insertLast(current.get(newTop));
			getMaxRoute(newTop, counters, counters.length()-1);
			added++;
		}
		
		if(added == 0)
		
		counters.insertLast(current);

	}
	
	
	void addWalls()
	{
		
		for(uint i=0;i<walls.length();i++)
		{
			ETHEntity@ current;
			AddEntity("wall.ent", vector3(walls[i].pos, 3), @current);
			if(walls[i].vertical)
				current.SetAngle(90);
			current.Scale(cellScale);
			current.SetColor(black.getVector3());
			arr.Insert(current);
		}
		
		uint target = (WIDTH+1)*(WIDTH+1);
		
		for(uint i=0;i<target;i++)
		{
			ETHEntity@ current;
			AddEntity("bind.ent", vector3(getBindPos(i, WIDTH+1), 3), @current);
			current.Scale(cellScale);
			current.SetColor(black.getVector3());
			arr.Insert(current);
		}
	}
	
	void generateWalls()
	{
		walls.resize(0);
		for(uint i=0;i<WIDTH;i++)
		{
			walls.insertLast(Wall(getPos(vector2(i, 0), vector2(0, -1)), false));
			walls.insertLast(Wall(getPos(vector2(0, i), vector2(-1, 0)), true));
		}
		
		for(uint i=0;i<WIDTHSQ;i++)
		{
			uint x = i%WIDTH;
			uint y = i/WIDTH;
			
			if(!bound(i, i+1))
				walls.insertLast(Wall(getPos(vector2(x, y), vector2(1, 0)), true));
			if(!bound(i, i+WIDTH))
				walls.insertLast(Wall(getPos(vector2(x, y), vector2(0, 1)), false));
				
		}
	}
	
	void next()
	{
		
		uint[] cases;
		vector2 p = cells[currentId].pos;
		vector2 top = p + vector2(0,-1);
		vector2 down = p + vector2(0,1);
		vector2 left = p + vector2(-1,0);
		vector2 right = p + vector2(1,0);
	
		if(check(top))cases.insertLast(currentId-WIDTH);
		if(check(down))cases.insertLast(currentId+WIDTH);
		if(check(left))cases.insertLast(currentId-1);
		if(check(right))cases.insertLast(currentId+1);
		
		
		
		if(cases.length() > 0)
		{
			lastId = currentId;
			currentId = randOf(cases);
			cells[currentId].visited = true;
			cells[currentId].parentId = lastId;
			visitedNow++;
		}
		else
		{
			if(lastVisitedToSpawn == 9999)lastVisitedToSpawn = currentId;
			currentId = lastId;
			lastId = cells[currentId].parentId;
		}
	}
	
	bool check(vector2 pos)
	{
		if(pos.x < 0 || pos.y < 0 || uint(pos.x) >= WIDTH || uint(pos.y) >= WIDTH)
			return false;
		return !cells[pos.x + pos.y*WIDTH].visited;
	}
	
	uint getId(vector2 v)
	{
		return v.x + v.y*WIDTH;
	}
	
	vector2 getV2(uint id)
	{
		return vector2(id%WIDTH, id/WIDTH);
	}
	
	bool bound(vector2 a, vector2 b)
	{
		return bound(getId(a), getId(b));
	}
	
	bool bound(uint cellA, uint cellB)
	{
		if(cellA >= WIDTHSQ || cellB >= WIDTHSQ) return false;
		return (cells[cellB].parentId == cellA || cells[cellA].parentId == cellB);
	}
}

class Cell
{
	bool visited = false;
	vector2 pos;
	uint id,parentId;
	Cell(){}
	Cell(vector2 _pos, uint _id)
	{
		pos = _pos;
		id = _id;
	}
}

class Wall
{
	vector2 pos;
	bool vertical;
	
	Wall(){}
	
	Wall(vector2 p, bool v)
	{
		pos = p;
		vertical = v;
	}
}

class Counter
{

	uint[] cells;
	Counter(uint q)
	{
		cells.insertLast(q);
	}
	
	Counter(uint[] c)
	{

		c.resize(0);
		c = cells;
	}
	
	void push(uint x)
	{
		cells.insertLast(x);
	}
	
	Counter@ get(uint x)
	{
		cells.insertLast(x);
		return this;
	}
	
	uint lastCell()
	{
		return cells[cells.length()-1];
	}
}

vector2 getPos(vector2 id, vector2 dir)
{
	return getPos(id) + (dir * cellSize * 0.5f);
}

vector2 getBindPos(uint id, uint WIDTH)
{
	float x = float(id % WIDTH) * cellSize.x;
	float y = float(id / WIDTH) * cellSize.x;
	
	return cellOffset + vector2(x,y) - (cellSize / 2.0f);
}


vector2 getPos(vector2 id)
{
	return cellOffset + (id * cellSize);
}

uint randOf(uint[] vars)
{
	uint len = vars.length();
	return vars[rand(0, len-1)];
}

MazeGenerator g_mazeGen;