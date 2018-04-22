#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${JAVA_VERSION}.lua <<EOF
help([[
    java version "${JAVA_VERSION}"
    Java(TM) SE Runtime Environment
    Java HotSpot(TM) 64-Bit Server VM
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,"jdk" .. version,"bin")
prepend_path("PATH", pkg)
prepend_path("PATH", pathJoin(base,pkgName,"jdk" .. version,"jre","bin"))
setenv( "JAVA_HOME", pathJoin(base,pkgName,"jdk" .. version))
setenv( "JRE_HOME", pathJoin(base,pkgName,"jdk" .. version,"jre"))
EOF
}

# build java ${JAVA_VERSION}
WHICH_JAVA=$(echo $JAVA_VERSION | cut -c1-3)
if [ "${WHICH_JAVA}" == "1.8" ]; then
  URL=$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk8.txt?p=downloads.tgz)
elif [ "${WHICH_JAVA}" == "1.7" ]; then
  URL=$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk7.txt?p=downloads.tgz)
else
  echo "ERROR: requested version ${JAVA_VERSION} in not available"
  exit 1
fi

mkdir -p ${LMOD_MODULE_DIR}/java
cd ${LMOD_MODULE_DIR}/java
TAR_GZ_FILE=$(echo $URL | rev | cut -d '/' -f 1 | rev)
curl -LOH 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}"
tar -xzf $TAR_GZ_FILE
rm -f $TAR_GZ_FILE
cd -

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/java/jdk${JAVA_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/java/jdk${JAVA_VERSION}

# test
echo "### TEST: java -version ###"
${LMOD_MODULE_DIR}/java/jdk${JAVA_VERSION}/bin/java -version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/java
tar -czf jdk${JAVA_VERSION}.tar.gz jdk${JAVA_VERSION}
cp jdk${JAVA_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
