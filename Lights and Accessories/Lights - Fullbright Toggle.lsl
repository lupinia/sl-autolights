// Lupinia Central Automated Light System - Fullbright Toggle
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script sets a prim to fullbright when the lights are switched on.

// Set the target face(s) here.  Default is ALL_SIDES.
integer faces = ALL_SIDES;

integer light_toggle(string offOn)
{
	if(offOn == "on")
	{
		llSetPrimitiveParams([PRIM_FULLBRIGHT,faces,TRUE]);
	}
	if(offOn == "off")
	{
		llSetPrimitiveParams([PRIM_FULLBRIGHT,faces,FALSE]);
	}
	return 1;
}

default
{
	state_entry()
	{
		// Nothing to do on rez for this script.
	}
	
	link_message(integer sender_num, integer num, string message, key id)
	{
		if(message == "LIGHTS ON")
		{
			light_toggle("on");
		}
		if(message == "LIGHTS OFF")
		{
			light_toggle("off");
		}
	}
}
