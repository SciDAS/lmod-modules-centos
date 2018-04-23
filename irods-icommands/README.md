# irods-icommands

iRODS iCommands are Unix utilities that give users a command-line interface to operate on data in the iRODS system. There are commands related to the logical hierarchical filesystem, metadata, data object information, administration, rules, and the rule engine. iCommands provide the most comprehensive set of client-side standard iRODS manipulation functions.

**UNDER CONSTRUCTION**

- For now the required Lmod files are being provided directly withtout their build definitions (`Dockerfile` and `lmod-build.sh`).
- Please skip ahead to the **Install** section for further details.


## Options

Release version options based on [https://github.com/irods/irods_client_icommands/releases](https://github.com/irods/irods_client_icommands/releases)

### Defaults for build are

- `IRODS_VERSION=4.1.11`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

None

## Build

### docker image

Build the docker image from the `irods-icommands/` directory

```
docker build -t lmod.irods-icommands .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `IRODS_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/4.1.11:/output \
  -e IRODS_VERSION=4.1.11 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.irods-icommands
```

Upon completion the following files should be observed

```console
$ ls -alh $(pwd)/4.1.11
-rw-r--r--  1 xxx  xxx   555B Apr 23 12:30 4.1.11.lua
-rw-r--r--  1 xxx  xxx    31M Apr 23 12:27 irods-icommands-4.1.11.tar.gz
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/irods-icommands/irods-icommands-4.1.11`
- Modulefiles: `/opt/apps/modulefiles/Linux/irods-icommands/4.1.11.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/mjstealey/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/irods-icommands
mkdir -p modulefiles/irods-icommands
cp ../lmod-modules-centos/irods-icommands/4.1.11/irods-icommands-4.1.11.tar.gz \
  modules/irods-icommands/irods-icommands-4.1.11.tar.gz
cp ../lmod-modules-centos/irods-icommands/4.1.11/4.1.11.lua \
  modulefiles/irods-icommands/4.1.11.lua
cd modules/irods-icommands
tar -xzf irods-icommands-4.1.11.tar.gz
rm -f irods-icommands-4.1.11.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   irods-icommands/4.1.11
```
