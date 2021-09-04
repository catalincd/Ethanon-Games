//		CONSTANTS
const string LOOP = "update";
const string PRELOOP = "create";
const string ONRESUME = "resume";

const float DEFAULT_SCALE_HEIGHT = 720.0f;

const float HIGH_VALUE = 99999.0f;

const vector2 V2_HALF(0.5f, 0.5f);
const vector3 V3_HALF(0.5f, 0.5f, 0.5f);
const vector2 V2_ZERO(0.0f, 0.0f);
const vector3 V3_ZERO(0.0f, 0.0f, 0.0f);
const vector2 V2_ONE(1.0f, 1.0f);
const vector3 V3_ONE(1.0f, 1.0f, 1.0f);

const vector3 V3_GREEN(0.0f, 1.0f, 0.0f);
const vector3 V3_BLUE(0.0f, 0.0f, 1.0f);
const vector3 V3_CYAN(0.0f, 1.0f, 1.0f);
const vector3 V3_YELLOW(1.0f, 1.0f, 0.0f);

const uint COLOR_WHITE  = 0xFFFFFFFF;
const uint COLOR_BLACK  = 0xFF000000;
const uint COLOR_RED    = 0xFFFF0000;
const uint COLOR_GREEN  = 0xFF00FF00;
const uint COLOR_BLUE   = 0xFF0000FF;
const uint COLOR_YELLOW = 0xFFFFFF00;

const float BLOCK_HEIGHT = 64;

bool WINDOWS = false;


const uint MINUTE = 60000; 
const uint SECOND = 1000; 


//		BALANCE


const uint BOOST_RATIO = 7;
const uint BOOST_TIME_MS = 1300;
const uint BOOST_TIME_DELAY_MS = 300;

const uint COIN_RATIO = 3;

const uint BLOCK_EFFECT_RATIO = 5;

const uint EFFECT_RATE = 15000;
const uint SHAKE_RATE = 75000;
const uint SCORE_TO_RAINBOW = 600000;
const float RAINBOW_STRIDE = 500.0f;

const uint ARRAYS_UNTIL_BREAK = 9;

const uint SHAKE_LENGTH_MS = 700;

const float SCORE_OFFSET_UNITS = 512;


//		RUNTIME

uint COINS = 0;
uint BOOST_COINS = 0;
bool NEW_HIGH_SCORE = false;
bool NEW_COLOR_UNLOCKED = false;
bool NEW_OVERLAY_UNLOCKED = false;


//		SAVE
bool TUTORIAL = false;
bool DRAWING_OVERLAYS = false;
bool DRAWING_EYES = false;
bool SHOW_TIPS = true;
bool ENABLE_ADS = true;
bool TOUCH_CONTROLS = false;
bool ENABLE_EFFECTS = true;
uint CURRENT_COLOR = 0;
uint TOTAL_BOOST_COINS = 0;
uint GAMES_PLAYED = 0;
uint CURRENT_OVERLAY = 0;
uint UNLOCKED_COLORS = 0;
uint UNLOCKED_OVERLAYS = 0;
uint CURRENT_SCORE = 0;
uint HIGH_SCORE = 0;
uint CURRENT_SCORE_COUNT = 0;
uint CURRENT_SCORE_AVG = 0;
uint TIME_PLAYED_SECONDS = 0;


