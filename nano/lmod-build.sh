#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${NANO_VERSION}.lua <<EOF
help([[
GNU nano is a text editor for Unix-like computing systems or operating environments using a command line interface. It emulates the Pico text editor, part of the Pine email client, and also provides additional functionality.
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
EOF
}

NANO_SHORT_VERSION=${NANO_VERSION::-2}

# build nano ${NANO_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/nano/
cd ${LMOD_MODULE_DIR}/nano/
wget https://www.nano-editor.org/dist/v${NANO_SHORT_VERSION}/nano-${NANO_VERSION}.tar.gz
tar xvzf nano-${NANO_VERSION}.tar.gz
rm nano-${NANO_VERSION}.tar.gz
cd nano-${NANO_VERSION}
./configure --prefix=${LMOD_MODULE_DIR}/nano/nano-${NANO_VERSION} 
make
make install

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/nano/nano-${NANO_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/nano/nano-${NANO_VERSION}

# test
echo "### TEST: git --version ###"
${LMOD_MODULE_DIR}/nano/nano-${NANO_VERSION}/bin/nano --version 

# generate tar.gz
cd ${LMOD_MODULE_DIR}/nano
tar -czf nano-${NANO_VERSION}.tar.gz nano-${NANO_VERSION}
cp nano-${NANO_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
