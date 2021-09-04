void nextLevel()
{
	ui.flickering = true;
	execute(switchLevel, 300);
	g_camera.shake(50);
	g_tap.disable();
	execute(enableTap, 500);
}

void enableTap()
{
	ui.flickering = false;
	g_tap.enable();
}

void switchLevel()
{
	LEVEL++;
	progress.save();
	g_maze.init();
	g_maze.set();
	g_mazeGen.recreate();
}