vector2 mazeSize;
vector2 cellSize;
vector2 cellOffset;
vector2 offset;
float cellScale = 1.0f;

class Maze
{
	
	
	
	void init(uint WIDTH = 5)
	{
		float cellSizeX = GetScreenSize().x * mazeToWidthRatio * (1.0f / float(WIDTH));
		uint finalCellSize = ceil(cellSizeX);
		cellSize = vector2(finalCellSize, finalCellSize);
		mazeSize = cellSize * WIDTH;
		
		cellScale = (10.0f / float(WIDTH));
		cellScale = float(floor(cellScale * cellSize.x)) / cellSize.x;
		
		offset = (GetScreenSize() - mazeSize) / 2;
		
		if(LAYOUT == 1)
			offset -= vector2(0.0f, GetScreenSize().y * 0.05f);
		if(LAYOUT == 2)
			offset -= vector2(0.0f, GetScreenSize().y * 0.04f);
		
		cellOffset = offset + (cellSize / 2);
	}
	
	
	
	void create()
	{
		init();
		g_ball.create();
		set();
		g_mazeGen.createMaze(9999, MAZE_WIDTH);
	}
	
	void set()
	{
		if(CASUAL)
		{
			init(MAZE_WIDTH);
		}
		else
		{
			MAZE_WIDTH = getMaxWidth(LEVEL);
			init(MAZE_WIDTH);
		}
	}
	
	void update()
	{
		g_ball.update();
		g_mazeGen.update();
	}
	
	void resume()
	{
		g_ball.resume();
	}

}


Maze g_maze;