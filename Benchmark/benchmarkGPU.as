#include "base.as"
int s = 0;
bool works = true;
bool first_frame = false;

vector3 center(50, 0, 2000);

array<vector3> sp_points = {
  vector3(2500, 20, 2500),
  vector3(2550, 50, 2600),//panstart
  vector3(2600, 50, 2550),//panstop
  vector3(2500, 20, 2500)
};

array<vector3> sp_points_lookat = {
  vector3(2400, 15, 2400),
  vector3(2450, 40, 2400),//panstart
  vector3(2400, 40, 2450),//panstop
  vector3(2400, 15, 2400)
};

vector3 p0,p1,m0,m1;

float t;
vector3 position;
int Length;
int j, n;
float i, m;

float ft = 0;
float average_fps;
int times_measured;
float frames_max;
float frames_min = 9999;
float timer = 30;
bool benchmark = true;

void start_b()
{
  Length = sp_points.length();
  int spawns = 0;
  for( int x = 1500; x < 2500; x+=25 )
  {
    for( int z = 1500; z < 2500; z+=25 )
    {
      spawns++;
      game.spawnObject("Eds_Tree1" , "Eds_Tree1",vector3(x,0,z), vector3(0, -90, 0),  "", false);
    }
  }
  game.log("Objects spawned: " + spawns);
}

void frameStep(float dt)
{
  if(!first_frame)
  {
    first_frame = true;
    start_b();
  }

  if(benchmark)
  {
    //game.cameraLookAt(center);
    game.setPersonPosition(center);
    calcCamPos(dt);
    calcLookAtPos(dt);
    ft += dt;
    if(ft > 0.5)
    {
      float frames = game.getFPS();
      average_fps += frames;
      times_measured++;
      game.message(frames+" FPS \nMax "+frames_max+" FPS \nMin "+frames_min+" FPS","note.png", 1000, true);
    if (frames > frames_max)
    {
      frames_max = frames;
    }
    if (frames < frames_min)
    {
      frames_min = frames;
    }
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
  float av = average_fps / times_measured;
  game.showMessageBox("Results","Max FPS: "+frames_max+"\nMin FPS: "+frames_min+"\nAverage FPS: "+av,true,"Ok",false,false,"");
  game.log("Max FPS: " + frames_max);
  game.log("Min FPS: " + frames_min);
  game.log("Average FPS: " + av);
}
