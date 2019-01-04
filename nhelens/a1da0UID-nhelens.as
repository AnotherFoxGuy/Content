#include "base.as"
#include "races.as"

racesManager races();

void main()
{
	races.showCheckPointInfoWhenNotInRace = true;
	array<array<double>> coordinates = 
		{
			{1145.762451, 43.409168,  1874.828247, 0.000000, -20.000000, 0.000000},
			{1223.362061, 66.093338,  2128.568359, 0.000000, 30.000000,  0.000000},
			{1493.947388, 90.977753,  2490.836426, 0.000000, 55.000000,  0.000000},
			{1854.234497, 141.551270, 2732.894287, 0.000000, 65.000000,  0.000000},
			{2157.161865, 130.438171, 2720.815430, 0.000000, 90.000000,  0.000000},
			{2422.710693, 110.228294, 2523.404785, 0.000000, 140.000000, 0.000000},
			{2607.359619, 107.782913, 2203.569824, 0.000000, 165.000000, 0.000000},
			{2534.100342, 107.596176, 1938.718140, 0.000000, 205.000000, 0.000000},
			{2269.411377, 134.870911, 1729.099121, 0.000000, 265.000000, 0.000000},
			{1974.688110, 104.931290, 1732.083618, 0.000000, 245.000000, 0.000000},
			{1865.982056, 101.138504, 1618.693237, 0.000000, 245.000000, 0.000000},
			{1706.379395, 148.594437, 1533.436157, 0.000000, 255.000000, 0.000000},
			{1470.152100, 120.901085, 1504.998291, 0.000000, 310.000000, 0.000000},
			{1238.410767, 47.336208,  1735.698242, 0.000000, 325.000000, 0.000000}
		};
	races.addRace("Rigbreaker", coordinates, races.LAPS_One);
}
