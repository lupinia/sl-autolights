// Lupinia Central Automated Light System - Solar Sensor Module
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script periodically checks the position of the estate's sun, and instructs the relay to toggle the lights accordingly.
// To reduce lag, it disables sun position checking if the relay is instructed to switch to manual control.

integer repeat_delay = 300;
vector sun;

integer detect_sun()
{
	sun = llGetSunDirection();
	if(sun.z > -0.01)
	{
		llMessageLinked(LINK_ROOT,0,"LIGHT CONTROL AUTO OFF",NULL_KEY);
	}
	else
	{
		llMessageLinked(LINK_ROOT,0,"LIGHT CONTROL AUTO ON",NULL_KEY);
	}
	return 1;
}

default
{
	state_entry()
	{
		detect_sun();
		llSetTimerEvent(repeat_delay);
		llResetTime();
	}
		
	link_message(integer sender_num, integer num, string msg, key id)
	{
		if(msg == "SWITCH TO MANUAL CONTROL")
		{
			llSetTimerEvent(0);
			llResetTime();
		}
		if(msg == "SWITCH TO AUTO CONTROL")
		{
			detect_sun();
			llSetTimerEvent(repeat_delay);
			llResetTime();
		}
	}
	
	timer()
	{
		detect_sun();
	}
}
