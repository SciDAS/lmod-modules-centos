#!/usr/bin/env bash
set -e

# generate lua script to be used my Lmod
_generate_lua() {
  cat >> /output/${STRINGTIE_VERSION}.lua <<EOF
help([[
   StringTie is a fast and highly efficient assembler of RNA-Seq alignments into potential transcripts. It uses a novel network flow algorithm as well as an optional de novo assembly step to assemble and quantitate full-length transcripts representing multiple splice variants for each gene locus. Its input can include not only the alignments of raw reads used by other transcript assemblers, but also alignments longer sequences that have been assembled from those reads.In order to identify differentially expressed genes between experiments, StringTie's output can be processed by specialized software like Ballgown, Cuffdiff or other programs (DESeq2, edgeR, etc.).
]])
local version = myModuleVersion()
local base    = "${LMOD_MODULE_DIR}"
local pkgName = myModuleName()
local pkg     = pathJoin(base,pkgName,pkgName .. "-" .. version)
prepend_path("PATH", pkg)
EOF
}

# build nextflow ${STRINGTIE_VERSION}
mkdir -p ${LMOD_MODULE_DIR}/stringtie/stringtie-${STRINGTIE_VERSION}
wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-${STRINGTIE_VERSION}.Linux_x86_64.tar.gz
tar -zxvf stringtie-${STRINGTIE_VERSION}.Linux_x86_64.tar.gz 
cp -R stringtie-${STRINGTIE_VERSION}.Linux_x86_64/. ${LMOD_MODULE_DIR}/stringtie/stringtie-${STRINGTIE_VERSION}/



# display output tree
echo "### contents of ${LMOD_MODULE_DIR}/stringtie/stringtie-${STRINGTIE_VERSION} ###"
tree -a ${LMOD_MODULE_DIR}/stringtie/stringtie-${STRINGTIE_VERSION}

# test
echo "### TEST: stringtie --version ###"
${LMOD_MODULE_DIR}/stringtie/stringtie-${STRINGTIE_VERSION}/stringtie --version

# generate tar.gz
cd ${LMOD_MODULE_DIR}/stringtie
tar -czf stringtie-${STRINGTIE_VERSION}.tar.gz stringtie-${STRINGTIE_VERSION}
cp stringtie-${STRINGTIE_VERSION}.tar.gz /output

# generate lua
_generate_lua

exec "${@}"

exit 0
