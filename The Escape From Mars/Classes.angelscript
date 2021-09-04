void DrawFadingTextUpping(vector2 pos, string text, string font, uint color, int stime){

}

int allsoundsi;
string[] allsounds;
float ultimaincetinire=1;
float timpdeincetinire1=0;
float timpdeincetinire2=0;
bool deincetinit=false;
void Incetineste(float value)
{
ultimaincetinire=value;
for (uint t = 0; t < allsounds.length(); t++)
{
SetSampleSpeed(allsounds[t], value);
}
allPositionsAdderValue=value;
SetTimeStepScale(GetTimeStepScale()*value);
}