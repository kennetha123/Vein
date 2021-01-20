workspace "VeinEngine"
	location ".."
	architecture "x64"
	startproject "Game"
	
	configurations
	{
		"Debug",
		"Develop",
		"Release"
	}

trunk = "../"

-- struct to easier include dir rather than using path
IncludeDir = {}
IncludeDir["ImGui"] 	= 	(trunk .. "Externals/imgui")
--IncludeDir["glm"] 		= 	(trunk .. "Externals/glm")
IncludeDir["stb_image"] = 	(trunk .. "Externals/stb_image")
IncludeDir["spdlog"] 	= 	(trunk .. "Externals/spdlog/include")


-- output name for bin / obj
outputName = "%{cfg.system}/%{cfg.buildcfg}/%{cfg.architecture}"

-- take another premake to build the project
include (trunk .. "Externals/imgui/project")

-------------------------------------------------------------------------------------
------------------------ Engine project ---------------------------------------------	
-------------------------------------------------------------------------------------

project "Vein"
	location (trunk .. "Engine")
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	
	targetdir ("%{prj.name}/bin/" .. outputName)
	objdir ("%{prj.name}/obj/" .. outputName)

	-- use precompile header
	pchheader "veinpch.h"
	pchsource (trunk .. "Engine/Source/veinpch.cpp")
	
	files
	{
		(trunk .. "Engine/Source/**.h"),
		(trunk .. "Engine/Source/**.cpp"),
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	
	includedirs
	{
		(trunk .. "Engine/Source"),
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.stb_image}",
		"%{IncludeDir.spdlog}"
	}
	
	links
	{
		"ImGui",
	}
	
	filter "system:windows"
		systemversion "latest"
		
		-- preprocessor definition
	defines
	{
		
	}
	
	filter "configurations:Debug"
		defines "VE_DEBUG"
		runtime "Debug"
		symbols "on"
	
	filter "configurations:Develop"
		defines "VE_DEV"
		runtime "Release"
		optimize "on"	

	filter "configurations:Release"
		defines "VE_RELEASE"
		runtime "Release"
		optimize "on"
	
-------------------------------------------------------------------------------------
------------------------ Game project -----------------------------------------------		
-------------------------------------------------------------------------------------

	
project "Game"
	kind "ConsoleApp"
	location (trunk .. "Game")
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("%{prj.name}/bin/" .. outputName)
	objdir ("%{prj.name}/obj/" .. outputName)

	files
	{
		(trunk .. "%{prj.name}/Assets/**.h"),
		(trunk .. "%{prj.name}/Assets/**.cpp")	
	}
	
	-- including all External libs + Engine
	includedirs
	{
		(trunk .. "Engine/Source"),
		"%{IncludeDir.spdlog}",
		"%{IncludeDir.glm}"
	}
	
	links
	{
		"Vein",
	}

	filter "configurations:Debug"
		defines "VE_DEBUG"
		runtime "Debug"
		symbols "on"
	
	filter "configurations:Develop"
		defines "VE_DEV"
		runtime "Release"
		optimize "on"	

	filter "configurations:Release"
		defines "VE_RELEASE"
		runtime "Release"
		optimize "on"
