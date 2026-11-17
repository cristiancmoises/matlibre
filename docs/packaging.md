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

The application ELF interpreter and RPATH refer to store dependencies. The
recipe uses RPATH instead of exporting the private libc through `LD_LIBRARY_PATH`,
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
