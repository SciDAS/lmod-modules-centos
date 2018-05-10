help([[
    Trimmomatic: A flexible read trimming tool for Illumina NGS data.
]])
local version          = myModuleVersion()
local base             = "/opt/apps/Linux"
local pkgName          = myModuleName()
local pkg              = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
local classPath        = pathJoin(pkg,"trimmomatic-0.36.jar")
local illuminaclipPath = pathJoin(pkg,"adapters")
prepend_path("PATH", pkg)
prepend_path("CLASSPATH", classPath)
prepend_path("ILLUMINACLIP_PATH", illuminaclipPath)
prereq("java")
help([[
    Trimmomatic: A flexible read trimming tool for Illumina NGS data.
]])
local version          = myModuleVersion()
local base             = "/opt/apps/Linux"
local pkgName          = myModuleName()
local pkg              = pathJoin(base,pkgName,pkgName .. "-" .. version)
local classPath        = pathJoin(pkg,"trimmomatic-0.36.jar")
local illuminaclipPath = pathJoin(pkg,"adapters")
prepend_path("PATH", pkg)
prepend_path("CLASSPATH", classPath)
prepend_path("ILLUMINACLIP_PATH", illuminaclipPath)
prereq("java")
