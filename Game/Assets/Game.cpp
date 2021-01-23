#ifndef _WIN64
#pragma comment(linker, "/include:_wWinMain@16")
#else
#pragma comment(linker, "/include:wWinMain")
#endif
#include "veinpch.h"

class Game : public Vein::Application
{
public:
	Game()
	{
		
	}

	~Game()
	{

	}
};

Vein::Application* Vein::CreateApplication()
{
	return new Game();
}