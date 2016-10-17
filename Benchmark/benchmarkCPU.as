#include "base.as"

vector3 center(2000, 0,  2000);

array<vector3> sp_points = {
		vector3(1950, 10, 1950),
		vector3(1950, 10, 2050),
		vector3(2050, 10, 1950),
		vector3(2050, 10, 2050),
		vector3(1950, 10, 1950)
};

vector3 p0,p1,m0,m1;

float t;
vector3 position;
int Length;
int j = 0;
float i = 0;

float ft = 0;
int frames = 0;
int frames_max;
int frames_min = 9999;
float timer = 60;
bool benchmark = true;

bool failed_to_setup = false;

void main()
{
	Length = sp_points.length();
	//45,135,225,315
	SetupVehicle(sp_points[1],vector3(0, 225, 0));
	SetupVehicle(sp_points[2],vector3(0, 45, 0));
	SetupVehicle(sp_points[3],vector3(0, 315, 0));
	SetupVehicle(sp_points[4],vector3(0, 135, 0));

	if(failed_to_setup)
	{
		game.showMessageBox("ERROR","You need the burnside for this map to work!!! Check Angelscript.log for more info.",true,"Ok",false,false,"");
		game.log("You need the burnside for this map to work !!!");
		game.log("Thread link: http://www.rigsofrods.com/threads/56285-Burnside-now-with-correct-wheel-size");
	}
	else
	{
		game.message("benchmark successfully loaded!","note.png", 10000, true);
		game.log("benchmark successfully loaded!");
		game.setTrucksForcedActive(true);
		game.activateAllVehicles();
	}
}

void frameStep(float dt)
{
	if(benchmark && !failed_to_setup)
	{
		game.cameraLookAt(center);
		game.setPersonPosition(center);
		calcPosition(dt);
		ft = ft + dt;
		frames++;
		if(ft > 1)
		{
			game.message(frames+" FPS \nMax "+frames_max+" FPS \nMin "+frames_min+" FPS","note.png", 1000, true);
			if (frames > frames_max)
			{
				frames_max = frames;
			}
			if (frames < frames_min)
			{
				frames_min = frames;
			}
			frames = 0;
			ft = 0;
		}
	}
}

void SetupVehicle(vector3 spawn, vector3 rot)
{
	vector3 tmpsp = vector3(spawn.x, 0, spawn.z);
	BeamClass @truck = game.spawnTruck("burnside.truck" , tmpsp, rot);
	if(truck != null)
	{
		VehicleAIClass @ai = truck.getVehicleAI();
		//game.spawnObject("trucktriggerV2" , "trucktriggerV2", waypoints[i], vector3(0, -90, 0),  "Event1", false);
		game.log("spawnWaypoint"+i);
		ai.addWaypoint("Waypoint",center);
		ai.setActive(true);
	}
	else
	{
		failed_to_setup = true;
	}
}

void calcPosition(float dt)
{
		p0 = sp_points[j];
    p1 = sp_points[j + 1];
    if (j > 0)
    {
        m0.x = 0.5f * (sp_points[j + 1].x - sp_points[j - 1].x);
        m0.y = 0.5f * (sp_points[j + 1].y - sp_points[j - 1].y);
        m0.z = 0.5f * (sp_points[j + 1].z - sp_points[j - 1].z);
    }
    else
    {
        m0.x = sp_points[j + 1].x - sp_points[j].x;
        m0.y = sp_points[j + 1].y - sp_points[j].y;
        m0.z = sp_points[j + 1].z - sp_points[j].z;
    }
    if (j < Length - 2)
    {
        m1.x = 0.5f * (sp_points[j + 2].x - sp_points[j].x);
        m1.y = 0.5f * (sp_points[j + 2].y - sp_points[j].y);
        m1.z = 0.5f * (sp_points[j + 2].z - sp_points[j].z);
    }
    else
    {
        m1.x = sp_points[j + 1].x - sp_points[j].x;
        m1.y = sp_points[j + 1].y - sp_points[j].y;
        m1.z = sp_points[j + 1].z - sp_points[j].z;
    }
    t = i;
    position.x = (2.0f * t * t * t - 3.0f * t * t + 1.0f) * p0.x
        + (t * t * t - 2.0f * t * t + t) * m0.x
            + (-2.0f * t * t * t + 3.0f * t * t) * p1.x
            + (t * t * t - t * t) * m1.x;
    position.y = (2.0f * t * t * t - 3.0f * t * t + 1.0f) * p0.y
        + (t * t * t - 2.0f * t * t + t) * m0.y
            + (-2.0f * t * t * t + 3.0f * t * t) * p1.y
            + (t * t * t - t * t) * m1.y;
    position.z = (2.0f * t * t * t - 3.0f * t * t + 1.0f) * p0.z
        + (t * t * t - 2.0f * t * t + t) * m0.z
            + (-2.0f * t * t * t + 3.0f * t * t) * p1.z
            + (t * t * t - t * t) * m1.z;
    i = i + dt / 5;
    if (i >= 1)
    {
        j++;
        i = 0;
        if (j >= Length - 1)
        {
        	benchmark = false;
					game.message("Results can be found in Angelscript.log","note.png", 1000, true);
        	game.log("Max "+frames_max+" FPS");
        	game.log("Min "+frames_min+" FPS");
          i = 0;
          j = 0;
        }
    }
    game.setCameraPosition(position);
}
