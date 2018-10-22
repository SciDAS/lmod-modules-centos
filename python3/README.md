# Python3

Python is an interpreted, interactive, object-oriented programming language. It incorporates modules, exceptions, dynamic typing, very high level dynamic data types, and classes. Python combines remarkable power with very clear syntax. It has interfaces to many system calls and libraries, as well as to various window systems, and is extensible in C or C++. 

## Options

Release version options based on [https://www.python.org/ftp/python/](https://www.python.org/ftp/python/)

### Defaults for build are

- `PYTHON3_VERSION=3.7.0`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

None

## Build

### docker image

Build the docker image from the `python3/` directory

```
docker build -t lmod.python3 .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `PYTHON3_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/3.7.0:/output \
  -e PYTHON3_VERSION=3.7.0 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.python3
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/python3/python3-3.7.0`
- Modulefiles: `/opt/apps/modulefiles/Linux/python3/3.7.0.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/scidas/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/python3
mkdir -p modulefiles/python3
cp ../lmod-modules-centos/python3/3.7.0/python3-3.7.0.tar.gz \
  modules/python3/python3-3.7.0.tar.gz
cp ../lmod-modules-centos/python3/3.7.0/3.7.0.lua \
  modulefiles/python3/3.7.0.lua
cd modules/python3
tar -xzf python3-3.7.0.tar.gz
rm -f python3-3.7.0.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   python3/3.7.0
```

