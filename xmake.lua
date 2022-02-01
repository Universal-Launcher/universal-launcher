rule("install_bin")
	after_install("linux", function(target)
		local binarydir = path.join(target:installdir(), "bin")
		os.mkdir(binarydir)
		os.vcp(target:targetfile(), binarydir)
	end)
rule_end()

add_rules("mode.debug", "mode.release")

set_policy("package.requires_lock", true)
includes("xmake/rules.lua")

set_allowedmodes("debug", "release")
set_allowedplats("windows", "mingw", "linux", "macosx")
set_allowedarchs("windows|x64", "mingw|x86_64", "linux|x86_64", "macosx|x86_64")
set_defaultmode("debug")

add_rpathdirs("@executable_path")

set_languages("c17", "cxx20")
set_warnings("allextra")

if is_mode("release") then
    set_symbols("debug", "hidden")
	set_fpmodels("fast")
	add_vectorexts("sse", "sse2", "sse3", "ssse3")
elseif is_mode("debug") then
	set_optimize("none")
end

if is_plat("windows") then 
    add_cxflags("/w44062") -- Enable warning: switch case not handled
    add_cxflags("/wd4251") -- Disable warning: class needs to have dll-interface to be used by clients of class blah blah blah
end

target("universal-launcher")
    add_rules("install_bin")
    add_rules("qt.quickapp")

    set_kind("binary")
    add_files("src/**.cpp")
    --add_files("src/**.h")
    add_files("assets/resources.qrc")

    set_installdir("./export")

    add_defines("QT_QML_DEBUG_NO_WARNING")

    add_frameworks("QtCore", "QtQml", "QtQuick", "QtNetworkAuth", "QtWebView")

    on_load(function (target)
        import("detect.sdks.find_qt")

        local qt = find_qt()
        if (not qt) then
            -- Disable building by default if Qt is not found
            target:set("default", false)
        end
    end)