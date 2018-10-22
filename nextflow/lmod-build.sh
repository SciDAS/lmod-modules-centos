#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${NEXTFLOW_VERSION}.lua <<EOF
help([[
    N E X T F L O W
   
    http://nextflow.io
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
source /etc/profile.d/java.sh
mkdir -p ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}
curl -s https://get.nextflow.io | bash
mv $HOME/.nextflow/ ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}/
mv /nextflow ${LMOD_MODULE_DIR}/nextflow/nextflow-${NEXTFLOW_VERSION}/
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
