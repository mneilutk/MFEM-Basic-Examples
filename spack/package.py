from spack import *


class MfemBasicExamples(CMakePackage):
    """Examples solvers using."""

    # FIXME: Add a proper url for your package's homepage here.
    # homepage = "https://www.example.com"
    git = "git@github.com:mneilutk/MFEM-Basic-Examples.git"

    maintainers = ["Michael Neilan", "Kiera Kean"]

    # FIXME: Add proper versions and checksums here once there are tagged versions.
    # version('1.2.3', '0123456789abcdef0123456789abcdef')

    # TODO: Switch to dev after merging.
    version("develop", branch="dev")

    depends_on(
        "mfem@develop~amgx~conduit~cuda~debug+examples~gnutls~gslib+lapack~libunwind+metis~miniapps~mpfr+mpi~netcdf~occa~openmp~petsc~pumi~raja~shared+static~strumpack+suite-sparse~sundials~superlu-dist~threadsafe~umpire+zlib"
    )
