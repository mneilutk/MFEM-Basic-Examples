# Building basic MFEM examples with spack

### Downloading and configuring spack (only needs to be done once)
Download spack from github
```bash
git clone git@github.com:spack/spack.git
```

Add spack setup-env.sh to your .bashrc
```bash
echo -e "\nsource `pwd`/spack/share/spack/setup-env.sh\n" >> ~/.bashrc
```

Source your ~/.bashrc
```bash
source ~/.bashrc
```

Configure spack to use the correct compilers (might need to load gcc modules on an HPC)

```bash
spack compiler find
```

### Spack installation of MFEM

If you need load a feature currently in development on an MFEM branch edit the mfem spack package entry to change to custom branch
```bash
spack edit mfem
```
and change the contents to reflect the following
```bash
-    version('develop', branch='master')
+    version('develop', branch= NAMEOFBRANCH)
```

Use spack to install mfem and required dependencies
```bash
spack install mfem@develop~amgx~conduit~cuda~debug+examples~gnutls~gslib+lapack~libunwind+metis~miniapps~mpfr+mpi~netcdf~occa~openmp~petsc~pumi~raja~shared+static~strumpack+suite-sparse~sundials~superlu-dist~threadsafe~umpire+zlib
```

### Developing with mfem
To load mfem to your environment run
```bash
spack load mfem
```

### Artistic Style (Code Beautifier) installation with spack
```bash
spack install astyle
```

### Installing from source
Create build directory in the solvers directory
```bash
spack load mfem
mkdir build
cd build
```

Use CMake to configure and build
```bash
cmake ../
make
```
<!--
```bash
cmake ../
make
```
Install (not necessary if only running locally)
```bash
make install
```
-->
### Run Serial Example (from build directory)
```bash
./examples/ex1
```
Change the polynomial order:
```bash
./examples/ex1 -o 2
```

To see all of the command line options:
```bash
./examples/ex1 --help
```

### Run Parallel Example (from build directory)
```bash
spack load openmpi
```
For example,
```bash
mpirun -np 2 ./examples/ex1p -o 2
```
To see all of the command line options:
```bash
./examples/ex1p --help
```

### Code Beautifying
Run artistic style on source code to auto-format it.
```bash
astyle --options=<mfem-basic-examples-root>/config/mfem-basic-examples.astylerc <source>
```