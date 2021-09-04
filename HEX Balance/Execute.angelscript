funcdef void VOID();
void VOID_NULL(){}

class Execute
{

	uint normalElapsed;
	uint pausedElapsed;
	bool paused = false;
	Exec@[] execs;
	

	void create()
	{
		reset();
	}
	
	void reset()
	{
		normalElapsed = 0;
		pausedElapsed = 0;
		paused = false;
	}
	
	void update()
	{
		uint frame = GetLastFrameElapsedTime();
		
		normalElapsed += frame;
		if(!paused) pausedElapsed += frame;
		
		checkAndExec();
	}
	
	void checkAndExec()
	{
		for(uint i=0;i<execs.length();i++)
		{	
			if(hasElapsed(execs[i].stmp))
			{
				execs[i].function();
				execs.removeAt(i);
				i--;
			}
		}
	}
	
	bool hasElapsed(TimeStamp stmp)
	{
		uint elapsed = stmp.pause? pausedElapsed : normalElapsed;
		return (elapsed > stmp.start + stmp.stride);
	}
	
	
	void resume()
	{
	
	}
	
	void pauseTimer()
	{
		paused = true;
	}
	
	void resumeTimer()
	{
		paused = false;
	}
	
	void execute(VOID@ exec, uint delay = 0, bool pause = false)
	{
		uint start = pause? pausedElapsed : normalElapsed;
		Exec@ newExec = Exec(exec, start, delay, pause);
		execs.insertLast(newExec);
	}
}

Execute g_execute;

void execute(VOID@ exec, uint delay = 0, bool pause = false)
{
	g_execute.execute(exec, delay, pause);
}

class Exec
{
	TimeStamp stmp;
	VOID@ function;
	Exec(VOID@ f, uint start, uint delay, bool _pause)
	{
		@function = f;
		stmp = TimeStamp(start, delay, _pause);
	}
}

class TimeStamp
{
	uint start;
	uint stride;
	bool pause = false;
	
	TimeStamp(){}
	
	TimeStamp(uint _start, uint _stride, bool _pause = false)
	{
		start = _start;
		stride = _stride;
		pause = _pause;
	}
}

