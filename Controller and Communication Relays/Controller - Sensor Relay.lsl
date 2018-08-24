// Lupinia Central Automated Light System - Controller Relay Module
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script handles communication with all lights and other objects (set them to listen on channel specified in ch_control).
// It receives input from manual controls (listening on channel specified in ch_manual) and from the Solar Sensor Module (via link_message).
// Security subroutines can be added, but it's difficult to add them to this relay.  Adding them to the manual control panel is preferred.

// Change these to something unique to your installation
integer ch_manual = 7035550001;
integer ch_control = 7035550002;
string light_system = "HOME";
// Don't change the variables below this line
string lights = "off";
integer manual = 0;

default
{
	state_entry()
	{
		llListen(ch_manual,"", NULL_KEY, "");
	}
	
	listen( integer channel, string name, key id, string message )
	{
		if(llGetOwner() == llGetOwnerKey(id))
		{
			if(message == light_system + " LIGHT CONTROL MANUAL CONTROL")
			{
				manual = 1;
				llMessageLinked(LINK_ALL_CHILDREN,0,"SWITCH TO MANUAL CONTROL",NULL_KEY);
				//llSay(0,"Building lights are now on manual control. Authorized users may toggle them using the controls by the front door.");
			}
			if(message == light_system + " LIGHT CONTROL AUTO CONTROL")
			{
				manual = 0;
				llMessageLinked(LINK_ALL_CHILDREN,0,"SWITCH TO AUTO CONTROL",NULL_KEY);
				//llSay(0,"Building lights are now on an automatic solar sensor.");
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
	
	link_message(integer sender_num, integer num, string msg, key id)
	{
		if(msg == "LIGHT CONTROL AUTO ON" && manual != 1 && lights == "off")
		{
			llRegionSay(ch_control,light_system + " LIGHTS ON");
			lights = "on";
		}
		if(msg == "LIGHT CONTROL AUTO OFF" && manual != 1 && lights == "on")
		{
			llRegionSay(ch_control,light_system + " LIGHTS OFF");
			lights = "off";
		}
	}
}
