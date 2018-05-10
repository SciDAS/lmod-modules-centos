help([[
GNU nano is a text editor for Unix-like computing systems or operating environments using a command line interface. It emulates the Pico text editor, part of the Pine email client, and also provides additional functionality.
]])
local version = myModuleVersion()
local base    = "/opt/apps/Linux"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
