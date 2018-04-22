# nextflow

Data-driven computational pipelines

Nextflow enables scalable and reproducible scientific workflows using software containers. It allows the adaptation of pipelines written in the most common scripting languages.

## Options

Version based on distribution from [https://www.nextflow.io](https://www.nextflow.io)

### Defaults for build are

- `NEXTFLOW_VERSION=0.28.0`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

Java - [java module build](../java)

## Build

### docker image

Build docker image from the `java/` directory

```
docker build -t lmod.nextflow .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `NEXTFLOW_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/0.28.0:/output \
  -e NEXTFLOW_VERSION=0.28.0 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.nextflow
```

Upon completion the following files should be observed

```console
$ ls -alh $(pwd)/1.8.0_171
-rw-r--r--  1 xxx  xxx   493B Apr 22 12:57 1.8.0_171.lua
-rw-r--r--  1 xxx  xxx   182M Apr 22 12:57 jdk1.8.0_171.tar.gz
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/nextflow/nextflow-0.28.0`
- Modulefiles: `/opt/apps/modulefiles/Linux/nextflow/0.28.0.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/mjstealey/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/nextflow
mkdir -p modulefiles/nextflow
cp ../lmod-modules-centos/nextflow/0.28.0/nextflow-0.28.0.tar.gz \
  modules/nextflow/nextflow-0.28.0.tar.gz
cp ../lmod-modules-centos/nextflow/0.28.0/0.28.0.lua \
  modulefiles/nextflow/0.28.0.lua
cd modules/nextflow
tar -xzf nextflow-0.28.0.tar.gz
rm -f nextflow-0.28.0.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   java/1.8.0_171    nextflow/0.28.0
```

- **NOTE**: `java/1.8.0_171` is also shown due to it being a nextflow dependency
