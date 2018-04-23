# Lmod module packages for CentOS 7

**WORK IN PROGRESS**

This work is complementory to the [slurm-in-docker](https://github.com/mjstealey/slurm-in-docker) project and provides the [Lmod](https://lmod.readthedocs.io/en/latest/#) module definitions and Lua scripts for a variety of packages.

See [using lmod with slurm in docker](https://github.com/mjstealey/slurm-in-docker/blob/master/using-lmod-with-slurm-in-docker.md) in either repository for details on usage.

The version of Lmod being used predefines a few paths for which it will look for modulefiles that define the modules.

```
MODULEPATH= \
  /opt/apps/modulefiles/Linux: \
  /opt/apps/modulefiles/Core: \
  /opt/apps/lmod/lmod/modulefiles/Core
```

We are going to choose `/opt/apps/modulefiles/Linux` to define the hierarchy for our modulefiles and define a corresponding modules directory in `/opt/apps/Linux` using a similar hierarchy.

- Our modules: `/opt/apps/Linux/PACKAGE/PACKAGE_FILES`
- Our modulefiles: `/opt/apps/modulefiles/Linux/PACKAGE/PACKAGE_LUA_SCRIPT`

## Modules

The module builds are based from the `lmod.base` image defined at the top level of the repository. This image should be built first prior to proceedign onto the module build definitions.

```
docker build -t lmod.base .
```

Subsequent Dockerfiles all start with `FROM lmod.base` and will not build properly unless the base image is built first.

## git

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

**default version**

- [git/2.17.0](git)

## irods-icommands

iRODS iCommands are Unix utilities that give users a command-line interface to operate on data in the iRODS system. There are commands related to the logical hierarchical filesystem, metadata, data object information, administration, rules, and the rule engine. iCommands provide the most comprehensive set of client-side standard iRODS manipulation functions.

**default version**

- [irods-icommands/4.1.11](irods-icommands)

## java

Java Platform, Standard Edition (Java SE) lets you develop and deploy Java applications on desktops and servers. Java offers the rich user interface, performance, versatility, portability, and security that today's applications require.

**default version**

- [java/1.8.0_171](java)

## nextflow

Data-driven computational pipelines

Nextflow enables scalable and reproducible scientific workflows using software containers. It allows the adaptation of pipelines written in the most common scripting languages.

**default version**

- [nextflow/0.28.0](nextflow)


## References

- Lmod: A New Environment Module System - [http://lmod.readthedocs.io/en/latest/index.html#](http://lmod.readthedocs.io/en/latest/index.html#)
- Lmod: modulefile examples - [http://lmod.readthedocs.io/en/latest/100_modulefile\_examples.html](http://lmod.readthedocs.io/en/latest/100_modulefile_examples.html)
- Lmod: dependent modules - [http://lmod.readthedocs.io/en/latest/098\_dependent\_modules.html](http://lmod.readthedocs.io/en/latest/098_dependent_modules.html)
