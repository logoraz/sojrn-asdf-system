# sojrn-asdf-system

sojrn ASDF System Extension — custom system classes and build hooks for [sojrn](https://github.com/logoraz/sojrn).

## Overview

Provides `ASDF` system classes (and package-inferred-system variants) via `:class`:

- Systems
  - `sojrn-asdf-system-extension` — base system class
  - `sojrn-package-inferred-system` — PIS variant of the base class
- Functionalities
  - `sojrn-exec-system` — executable build hook (works with either variant above)
  - `sojrn-doc-system` — Markdown → HTML documentation generation (works with either
    variant above)

Also configures CFFI foreign-library paths for [GuixOS](https://guix.gnu.org/en/about/) (`GUIX_ENVIRONMENT`) and
Windows (msys2/ucrt64).

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
