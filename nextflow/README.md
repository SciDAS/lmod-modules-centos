# nextflow

Data-driven computational pipelines

Nextflow enables scalable and reproducible scientific workflows using software containers. It allows the adaptation of pipelines written in the most common scripting languages.

## Options

Version based on distribution from [https://www.nextflow.io](https://www.nextflow.io)

### Defaults for build are

- `NEXTFLOW_VERSION=0.30.1`
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
  -v $(pwd)/0.30.1:/output \
  -e NEXTFLOW_VERSION=0.30.1 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.nextflow
```

Upon completion the following files should be observed

```console
$ ls -lh $(pwd)/0.30.1
total 56696
-rw-r--r--  1 stealey  staff   393B Jun 12 12:44 0.30.1.lua
-rw-r--r--  1 stealey  staff    28M Jun 12 12:44 nextflow-0.30.1.tar.gz
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/nextflow/nextflow-0.30.1`
- Modulefiles: `/opt/apps/modulefiles/Linux/nextflow/0.30.1.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/scidas/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/nextflow
mkdir -p modulefiles/nextflow
cp ../lmod-modules-centos/nextflow/0.30.1/nextflow-0.30.1.tar.gz \
  modules/nextflow/nextflow-0.30.1.tar.gz
cp ../lmod-modules-centos/nextflow/0.30.1/0.30.1.lua \
  modulefiles/nextflow/0.30.1.lua
cd modules/nextflow
tar -xzf nextflow-0.30.1.tar.gz
rm -f nextflow-0.30.1.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   java/1.8.0_171    nextflow/0.30.1
```

- **NOTE**: `java/1.8.0_171` is also shown due to it being a nextflow dependency
