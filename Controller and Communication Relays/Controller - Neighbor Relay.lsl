// Lupinia Central Automated Light System - Sub-Controller Relay Module
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script handles communication with all lights and other objects (set them to listen on channel specified in ch_control).
// It receives input from manual controls (listening on channel specified in ch_manual) and from another Controller Relay Module (listening on channel specified in ch_parent).
// Security subroutines can be added, but it's difficult to add them to this relay.  Adding them to the manual control panel is preferred.

// Change these to something unique to your installation
integer ch_manual = 2025550001;
integer ch_control = 2025550002;
integer ch_parent = 7035550002;
string light_system = "NEIGHBOR";
string parent_system = "HOME";
// Don't change the variables below this line
string lights = "off";
integer manual = 0;
integer parent_listen;

default
{
	state_entry()
	{
		llListen(ch_manual,"", NULL_KEY, "");
		parent_listen = llListen(ch_parent,"", NULL_KEY, "");
	}
	
	listen( integer channel, string name, key id, string message )
	{
		if(channel == ch_parent)
		{
			if(manual != 1 && lights == "off" && message == parent_system + " LIGHTS ON")
			{
				llRegionSay(ch_control,light_system + " LIGHTS ON");
				lights = "on";
			}
			if(manual != 1 && lights == "on" && message == parent_system + " LIGHTS OFF")
			{
				llRegionSay(ch_control,light_system + " LIGHTS OFF");
				lights = "off";
			}
		}
		if(llGetOwner() == llGetOwnerKey(id))
		{
			if(message == light_system + " LIGHT CONTROL MANUAL CONTROL")
			{
				manual = 1;
				llListenControl(parent_listen, FALSE);
			}
			if(message == light_system + " LIGHT CONTROL AUTO CONTROL")
			{
				manual = 0;
				llListenControl(parent_listen, TRUE);
			}
			
			if(message == light_system + " LIGHT CONTROL MANUAL ON" && manual == 1 && lights == "off")
			{
				llRegionSay(ch_control,light_system + " LIGHTS ON");
				lights = "on";
			}
			if(message == light_system + " LIGHT CONTROL MANUAL OFF" && manual == 1 && lights == "on")
			{
				llRegionSay(ch_control,light_system + " LIGHTS OFF");
				lights = "off";
			}
		}
	}
}
