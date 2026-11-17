# GNU Guix packaging

The module `(securityops packages matlivre)` exports `matlivre` 0.1.9 and
`emacs-matlibre` 0.1.0. The application input is the official release AppImage,
identified by SHA-256. SquashFS extraction does not execute the AppImage runtime
or require FUSE. The update helper is omitted; updates are managed through Guix.

The official binary imports `acosf` and `atan2f` at `GLIBC_2.43`. A private GNU
libc 2.43 dependency provides those symbols. It inherits Guix's libc packaging,
retains the Linux loader/cache/locale patches and corrects the locale version
path. GNU/Hurd-only patches are excluded from this x86_64 Linux runtime.
The libc inherits Guix's existing test policy; application tests do not stand
in for the full libc test suite.

The application ELF interpreter and RUNPATH refer to store dependencies. The
recipe uses RUNPATH instead of exporting the private libc through `LD_LIBRARY_PATH`,
so that child programs retain their own runtime. A bounded build smoke test
requires `disp(6*7)` to return `42` through the installed stdio interface.

The Emacs package contains the library, generated autoloads and bytecode. It
propagates MatLivre, so installing the integration also installs its runtime.
The separate `matlivre-cli` binary is absent from the upstream AppImage;
MatLibre executes code through the bundled stdio interface.

## Build farm

The SecurityOps channel's existing package discovery finds both exported
recipes. Job names are `matlivre.matlivre.x86_64-linux` and
`matlivre.emacs-matlibre.x86_64-linux`. A live Cuirass evaluation requires an
authenticated channel revision; adding a local recipe does not register a live job.

Binary distribution remains subject to exact-closure review, license obligations
and the existing publication gate. Availability requires the exact output's
narinfo from the intended publisher. Dependency/channel revisions must match.
Do not infer public substitute availability from a successful build.

Upstream: https://github.com/campuslivre/matlivre/releases/tag/v0.1.9

## Corresponding source for the published binary inputs

The first verified binary outputs were built with GNU Guix commit
`80e64a9845c1f2ede332b29a5270aacc6df196f5`. Its package definitions and
patches are available in the [Guix source tree](https://git.guix.gnu.org/guix.git/commit/?id=80e64a9845c1f2ede332b29a5270aacc6df196f5).
The additional build instructions are in this repository's
`securityops/packages/matlivre.scm`; GNU libc 2.43 is fetched from its pinned
upstream source archive and retains the applicable Guix patches. MatLivre's
corresponding upstream release is linked above. This identifies source and
build instructions; it does not claim that the upstream AppImage was reproduced.

Runtime dependencies retain their Guix licenses and notices. These include
GNU libc (LGPL), GNU Bash (GPL), GCC runtime libraries (GPL with the GCC Runtime
Library Exception), and the X11, Mesa, LLVM, compression and font dependencies.
The application package also carries the bundled font notices extracted from
`epaint_default_fonts` 0.29.1. Preserve these notices when redistributing outputs.

## Published binary metadata

The current [build farm](https://farm.securityops.co/) outputs use GNU Guix
commit `3f81f6643f69194f7b0c3243c214e3dbbdc3b805`. Its corresponding package
definitions and patches are in the [Guix source tree](https://git.guix.gnu.org/guix.git/commit/?id=3f81f6643f69194f7b0c3243c214e3dbbdc3b805).
The MatLivre recipe and pinned GNU libc source described above also apply.

| Package | Current farm binary metadata |
| --- | --- |
| MatLivre 0.1.9 | [Signed narinfo](https://substitutes.securityops.co/6jn768is8g2ryb43qxgwf06hizbp8g8p.narinfo) |
| MatLibre for Emacs 0.1.0 | [Signed narinfo](https://substitutes.securityops.co/nqrwva2r772i336apii74rayi9mxlbnq.narinfo) |

MatLivre passed the bounded runtime check; the Emacs package passed bytecode
validation. The integration also passed all nine headless tests against these exact
outputs, including workspace persistence, code evaluation and PNG figures.

The first outputs, built with the earlier Guix revision, remain available:

| Package | Binary metadata |
| --- | --- |
| MatLivre 0.1.9 | [Signed narinfo](https://substitutes.securityops.co/6b85iyadfmghdwk7gyv35vypv0s8r2a2.narinfo) |
| MatLibre for Emacs 0.1.0 | [Signed narinfo](https://substitutes.securityops.co/fa073k7svr022papcnw35np5z3gkr3m3.narinfo) |

Those first outputs refer to Guix commit `80e64a9845c1f2ede332b29a5270aacc6df196f5`.
A build using another Guix revision may produce different store paths and need
different substitutes. Each narinfo identifies the exact store path and NAR URL.
The Emacs library output and its propagated application dependency are separate
outputs; both are needed for installation through the package recipe.
