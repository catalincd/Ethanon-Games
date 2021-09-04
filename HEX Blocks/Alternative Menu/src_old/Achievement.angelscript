class Achievement
{
	uint type;
	string name;
	string path;
	uint xp_req;
	bool aq;
	bool new;
	string argument;
	DateTime aq_date;
	
	Achievement(){
		aq = false;
	}
	
	void set(uint t, string n, uint xp, bool a, bool ne, DateTime dt, string p){
		type = t;
		name = n;
		xp_req = xp;
		aq = a;
		aq_date = dt;
		path = p;
		new = ne;
	}
	
	

}