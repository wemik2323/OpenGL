include ".conan/conandeps.premake5.lua"

workspace "OpenGL tutorial"
    configurations { "Debug", "Release" }
    architecture "x64"

    project "OGL"
        kind "WindowedApp"
        -- kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"

        targetdir "build/%{cfg.buildcfg}/bin"
        objdir "build/%{cfg.buildcfg}/obj"

        location "./src"
        files { "%{prj.location}/**.hpp", "%{prj.location}/**.cpp" }

        filter { "system:windows" }
            -- links { "" }
            warnings "Extra" -- or "High"/"Everything"?
            -- linkoptions { "/IGNORE:4099" }

        filter { "system:linux" }
            -- links { "" }
            enablewarnings { "all", "extra", "pedantic", "conversion" }

        filter "configurations:Debug"
            defines { "DEBUG" }
            filter { "system:linux" }
                linkoptions { "-fsanitize=leak,address,undefined" }
            symbols "On"

        filter "configurations:Release"
            defines { "NDEBUG" }
            optimize "Full" -- or "Speed"?

        conan_setup()
