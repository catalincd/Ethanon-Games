interface Turret
{
	
	
	//void spawn(vector2 pos, string turret, string body, vector3 color);
	bool isDead();
	
	void setId(uint t);
	
	uint getId();
	
	void update();
	
	void shoot(vector2 target);

	void restorePosition();
	
	vector2 getPosition();
	
	void updateBodyColor();
	
	void decId();
	
}