#!/usr/bin/env bash
set -e

PYTHON3_SHORT_VERSION=${PYTHON3_VERSION::-2}

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${PYTHON3_VERSION}.lua <<EOF
help([[
Python is an interpreted, interactive, object-oriented programming language. It incorporates modules, exceptions, dynamic typing, very high level dynamic data types, and classes. Python combines remarkable power with very clear syntax. It has interfaces to many system calls and libraries, as well as to various window systems, and is extensible in C or C++. 
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
local pyhome  = pathJoin(base,pkgName,pkgName .. "-" .. version)
local pypath  = pathJoin(base,pkgName,pkgName .. "-" .. version,"lib","python${PYTHON3_SHORT_VERSION}")
prepend_path("PATH", pkg)
prepend_path("PYTHONPATH", pypath)
prepend_path("PYTHONHOME", pyhome)
EOF
}

# build python3 ${PYTHON3_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/python3/
cd ${LMOD_MODULE_DIR}/python3/
wget https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tgz
tar xvzf Python-${PYTHON3_VERSION}.tgz 
mv Python-${PYTHON3_VERSION} python3-${PYTHON3_VERSION}
rm Python-${PYTHON3_VERSION}.tgz
cd python3-${PYTHON3_VERSION}
./configure
make
mkdir -p ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin
make altinstall prefix=${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION} exec-prefix=${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}
ln -s ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin/python${PYTHON3_SHORT_VERSION} ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin/python3

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}

# test
echo "### TEST: python3 -V ###"
${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin/python3 -V

# build pip
cd ${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/lib/python${PYTHON3_SHORT_VERSION}
wget https://bootstrap.pypa.io/get-pip.py
${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin/python3 get-pip.py

# test pip
echo "### TEST: python3 -V ###"
${LMOD_MODULE_DIR}/python3/python3-${PYTHON3_VERSION}/bin/python3 -m pip -V

# generate tar.gz
cd ${LMOD_MODULE_DIR}/python3
tar -czf python3-${PYTHON3_VERSION}.tar.gz python3-${PYTHON3_VERSION}
cp python3-${PYTHON3_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
