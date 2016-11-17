// Lupinia Central Automated Light System - Control Panel Cover
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script simply puts a cover over the control panel.  It can be re-purposed for almost anything, but it's useful in this case.

string status = "closed";
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
		if(curkey == llGetOwner())
		{
			if(status=="closed")
			{
				llSetPos(llGetLocalPos()+<0,0.2,0>);  // Open the door
				status = "open";
			}
			else if(status=="open")
			{
				llSetPos(llGetLocalPos()+<0,-0.2,0>);  // Open the door
				status = "closed";
			}
		}
		else
		{
			// Do nothing if this is an unauthorized touch
		}
		curkey=NULL_KEY;
	}
}