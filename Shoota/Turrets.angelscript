Item@ empty = Item(0, 0, 0, "items/sprites/block_fill.png");


Item@ turret1 = Item(1, 0, 0, "items/sprites/turret1_spr.png");
Item@ turret2 = Item(2, 0, 1000, "items/sprites/turret2_spr.png");
Item@ turret3 = Item(3, 0, 3000, "items/sprites/turret3_spr.png");
Item@ turret4 = Item(4, 0, 7500, "items/sprites/turret4_spr.png");
Item@ turret5 = Item(5, 0, 12500, "items/sprites/turret5_spr.png");

Item@ auto_turret1 = Item(6, 10, 0, "items/sprites/auto_turret1_spr.png");
Item@ auto_turret2 = Item(7, 20, 750, "items/sprites/auto_turret2_spr.png");
Item@ auto_turret3 = Item(8, 40, 1500, "items/sprites/auto_turret3_spr.png");
Item@ auto_turret4 = Item(9, 50, 2500, "items/sprites/auto_turret4_spr.png");
Item@ auto_turret5 = Item(10, 80, 5000, "items/sprites/auto_turret5_spr.png");
Item@ auto_turret6 = Item(11, 100, 10000, "items/sprites/auto_turret6_spr.png");
Item@ auto_turret7 = Item(12, 60, 3500, "items/sprites/auto_turret7_spr.png");



Item@ defensive1 = Item(13, 8, 300, "items/sprites/defensive1_spr.png");
Item@ defensive2 = Item(14, 12, 750, "items/sprites/defensive2_spr.png");
Item@ defensive3 = Item(15, 15, 1500, "items/sprites/defensive3_spr.png");




uint itemNum = 3;


Item@ getItem(uint id)
{
	
	if(id==1) return turret1;
	if(id==2) return turret2;
	if(id==3) return turret3;
	if(id==4) return turret4;
	if(id==5) return turret5;


	if(id==6) return auto_turret1;
	if(id==7) return auto_turret2;
	if(id==8) return auto_turret3;
	if(id==9) return auto_turret4;
	if(id==10) return auto_turret5;
	if(id==11) return auto_turret6;
	if(id==12) return auto_turret7;
	if(id==13) return defensive1;
	if(id==14) return defensive2;
	if(id==15) return defensive3;

	return auto_turret1;

}

bool isMainTurret(uint id)
{
	return id < 6;
}




Turret@ getTurret(uint id, vector2 pos)
{
	
	if(id==1) return addTurret1(pos);
	if(id==2) return addTurret2(pos);
	if(id==3) return addTurret3(pos);
	if(id==4) return addTurret4(pos);
	if(id==5) return addTurret5(pos);


	if(id==6) return addAutoTurret1(pos);
	if(id==7) return addAutoTurret2(pos);
	if(id==8) return addAutoTurret3(pos);
	if(id==9) return addAutoTurret4(pos);
	if(id==10) return addAutoTurret5(pos);
	if(id==11) return addAutoTurret6(pos);
	if(id==12) return addAutoTurret7(pos);
	if(id==13) return addDefensive1(pos);
	if(id==14) return addDefensive2(pos);
	if(id==15) return addDefensive3(pos);
	
	return addAutoTurret1(pos);
}


uint getDamage(Item@ itm)
{
	uint id = itm.id;
	return getDamage(id);
}

uint getDamage(uint id)
{
	if(id == 1) return 7;
	if(id == 2) return 10;
	if(id == 3) return 15;
	if(id == 4) return 22;
	if(id == 5) return 30;
	
	if(id == 6) return 3;
	if(id == 7) return 5;
	if(id == 8) return 10;
	if(id == 9) return 15;
	if(id == 10) return 35;
	if(id == 11) return 50;
	if(id == 12) return 15;
	return 0;
}

uint getAutoDamage(uint id)
{
	return getDamage(id+5);
}

uint getFireRate(Item@ itm)
{
	uint id = itm.id;
	if(id == 6) return 120;
	if(id == 7) return 120;
	if(id == 8) return 120;
	if(id == 9) return 120;
	if(id == 10) return 60;
	if(id == 11) return 60;
	if(id == 12) return 180;
	if(id == 13) return 0;
	if(id == 14) return 0;
	if(id == 15) return 0;
	return 0;
}

uint getHP(Item@ itm)
{
	uint id = itm.id;
	return getHP(id);
}

uint getHP(uint id)
{
	if(id == 1) return 1000;
	if(id == 2) return 1500;
	if(id == 3) return 2000;
	if(id == 4) return 2500;
	if(id == 5) return 3000;
	
	if(id == 6) return 150;
	if(id == 7) return 200;
	if(id == 8) return 300;
	if(id == 9) return 450;
	if(id == 10) return 600;
	if(id == 11) return 800;
	if(id == 12) return 450;
	if(id == 13) return 1000;
	if(id == 14) return 1500;
	if(id == 15) return 5000;
	return 0;
}

uint getAutoHP(uint id)
{
	return getHP(id+5);
}




SimpleTurret addTurret1(vector2 pos){	SimpleTurret tr;tr.spawn(pos, 1000, getDamage(1), "turret1.ent", "body1.ent", V3_ONE);return tr;}
SimpleTurret addTurret2(vector2 pos){	SimpleTurret tr;tr.spawn(pos, 1500, getDamage(2), "turret2.ent", "body2.ent", V3_ONE);return tr;}
SimpleTurret addTurret3(vector2 pos){	SimpleTurret tr;tr.spawn(pos, 2000, getDamage(3), "turret3.ent", "body3.ent", V3_ONE, 7);return tr;}
SimpleTurret addTurret4(vector2 pos){	SimpleTurret tr;tr.spawn(pos, 2500, getDamage(4), "turret4.ent", "body4.ent", V3_ONE, 7);return tr;}
SimpleTurret addTurret5(vector2 pos){	SimpleTurret tr;tr.spawn(pos, 3000, getDamage(5), "turret5.ent", "body5.ent", V3_ONE, 8);return tr;}

DefensiveTurret addDefensive1(vector2 pos){	DefensiveTurret tr;tr.spawn(pos, 1500, "defensive1.ent");return tr;}
DefensiveTurret addDefensive2(vector2 pos){	DefensiveTurret tr;tr.spawn(pos, 2500, "defensive2.ent");return tr;}
DefensiveTurret addDefensive3(vector2 pos){	DefensiveTurret tr;tr.spawn(pos, 5000, "defensive3.ent");return tr;}


AutoTurret addAutoTurret1(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(1), getAutoDamage(1), "auto_turret1.ent", "auto_body1.ent", PX_512,V3_ONE);return tr;}
AutoTurret addAutoTurret2(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(2), getAutoDamage(2), "auto_turret2.ent", "auto_body2.ent", PX_512,V3_ONE);return tr;}
AutoTurret addAutoTurret3(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(3), getAutoDamage(3), "auto_turret3.ent", "auto_body3.ent", PX_768,V3_ONE, 0.6f, 3);return tr;}
AutoTurret addAutoTurret4(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(4), getAutoDamage(4), "auto_turret4.ent", "auto_body4.ent", PX_768,V3_ONE, 0.6f, 3);return tr;}
AutoTurret addAutoTurret5(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(5), getAutoDamage(5), "auto_turret5.ent", "auto_body5.ent", PX_1024,V3_ONE, 2.0f, 4,1000);return tr;}
AutoTurret addAutoTurret6(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(6), getAutoDamage(6), "auto_turret6.ent", "auto_body6.ent", PX_1024,V3_ONE, 2.0f, 4,1000);return tr;}
AutoTurret addAutoTurret7(vector2 pos){ AutoTurret tr;tr.spawn(pos, getAutoHP(7), getAutoDamage(7), "auto_turret7.ent", "auto_body7.ent", PX_768,V3_ONE, 0.8f, 3,330);return tr;}