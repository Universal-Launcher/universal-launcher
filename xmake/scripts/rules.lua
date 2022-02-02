rule("qt.qrc")
    add_deps("qt.env")
    set_extensions(".qrc")

    on_load(function(target)
        -- get qrc
        local qt = assert(target:data("qt"), "qt not found")
        local rcc = path.join(qt.bindir, is_host("windows") and "rcc.exe" or "rcc")
        if not os.isexec(rcc) and qt.libexecdir then 
            rcc = path.join(qt.libexedir, is_host("windows") and "rcc.exe" or "rcc")
        end
        if not os.isexec(rcc) and qt.libexecdir_host then
            rcc = path.join(qt.libexecdir_host, is_host("windows") and "rcc.exe" or "rcc")
        end

        assert(os.isexec(rcc), "rcc not found")

        -- save rcc
        target:data_set("qt.rcc", rcc)
    end)

    on_buildcmd_file(function (target, batchcmds, sourcefile_qrc, opt)
        -- get rcc
        local rcc = target:data("qt.rcc")

        -- get c++ source file for qrc
        local sourcefile_cpp = path.join(target:autogendir(), "rules", "qt", "qrc", path.basename(sourcefile_qrc) .. ".cpp")
        local sourcefile_dir = path.directory(sourcefile_cpp)

        -- add objectfile
        local objectfile = target:objectfile(sourcefile_cpp)
        table.insert(target:objectfiles(), objectfile)

        -- add commands
        batchcmds:show_progress(opt.progress, "${color.build.object}compiling.qt.qrc %s", sourcefile_qrc)
        batchcmds:mkdir(sourcefile_dir)
        batchcmds:vrunv(rcc, {"-name", path.basename(sourcefile_qrc), sourcefile_qrc, "-o", sourcefile_cpp})
        batchcmds:compile(sourcefile_cpp, objectfile)

        -- get qrc resources files
        local outdata = os.iorunv(rcc, {"-name", path.basename(sourcefile_qrc), sourcefile_qrc, "-list"})
        
        -- add resources files to batch
        for file in outdata:gmatch("([^\n]*)\n?") do
            batchcmds:add_depfiles(file)
        end

        -- add deps
        batchcmds:add_depfiles(sourcefile_qrc)
        batchcmds:set_depmtime(os.mtime(objectfile))
        batchcmds:set_depcache(target:dependfile(objectfile))
    end)
