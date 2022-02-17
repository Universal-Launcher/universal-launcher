package("qt-mcauth")
    set_homepage("https://github.com/Universal-Launcher/Qt5_MCAuth")
    set_description("Library to help with Minecraft authentication process.")
    set_license("GPLv3")

    add_urls("https://github.com/Universal-Launcher/Qt5-MCAuth.git")
    add_versions("v1.0.3", "7567a6b4cf532a21a2de9926677895da644d258c")
    add_versions("v1.0.4", "91e0a82115ff9bb4b068d3f4caecfcb0ae2ea06f")

    add_includedirs("include", { public = true })

    on_install(function(package)
        local configs = {}
        if package:config("static") then
          configs.kind = "static"
          configs.rules = {"qt.static"}
        end
        import("package.tools.xmake").install(package, configs)
    end)
