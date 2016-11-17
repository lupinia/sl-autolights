// Lupinia Central Automated Light System - Control Panel Button
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script sends a single command to the root control panel script, which assembles and sends those commands to the Central Controller Relay.
// There's no technical reason the buttons can't do this directly, but this method makes setup easier.

key curkey;

default
{
	state_entry()
	{
		// Nothing to do on rez for this one
	}
	
	touch_start(integer total_number)
	{
		curkey = llDetectedKey(0);
		llMessageLinked(LINK_ROOT,540,"AUTO CONTROL",curkey);
		curkey = NULL_KEY;
	}
}