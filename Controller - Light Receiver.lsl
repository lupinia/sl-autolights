// Lupinia Central Automated Light System - Control Receiver
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script reduces sim lag by allowing multiple lights to share a single listener.
// It receives input from the central controller relay via the channel specified in ch_control.
// It then relays any commands to all child prims via a link_message.
// All lights must contain this script in their root prims.

// Change these to something unique to your installation
integer ch_manual = 7035550001;
integer ch_control = 7035550002;
string light_system = "HOME";

default
{
	state_entry()
	{
		llListen(ch_control,"",NULL_KEY,"");
	}
	
	listen( integer channel, string name, key id, string message )
	{
		if(llGetOwner() == llGetOwnerKey(id))
		{
			if(message == light_system + " LIGHTS ON")
			{
				llMessageLinked(LINK_SET,0,"LIGHTS ON",NULL_KEY);
			}
			if(message == light_system + " LIGHTS OFF")
			{
				llMessageLinked(LINK_SET,0,"LIGHTS OFF",NULL_KEY);
			}
		}
	}
}
