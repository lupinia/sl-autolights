// Lupinia Central Automated Light System - Invisible Light Bulb
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script controls the actual lighting element of a light fixture (or several).
// This version of it does not toggle fullbright or glow; useful for augmenting existing fixtures, or for invisible light sources.
// Features:
//   Point Light - Configured using standard build commands (see instructions).
// 
// SETUP INSTRUCTIONS
// 1.  Create your light fixture(s) as desired, and link all the prims together.
// 2.  Make sure the light system is in "LIGHTS ON" mode.
// 3.  Drop the "Light - Control Receiver" script into the root of the object.
// 4.  Select only the "bulb" prim of the fixture(s). 
// 5.  Go to the Features tab of the Edit tools, and check the Light checkbox.
// 6.  Configure the light as desired (color, intensity, radius, falloff, etc).
// 7.  Drop this script into the bulb prim.
// 8.  If there are multiple fixtures sharing the same root prim, repeat steps 4-7 for each lightbulb.
// 9.  Cycle the light system off and back on.  The light(s) should come back on exactly as configured in step 6.
//
// LIGHT ADJUSTMENT INSTRUCTIONS
// 1.  Make sure the light system is in "LIGHTS ON" mode.
// 2.  Select only the "bulb" prim of the fixture(s).
// 3.  Go to the Features tab of the Edit tools, and adjust the light parameters as desired.
// 4.  Reset this script.
// 5.  Repeat steps 2-4 for each lightbulb in this object that you want to adjust.
// 6.  Cycle the light system off and back on.  The light(s) should come back on exactly as configured in step 3.

// Don't change the variables below this line
list light_settings;
list light_list;

integer light_toggle(string offOn)
{
	if(offOn == "on")
	{
		light_list = [PRIM_POINT_LIGHT,TRUE] + light_settings;
		llSetPrimitiveParams(light_list);
	}
	if(offOn == "off")
	{
		light_list = [PRIM_POINT_LIGHT,FALSE] + light_settings;
		llSetPrimitiveParams(light_list);
	}
	return 1;
}

default
{
	state_entry()
	{
		light_settings = llGetPrimitiveParams([PRIM_POINT_LIGHT]);
		light_settings = llDeleteSubList(light_settings,0,0);
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
