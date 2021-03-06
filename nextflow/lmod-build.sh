#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${NEXTFLOW_VERSION}.lua <<EOF
help([[
    N E X T F L O W
    version 0.30.1 build 4844
    last modified 11-06-2018 08:29 UTC
    cite doi:10.1038/nbt.3820
    http://nextflow.io
]])
local home    = os.getenv("HOME")
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version)
prepend_path("PATH", pkg)
prereq("java")
setenv("NXF_HOME", pathJoin(home,".nextflow"))
EOF
}

# build nextflow ${NEXTFLOW_VERSION}
source /etc/profile.d/java.sh
mkdir -p ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}
curl -s https://get.nextflow.io | bash
mv $HOME/.nextflow/ ${LMOD_MODULE_DIR}/nextflow/nextflow-0.30.1/
mv /nextflow ${LMOD_MODULE_DIR}/nextflow/nextflow-0.30.1/
sed -i 's!$HOME/.nextflow!'${LMOD_MODULE_DIR}'/nextflow/nextflow-'${NEXTFLOW_VERSION}'/.nextflow!g' \
  ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}/nextflow

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}

# test
echo "### TEST: nextflow -version ###"
${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}/nextflow -version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/nextflow
tar -czf nextflow-${NEXTFLOW_VERSION}.tar.gz nextflow-${NEXTFLOW_VERSION}
cp nextflow-${NEXTFLOW_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
