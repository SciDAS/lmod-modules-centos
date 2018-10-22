#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${FASTQC_VERSION}.lua <<EOF
help([[
    A quality control application for high throughput sequence data.
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version)
prepend_path("PATH", pkg)
prereq("java")
EOF
}

# build nextflow ${NEXTFLOW_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION}
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip
unzip fastqc_v${FASTQC_VERSION}.zip
cp -R FastQC/. ${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION}

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION}

# test
echo "### TEST: ./fastqc --version ###"
chmod 755 ${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION}/fastqc
${LMOD_MODULE_DIR}/fastqc/fastqc-${FASTQC_VERSION}/fastqc --version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/fastqc
tar -czf fastqc-${FASTQC_VERSION}.tar.gz fastqc-${FASTQC_VERSION}
cp fastqc-${FASTQC_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
