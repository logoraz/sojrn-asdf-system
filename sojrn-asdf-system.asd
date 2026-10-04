(defsystem "sojrn-asdf-system"
  :description "sojrn ASDF System Extension."
  :author "Erik P Almaraz"
  :license "LGPL-2.1-only WITH LLGPL"
  :version (:read-file-form "data/version.sexp" :at (0 1))
  :depends-on ("asdf"
               "khazern-intrinsic"
               "khazern-extension-intrinsic"
               "cffi"
               "3bmd"
               "3bmd-ext-code-blocks"
               "colorize"
               "print-licenses")
  :components
  ((:module "code"
    :components
    ((:file "classes")
     (:file "cffi-path"  :depends-on ("classes"))
     (:file "exec-hooks" :depends-on ("cffi-path"))
     (:file "docs"       :depends-on ("classes")))))
  :long-description "sojrn ASDF System Extension")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Subsystems
