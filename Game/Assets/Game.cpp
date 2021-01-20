#include "veinpch.h"

class Game : public Vein::Application
{
public:
	Game()
	{
		std::cout << "Game" << std::endl;
	}

	~Game()
	{

	}
};

Vein::Application* Vein::CreateApplication()
{
	return new Game();
}