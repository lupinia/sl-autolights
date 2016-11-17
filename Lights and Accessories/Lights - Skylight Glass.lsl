// Lupinia Central Automated Light System - Skylight Glass
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This is a modified version of the Window Glass script, used to give the same effect to skylights.
// When the lights are switched on, it adds a subtle glow to the outward-facing side, like the window glass.
// However, when the lights are switched off, it moves the glow to the inward-facing side, to simulate the glow of sunlight.
// A single prim can span multiple skylights within the same flat roof, as long as the glass is thinner than the roof.

// Set the inward face here.  Default is 5.
integer face_inside = 5;

integer light_toggle(string offOn)
{
	if(offOn == "on")
	{
		llSetPrimitiveParams([PRIM_GLOW,ALL_SIDES,0.1]);
		llSetPrimitiveParams([PRIM_GLOW,face_inside,0]);
	}
	if(offOn == "off")
	{
		llSetPrimitiveParams([PRIM_GLOW,ALL_SIDES,0]);
		llSetPrimitiveParams([PRIM_GLOW,face_inside,0.1]);
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
