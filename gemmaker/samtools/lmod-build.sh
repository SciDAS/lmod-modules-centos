#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${SAMTOOLS_VERSION}.lua <<EOF
help([[
    Samtools is a suite of programs for interacting with high-throughput sequencing data.
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
EOF
}

# build samtools ${SAMTOOLS_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/samtools/samtools-${SAMTOOLS_VERSION}
wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 
bunzip2 samtools-${SAMTOOLS_VERSION}.tar.bz2 
tar -xvf samtools-${SAMTOOLS_VERSION}.tar 
cd samtools-${SAMTOOLS_VERSION}
./configure --prefix=${LMOD_MODULE_DIR}/samtools/samtools-${SAMTOOLS_VERSION} --without-curses 
make install


# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/samtools/samtools-${SAMTOOLS_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/samtools/samtools-${SAMTOOLS_VERSION}

# test
echo "### TEST: samtools/bin ###"
(cd ${LMOD_MODULE_DIR}/samtools/samtools-${SAMTOOLS_VERSION}/bin && ls)

# generate tar.gz
cd ${LMOD_MODULE_DIR}/samtools
tar -czf samtools-${SAMTOOLS_VERSION}.tar.gz samtools-${SAMTOOLS_VERSION}
cp samtools-${SAMTOOLS_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
