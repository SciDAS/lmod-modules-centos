#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${SCREEN_VERSION}.lua <<EOF
help([[
Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version)
prepend_path("PATH", pkg)
EOF
}

SCREEN_SHORT_VERSION=${SCREEN_VERSION::-2}

# build screen ${SCREEN_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/screen/
cd ${LMOD_MODULE_DIR}/screen/
wget http://ftp.gnu.org/gnu/screen/screen-${SCREEN_VERSION}.tar.gz
tar xvzf screen-${SCREEN_VERSION}.tar.gz
rm screen-${SCREEN_VERSION}.tar.gz
cd screen-${SCREEN_VERSION}
./autogen.sh
./configure --prefix=${LMOD_MODULE_DIR}/screen/screen-${SCREEN_VERSION}
make
make install

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/screen/screen-${SCREEN_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/screen/screen-${SCREEN_VERSION}

# test
echo "### DONE ###"
#${LMOD_MODULE_DIR}/screen/screen-${SCREEN_VERSION}/screen --version 

# generate tar.gz
cd ${LMOD_MODULE_DIR}/screen
tar -czf screen-${SCREEN_VERSION}.tar.gz screen-${SCREEN_VERSION}
cp screen-${SCREEN_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
