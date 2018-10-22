#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${TRIMMOMATIC_VERSION}.lua <<EOF
help([[
    Trimmomatic: A flexible read trimming tool for Illumina NGS data.
]])
local version          = myModuleVersion()
local base             = "${LMOD_MODULE_DIR}"
local pkgName          = myModuleName()
local pkg              = pathJoin(base,pkgName,pkgName .. "-" .. version)
local classPath        = pathJoin(pkg,"trimmomatic-${TRIMMOMATIC_VERSION}.jar")
local illuminaclipPath = pathJoin(pkg,"adapters")
prepend_path("PATH", pkg)
prepend_path("CLASSPATH", classPath)
prepend_path("ILLUMINACLIP_PATH", illuminaclipPath)
prereq("java")
EOF
}

# build Trimmomatic ${TRIMMOMATIC_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/trimmomatic/trimmomatic-${TRIMMOMATIC_VERSION}
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-${TRIMMOMATIC_VERSION}.zip 
unzip Trimmomatic-${TRIMMOMATIC_VERSION}.zip
cp -R Trimmomatic-${TRIMMOMATIC_VERSION}/. ${LMOD_MODULE_DIR}/trimmomatic/trimmomatic-${TRIMMOMATIC_VERSION}

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/trimmomatic/trimmomatic-${TRIMMOMATIC_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/trimmomatic/trimmomatic-${TRIMMOMATIC_VERSION}

# test
echo "### TEST: Trimmomatic --version ###"
java -jar ${LMOD_MODULE_DIR}/trimmomatic/trimmomatic-${TRIMMOMATIC_VERSION}/trimmomatic-${TRIMMOMATIC_VERSION}.jar -version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/trimmomatic
tar -czf trimmomatic-${TRIMMOMATIC_VERSION}.tar.gz trimmomatic-${TRIMMOMATIC_VERSION}
cp trimmomatic-${TRIMMOMATIC_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
