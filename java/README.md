# java

Java Platform, Standard Edition (Java SE) lets you develop and deploy Java applications on desktops and servers. Java offers the rich user interface, performance, versatility, portability, and security that today's applications require.

## Options

Version based on links from [https://lv.binarybabel.org/catalog](https://lv.binarybabel.org/catalog)

### Defaults for build are

- `JAVA_VERSION=1.8.0_171`
- `LMOD_MODULE_DIR=/opt/apps/Linux`

### Other dependencies

None

## Build

### docker image

Build docker image from the `java/` directory

```
docker build -t lmod.java .
```

### Lmod package files and Lua script

Generate the Lmod package files and Lua script by running the container with optional environment variable overrides for `JAVA_VERSION` and `LMOD_MODULE_DIR`.

The output files will be saved to the directory mapped to the `/output` volume of the container. For clarity this should map to the version of the package being generated.

Example:

```
docker run --rm \
  -v $(pwd)/1.8.0_171:/output \
  -e JAVA_VERSION=1.8.0_171 \
  -e LMOD_MODULE_DIR=/opt/apps/Linux \
  lmod.java
```

Upon completion the following files should be observed

```console
$ ls -alh $(pwd)/1.8.0_171
-rw-r--r--  1 xxx  xxx   493B Apr 22 12:57 1.8.0_171.lua
-rw-r--r--  1 xxx  xxx   182M Apr 22 12:57 jdk1.8.0_171.tar.gz
```

## Install

The generated files should be placed into the target systems **modules** (`/opt/apps/Linux`) and **modulefiles** (`/opt/apps/modulefiles/Linux`) directories using the hierachy:

- Modules: `/opt/apps/Linux/java/jdk1.8.0_171`
- Modulefiles: `/opt/apps/modulefiles/Linux/java/1.8.0_171.lua`

### Example installation 

- Where `modules` and `modulefiles` directories are mapped to the target systems `/opt/apps/Linux` and `/opt/apps/modulefiles/Linux` directories respectively.
- Assumes [lmod-modules-centos](https://github.com/mjstealey/lmod-modules-centos) repository is one level up for relative path commands.

```
mkdir -p modules/java
mkdir -p modulefiles/java
cp ../lmod-modules-centos/java/1.8.0_171/jdk1.8.0_171.tar.gz \
  modules/java/jdk1.8.0_171.tar.gz
cp ../lmod-modules-centos/java/1.8.0_171/1.8.0_171.lua \
  modulefiles/java/1.8.0_171.lua
cd modules/java
tar -xzf jdk1.8.0_171.tar.gz
rm -f jdk1.8.0_171.tar.gz
cd -
```

### module avail

Once installed Lmod will show the module as:

```console
$ module avail

-------- /opt/apps/modulefiles/Linux --------
   java/1.8.0_171
```



