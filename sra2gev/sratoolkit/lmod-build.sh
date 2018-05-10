#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${TOOLKIT_VERSION}.lua <<EOF
help([[
    The NCBI SRA Toolkit enables reading of sequencing files from the SRA database and writing files into the .sra format
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
EOF
}

# build sratoolkit ${TOOLKIT_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/sratoolkit/sratoolkit-${TOOLKIT_VERSION}
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2/sratoolkit.2.8.2-ubuntu64.tar.gz
tar -zxvf sratoolkit.2.8.2-ubuntu64.tar.gz
cp -R sratoolkit.2.8.2-ubuntu64/. ${LMOD_MODULE_DIR}/sratoolkit/sratoolkit-${TOOLKIT_VERSION}

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/sratoolkit/sratoolkit-${TOOLKIT_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/sratoolkit/sratoolkit-${TOOLKIT_VERSION}

# test
echo "### TEST: sratoolkit/bin ###"
(cd ${LMOD_MODULE_DIR}/sratoolkit/sratoolkit-${TOOLKIT_VERSION}/bin && ls)

# generate tar.gz
cd ${LMOD_MODULE_DIR}/sratoolkit
tar -czf sratoolkit-${TOOLKIT_VERSION}.tar.gz sratoolkit-${TOOLKIT_VERSION}
cp sratoolkit-${TOOLKIT_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
