#pragma once

namespace Vein
{
	class Application
	{
	public:
		Application();
		~Application();

		static Application* Instance;
	};

	Application* CreateApplication();
}