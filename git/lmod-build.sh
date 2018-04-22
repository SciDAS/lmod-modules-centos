#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${GIT_VERSION}.lua <<EOF
help([[
    Git is a fast, scalable, distributed revision control system with an
    unusually rich command set that provides both high-level operations and
    full access to internals.
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version,"bin")
prepend_path("PATH", pkg)
EOF
}

# build git ${GIT_VERSION}
wget https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz
tar -xzf v${GIT_VERSION}.tar.gz
cd git-${GIT_VERSION}/
mkdir -p ${LMOD_MODULE_DIR}/git-${GIT_VERSION}
make configure
./configure --prefix=${LMOD_MODULE_DIR}/git/git-${GIT_VERSION}
make all
make install

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/git/git-${GIT_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/git/git-${GIT_VERSION}

# test
echo "### TEST: git --version ###"
${LMOD_MODULE_DIR}/git/git-${GIT_VERSION}/bin/git --version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/git
tar -czf git-${GIT_VERSION}.tar.gz git-${GIT_VERSION}
cp git-${GIT_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
