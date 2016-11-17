// Lupinia Central Automated Light System - Window Glass
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script adds a subtle glow to the outward-facing side of a prim when the lights are switched on, to simulate the windows of a well-lit building.
// A single prim can span multiple windows within the same flat wall, as long as the glass is thinner than the wall.
// This script can be used with any window that doesn't already have glass in its frame.

// Set the target face here.  Default is 2.
integer faces = 2;

integer light_toggle(string offOn)
{
	if(offOn == "on")
	{
		llSetPrimitiveParams([PRIM_GLOW,faces,0.1]);
	}
	if(offOn == "off")
	{
		llSetPrimitiveParams([PRIM_GLOW,faces,0]);
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
