# Nano

GNU nano is a text editor for Unix-like computing systems or operating environments using a command line interface. It emulates the Pico text editor, part of the Pine email client, and also provides additional functionality.

## Options

Release version options based on [https://www.nano-editor.org/download.php](https://www.nano-editor.org/download.php)

### Defaults for build are

- `GIT_VERSION=2.9.6`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

None

## Build

### docker image

Build the docker image from the `nano/` directory

```
docker build -t lmod.nano .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `NANO_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/2.9.6:/output \
  -e NANO_VERSION=2.9.6 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.nano
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/nano/nano-2.9.6`
- Modulefiles: `/opt/apps/modulefiles/Linux/nano/2.9.6.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/scidas/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/nano
mkdir -p modulefiles/nano
cp ../lmod-modules-centos/nano/2.9.6/nano-2.9.6.tar.gz \
  modules/nano/nano-2.9.6.tar.gz
cp ../lmod-modules-centos/nano/2.9.6/2.9.6.lua \
  modulefiles/nano/2.9.6.lua
cd modules/nano
tar -xzf nano-2.9.6.tar.gz
rm -f nano-2.9.6.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   nano/2.9.6
```

