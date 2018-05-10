# git

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

## Options

Release version options based on [https://github.com/git/git/releases](https://github.com/git/git/releases)

### Defaults for build are

- `GIT_VERSION=2.17.0`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

None

## Build

### docker image

Build the docker image from the `git/` directory

```
docker build -t lmod.git .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `GIT_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/2.17.0:/output \
  -e GIT_VERSION=2.17.0 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.git
```

Upon completion the following files should be observed

```console
$ ls -alh $(pwd)/2.17.0
-rw-r--r--  1 xxx  xxx   375B Apr 22 12:00 2.17.0.lua
-rw-r--r--  1 xxx  xxx    41M Apr 22 12:00 git-2.17.0.tar.gz
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/git/git-2.17.0`
- Modulefiles: `/opt/apps/modulefiles/Linux/git/2.17.0.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/scidas/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/git
mkdir -p modulefiles/git
cp ../lmod-modules-centos/git/2.17.0/git-2.17.0.tar.gz \
  modules/git/git-2.17.0.tar.gz
cp ../lmod-modules-centos/git/2.17.0/2.17.0.lua \
  modulefiles/git/2.17.0.lua
cd modules/git
tar -xzf git-2.17.0.tar.gz
rm -f git-2.17.0.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   git/2.17.0
```

