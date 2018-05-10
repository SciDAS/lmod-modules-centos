help([[
    The NCBI SRA Toolkit enables reading of sequencing files from the SRA database and writing files into the .sra format
]])
local version = myModuleVersion()
local base    = "/opt/apps/Linux"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
