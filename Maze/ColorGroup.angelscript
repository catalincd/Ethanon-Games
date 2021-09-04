class ColorGroup
{
	Color ballCol;
	Color[] group;
	
	ColorGroup(){}	
	
	ColorGroup(Color ball, Color[] gr)
	{
		ballCol = ball;
		group = gr;
	}
}


Color[] blueShades = {cyan, paleBlue, paleViolet};
Color[] greenShades = {paleGreen, paleLemon, paleTurq};
Color[] redShades = {paleRed, paleMagent, red};
Color[] yellowShades = {paleYellow, paleOrange, yellow};
Color[] greyShades = {lightGrey, whiteGrey, white};



ColorGroup redGr    = ColorGroup(red, greenShades);
ColorGroup orangeGr = ColorGroup(orange, blueShades);
ColorGroup greenGr = ColorGroup(green, redShades);
ColorGroup violetGr = ColorGroup(magenta, yellowShades);
ColorGroup greyGr = ColorGroup(darkGrey, greyShades);

ColorGroup[] Groups = {redGr, orangeGr, greenGr, violetGr, greyGr};