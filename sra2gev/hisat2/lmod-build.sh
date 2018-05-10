#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${HISAT2_VERSION}.lua <<EOF
help([[
    HISAT2 is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes (as well as against a single reference genome). Based on an extension of BWT for graphs [Sirén et al. 2014], we designed and implemented a graph FM index (GFM), an original approach and its first implementation to the best of our knowledge. In addition to using one global GFM index that represents a population of human genomes, HISAT2 uses a large set of small GFM indexes that collectively cover the whole genome (each index representing a genomic region of 56 Kbp, with 55,000 indexes needed to cover the human population). These small indexes (called local indexes), combined with several alignment strategies, enable rapid and accurate alignment of sequencing reads. This new indexing scheme is called a Hierarchical Graph FM index (HGFM).
]])
local version          = myModuleVersion()
local base             = "${LMOD_MODULE_DIR}"
local pkgName          = myModuleName()
local pkg              = pathJoin(base,pkgName,pkgName .. "-" .. version)
prepend_path("PATH", pkg)
EOF
}

# build HISAT2 ${HISAT2_VERSION}
#mkdir -p ${LMOD_MODULE_DIR}/hisat2/
mkdir -p ${LMOD_MODULE_DIR}/hisat2/hisat2-${HISAT2_VERSION}
wget http://ccb.jhu.edu/software/hisat2/downloads/hisat2-${HISAT2_VERSION}-beta-Linux_x86_64.zip
unzip hisat2-${HISAT2_VERSION}-beta-Linux_x86_64.zip
cp -R hisat2-${HISAT2_VERSION}-beta/. ${LMOD_MODULE_DIR}/hisat2/hisat2-${HISAT2_VERSION}
#wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-${HISAT_VERSION}-Linux_x86_64.zip 
#unzip hisat2-${HISAT_VERSION}-Linux_x86_64.zip
#cp -R hisat2-${HISAT_VERSION}/. ${LMOD_MODULE_DIR}/hisat2/

# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/hisat2 ###"
tree -a ${LMOD_MODULE_DIR}/hisat2

# test
echo "### TEST: hisat2 --version ###"
${LMOD_MODULE_DIR}/hisat2/hisat2-${HISAT2_VERSION}/hisat2 --version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/hisat2
tar -czf hisat2-${HISAT2_VERSION}.tar.gz hisat2-${HISAT2_VERSION}
cp hisat2-${HISAT2_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
