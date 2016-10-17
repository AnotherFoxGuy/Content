#include "base.as"

float wait_timer = 1f;
bool wait_for_event;

string message_box_title = "Rigs of Rods tutorial";

int next_event = SE_GENERIC_MESSAGEBOX_CLICK;

array<string> tutorial_script = {
"Welkom to the tutorial for Rigs of Rods",
"You are this dude. We kindly call him mr.rorbot.",
"His Controls Are:\nup = forward | down = backward\nright = turns right | left = turn left\nspacebar = jump",
"You can also use arrows\nup = forward | down = backward\nright = turns right | left = turn left",
"You can use right click + mouse to rotate and mousewheel to zoom out or in",
"You can also control camera by using numpad\n8 = camera up | 2 = camera down\n4 = camera right | 6 = camera left\n5 = center camera",
"You can change field of view with: 7 = less fov ctrl + 7 = more fov",
"MOVE_RORBOT",
"this is a truckshop, run into the open door to open the vehicle selector menu",
"NEW_TRUCK",
"You can drive by using arrows keys\nto start a car use X for battery and S for ignition",
"gear mode layout is like this\nr = rear gear\nn = neutral\nd = drive < default one\n1 = first gear\n2 = second gear\nyou can use pageup/pagedown to switch between",
"additional controls:\ni = to respawn vehicle\nbackspace = to reset vehicle\nt = statistic and vehicle infos\nl = attach load (on wreckers or cranes)\no = secure load (same as above)",
"n = headlights\nm = beacons (on vehicles having beacons)\nh = horn\nq = transmission mode\na = shift up gear\nz = shift down gear\nc = change camera view",
"r = rescue truck (on maps having it)\np = parking brake\nctrl + 1-9 (not numpad) = additional lights\nf1-f12 - additional controls (ex. cranes)\nctrl + f1-f12 = additional controls (ex. cranes)\nalt + f1-f12 = additional controls (ex. cranes)",
"Exit the truck when you are ready",
"TRUCK_EXIT",
"MOVE_RORBOT",
"this is a generic load spawner\nstand on the small plate to bring up the menu",
"NEW_TRUCK",
"hangar",
"MOVE_RORBOT",
"here you can spawn aeroplanes and helicopters\njust walk into the open door to bring the menu",
"NEW_TRUCK",
"you can use both mouse interaction with hud or keyboard.",
"keyboard controls:\nctrl + home = turn on all engines\npageup/pagedown = throttle (+ctrl = instant max/min throttle)\nm = position lights\np = brake\narrows = pitching & rolling\nz/x = yaw",
"Exit the plane when you are ready",
"TRUCK_EXIT",
};
int current_message_id;

array<vector3> tutorial_places = {
		vector3(2698, 0, 538),
		vector3(2348, 0, 2119),
		vector3(1124, 0, 623)
};
int current_place_id;

void main()
{
	game.registerForEvent(SE_TRUCK_ENTER);
	game.registerForEvent(SE_TRUCK_EXIT);
	game.registerForEvent(SE_GENERIC_MESSAGEBOX_CLICK);
	game.registerForEvent(SE_GENERIC_NEW_TRUCK);
	game.registerForEvent(SE_TRUCK_LOCKED);
}

void frameStep(float dt)
{
	if(!wait_for_event) wait_timer -= dt;

	if(wait_timer < 0)
	{
		string tmp = tutorial_script[current_message_id];
		print("~~~~~~~~~~~~~~~~~~~ "+current_message_id+" ~~~~~~~~~~~~~~~~~~~");
		print(tmp);
		if(tmp == "ENTER_TRUCK")
		{
			next_event = SE_TRUCK_ENTER;
			wait_for_event = true;
		}
		else if(tmp == "TRUCK_EXIT")
		{
			next_event = SE_TRUCK_EXIT;
			wait_for_event = true;
		}
		else if(tmp == "NEW_TRUCK")
		{
			next_event = SE_GENERIC_NEW_TRUCK;
			wait_for_event = true;
		}
		else if(tmp == "TRUCK_LOCKED")
		{
			next_event = SE_TRUCK_LOCKED;
			wait_for_event = true;
		}
		else if(tmp == "MOVE_RORBOT")
		{
			game.setPersonPosition(tutorial_places[current_place_id]);
			game.setPersonRotation(radian(5.5));
			current_place_id++;
		}
		else if(tmp == "PREPARE_FOR_BOATS")
		{
			game.setPersonPosition(tutorial_places[current_place_id]);
			game.setPersonRotation(radian(5.5));
			current_place_id++;
		}
		else
		{
			next_event = SE_GENERIC_MESSAGEBOX_CLICK;
			wait_for_event = true;
			game.showMessageBox(message_box_title,tmp,true,"Ok",true,false,"");
		}

		wait_timer = 1;
		current_message_id++;
	}
}

void eventCallback(int trigger_type, int nodeid)
{
	if(trigger_type == next_event)
	{
		wait_for_event = false;
	}
}
