// Lupinia Central Automated Light System - Control Panel Relay
// By Natasha L. (Natasha Petrichor)
// www.lupinia.net | github.com/lupinia
// 
// This script receives input from buttons on the manual control panel, and sends those commands to the Central Controller Relay.
// There's no technical reason the buttons can't do this directly, but this method makes setup easier.

// Change these to something unique to your installation
integer ch_manual = 7035550001;
integer ch_control = 7035550002;
string light_system = "HOME";

default
{
	state_entry()
	{
		// Nothing to do on rez for this one
	}
	
	link_message(integer sender_num,integer num,string msg,key id)
	{
		if(id == llGetOwner() && num == 540)
		{
			llShout(ch_manual, light_system + " LIGHT CONTROL " + msg);
		}
	}
}