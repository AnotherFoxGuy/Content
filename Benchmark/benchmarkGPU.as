#include "base.as"
int s = 0;
bool works = true;

vector3 center(2000, 0,  2000);

array<vector3> sp_points = {
		vector3(1950, 20, 1950),
		vector3(1950, 20, 2050),
		vector3(2050, 20, 2050),
		vector3(2050, 20, 1950),
		vector3(1950, 20, 1950)
};

array<vector3> sp_points_lookat = {
		vector3(1950, 15, 1960),
		vector3(1960, 20, 2050),
		vector3(2050, 15, 2040),
		vector3(2040, 18, 1950),
		vector3(1950, 15, 1960)
};

vector3 p0,p1,m0,m1;

float t;
vector3 position;
int Length;
int j, n;
float i, m;

float ft = 0;
int frames = 0;
array<int> frame;
int frames_max;
int frames_min = 9999;
float timer = 30;
bool benchmark = true;

void main()
{
	Length = sp_points.length();

	for( int x = 1500; x < 2500; x+=25 )
	{
		for( int z = 1500; z < 2500; z+=25 )
		{
			game.spawnObject("Eds_Tree1" , "Eds_Tree1",vector3(x,0,z), vector3(0, -90, 0),  "e", false);
		}
	}
}

void frameStep(float dt)
{
	if(benchmark)
	{
		//game.cameraLookAt(center);
		game.setPersonPosition(center);
		calcCamPos(dt);
		calcLookAtPos(dt);
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
			frame.insertLast(frames);
			frames = 0;
			ft = 0;
		}
	}

}

void calcCamPos(float dt)
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
        	results();
        }
    }
    game.setCameraPosition(position);
}

void calcLookAtPos(float dt)
{
		p0 = sp_points_lookat[n];
    p1 = sp_points_lookat[n + 1];
    if (n > 0)
    {
        m0.x = 0.5f * (sp_points_lookat[n + 1].x - sp_points_lookat[n - 1].x);
        m0.y = 0.5f * (sp_points_lookat[n + 1].y - sp_points_lookat[n - 1].y);
        m0.z = 0.5f * (sp_points_lookat[n + 1].z - sp_points_lookat[n - 1].z);
    }
    else
    {
        m0.x = sp_points_lookat[n + 1].x - sp_points_lookat[n].x;
        m0.y = sp_points_lookat[n + 1].y - sp_points_lookat[n].y;
        m0.z = sp_points_lookat[n + 1].z - sp_points_lookat[n].z;
    }
    if (n < Length - 2)
    {
        m1.x = 0.5f * (sp_points_lookat[n + 2].x - sp_points_lookat[n].x);
        m1.y = 0.5f * (sp_points_lookat[n + 2].y - sp_points_lookat[n].y);
        m1.z = 0.5f * (sp_points_lookat[n + 2].z - sp_points_lookat[n].z);
    }
    else
    {
        m1.x = sp_points_lookat[n + 1].x - sp_points_lookat[n].x;
        m1.y = sp_points_lookat[n + 1].y - sp_points_lookat[n].y;
        m1.z = sp_points_lookat[n + 1].z - sp_points_lookat[n].z;
    }
    t = m;
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
    m = m + dt / 5;
    if (m >= 1)
    {
        n++;
        m = 0;
        if (n >= Length - 1)
        {
        	results();
        }
    }
    game.cameraLookAt(position);
}

void results()
{
	benchmark = false;
	m = 0; n = 0; i = 0; j = 0;
	game.showMessageBox("Results","Max FPS:"+frames_max+"\nMin FPS:"+frames_min,true,"Ok",false,false,"");
	game.log("Max "+frames_max+" FPS");
	game.log("Min "+frames_min+" FPS");
}
