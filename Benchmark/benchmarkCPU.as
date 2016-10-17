#include "base.as"


int s = 0;
bool works = true;

vector3 main_pos(2000, 0,  2000);

vector3 pos_stop1(1950, 10, 1950);
vector3 pos_stop2(1950, 10, 2050);
vector3 pos_stop3(2050, 10, 1950);
vector3 pos_stop4(2050, 10, 2050);
vector3 pos_stop5(1950, 10, 1950);

array<vector3> sp_points;
vector3 p0;
vector3 p1;
vector3 m0;
vector3 m1;

float t;
vector3 position;
int Length;
int j = 0;
float i = 0;

float ft = 0;
int frames = 0;
int frames_max;
int frames_min = 9999;
float timer = 30;
bool benchmark = true;
array<int> frame;

void main()
{
	spawnWaypoint( pos_stop1);
	spawnWaypoint( pos_stop2);
	spawnWaypoint( pos_stop3);
	spawnWaypoint( pos_stop4);
	spawnWaypoint( pos_stop5);
	Length = sp_points.length();
}

void frameStep(float dt)
{ 
	if(benchmark)
	{
		BeamClass @bm_truck0 = game.getTruckByNum(0);
		BeamClass @bm_truck1 = game.getTruckByNum(1);
		BeamClass @bm_truck2 = game.getTruckByNum(2);
		BeamClass @bm_truck3 = game.getTruckByNum(3);
		if(s == 0)
		{
			s++;
			game.setTrucksForcedActive(true);
			game.activateAllVehicles();
			if(bm_truck3 == null)
			{
				game.message("You need the burnside for this map to work!!! Check Angelscript.log for more info.","note.png", 100000, true);
				game.log("You need the burnside for this map to work !!!");
				game.log("Thread link: http://www.rigsofrods.com/threads/56285-Burnside-now-with-correct-wheel-size");
				works = false;
			}
			else
			{
				game.message("benchmark successfully loaded!","note.png", 10000, true);
				game.log("benchmark successfully loaded!");
			}		
		}
		if (works)
		{
			if(bm_truck0.navigateTo(pos_stop3))
			{

			}
			if(bm_truck1.navigateTo(pos_stop4))
			{

			}
			if(bm_truck2.navigateTo(pos_stop1))
			{

			}
			if(bm_truck3.navigateTo(pos_stop2))
			{

			}
			/*

			if(bm_truck0.navigateTo(bm_truck2.getVehiclePosition()))
			{

			}
			if(bm_truck1.navigateTo(bm_truck3.getVehiclePosition()))
			{

			}
			if(bm_truck2.navigateTo(bm_truck0.getVehiclePosition()))
			{

			}
			if(bm_truck3.navigateTo(bm_truck1.getVehiclePosition()))
			{

			}
			*/
			game.cameraLookAt(main_pos);
			game.setPersonPosition(main_pos);
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
}
 
void spawnWaypoint(vector3 pos)
{
	sp_points.insertLast(pos);
	//game.spawnObject("trucktriggerV2", "trucktriggerV2", pos, vector3(0, -90, 0),  "Event1", false);
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