help([[
    Samtools is a suite of programs for interacting with high-throughput sequencing data.
]])
local version = myModuleVersion()
local base    = "/opt/apps/Linux"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
