# Building with spack
`mfem-basic-examples` and its dependencies can be installed directly using spack.
The `package.py` file for mfem-basic-examples needs to be copied to your local spack
installation
```bash
mkdir $SPACK_ROOT/var/spack/repos/builtin/packages/mfem-basic-examples
cp package.py $SPACK_ROOT/var/spack/repos/builtin/packages/mfem-basic-examples/package.py
```
The dev branch on Gitlab can be installed by running
```bash
spack install mfem-basic-examples@develop
```

To install a custom development version run
```bash
spack dev-build mfem-basic-examples@develop
```
in the root directory of the local version.

The environment can be loaded by running
```bash
spack load mfem-basic-examples
```

An example can then be run
```bash
ex1 -o 2
```

An installed version can be unistalled with
```bash
spack uninstall mfem-basic-examples
```