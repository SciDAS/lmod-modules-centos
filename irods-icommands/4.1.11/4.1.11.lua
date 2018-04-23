help([[
    iRODS Version 4.1.11                Oct 2017

    For more information on a particular iCommand:
     '<iCommand> -h'
    or
     'ihelp <iCommand>'
]])
local version = myModuleVersion()
local base    = "/opt/apps/Linux"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
setenv( "IRODS_PLUGINS_HOME", pathJoin(base,pkgName,pkgName .. "-" .. version,"lib","irods","plugins") .. "/")
setenv( "LD_LIBRARY_PATH", pathJoin(base,pkgName,pkgName .. "-" .. version,"lib"))
