# sojrn-asdf-system

sojrn ASDF System Extension — custom system classes and build hooks for
[sojrn](https://github.com/logoraz/sojrn).

## Overview

Provides `ASDF` system classes (and package-inferred-system variants) via
`:class`:

- Systems
  - `sojrn-asdf-system-extension` — base system class
  - `sojrn-package-inferred-system` — PIS variant of the base class
- Functionalities
  - `sojrn-exec-system` — executable build hook (works with either variant above)
  - `sojrn-exec-package-inferred-system` — PIS variant of `sojrn-exec-system`
  - `sojrn-doc-system` — Markdown → HTML documentation generation (works with
    either variant above)
  - `sojrn-doc-package-inferred-system` — PIS variant of `sojrn-doc-system`

Also configures CFFI foreign-library paths for
[GuixOS](https://guix.gnu.org/en/about/) (`GUIX_ENVIRONMENT`) and Windows
(msys2/ucrt64).

## Usage

```lisp
(defsystem "my-system"
  :defsystem-depends-on ("sojrn-asdf-system")
  :class :sojrn-asdf-system-extension
  ...)

(defsystem "my-system/docs"
  :class :sojrn-doc-system
  :depends-on ("my-system"))

(defsystem "my-system/executable"
  :class :sojrn-exec-system
  :depends-on ("my-system")
  :build-operation "program-op"
  :build-pathname "dist/my-system"
  :entry-point "my-system:main")
```

## Dependencies

| System                                                       | Role                              |
|--------------------------------------------------------------|-----------------------------------|
| `asdf`                                                       | Build system this library extends |
| `khazern-intrinsic`                                          | Replaces `cl:loop` (see below)    |
| `khazern-extension-intrinsic`                                | Extended `LOOP` syntax            |
| `cffi`                                                       | Foreign-library path setup        |
| `3bmd`, `3bmd-ext-code-blocks`, `colorize`, `print-licenses` | Documentation generation          |

### LOOP: Khazern

This library loads `khazern-intrinsic` and `khazern-extension-intrinsic` from
[Khazern](https://github.com/clasp-developers/Khazern), a portable and extensible
implementation of the standard `LOOP`. Loading it redefines `COMMON-LISP:LOOP` in
the running image, so every system built after `sojrn-asdf-system` is loaded,
dependencies included, uses Khazern's `LOOP` with no per-package changes.  That
image-wide effect is deliberate and suits application builds.

- Extended syntax (iteration paths) comes from `khazern-extension-intrinsic`.
- `LOOP` lives in the `COMMON-LISP` package, so ASDF's recompilation tracking
  for systems depending on `khazern-intrinsic` may be unreliable. If behavior
  looks stale, clear the fasl cache.

## License

```lisp
(defmacro license-terms (system . plist)
  "See LICENSE for the actual legally-binding, non-parenthesized version."
  (declare (optimize (safety 0))) ; use at your own risk
  `(list :system ',system ,@plist))

(license-terms sojrn-asdf-system
  :type        '(:|LGPL-2.1-only WITH LLGPL| . "https://spdx.org/licenses/LLGPL.html")
  :permissions '(:use :copy :modify :distribute :link)
  :conditions  '(:include-copyright-notice
                 :disclose-source-lib
                 :same-license-lib
                 :state-changes
                 :lisp-linking)
  :warranty    nil)
```

↳ [LICENSE](LICENSE)
