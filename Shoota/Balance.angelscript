//STRIDES (MS)

const uint STRIDE_ENEMY = 900;
const uint STRIDE_HIT = 70;
const uint TURRET_COOLING = 1500;
const uint STRIDE_HP = 3000;



//TURRETS

const float TURRET_HEAT = 0.02f;
const float TURRET_COOLING_RATIO = 0.25f;
const uint MAX_AUTO_TURRETS = 6;

//ENEMIES
float INIT_ENEMY_RATE = 15;
float LAST_ENEMY_RATE = 40;

float ENEMY_SPEED_RATE = 0.9f;
float ENEMY_DAMAGE_RATE = 0.4f;

float DAMAGE_RATE = 2.0f;
float SPAWN_RATE = 0.6f;

//RUNTIME

bool DEBUG = false;
bool RANK_UP = false;
bool GAME_OVER = false;
bool GAME_SUCCESS = false;
uint EXP = 0;
float FACTOR = 1.0f;