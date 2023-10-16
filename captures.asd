(defsystem "captures"
  :description "Captures are functions that can access the lexical environment they are called in."
  :version "0.0.1"
  :author ("Grolter <varedif.a.s@gmail.com>")
  :licence "Apache 2.0"
  :depends-on ("alexandria" "in-nomine")
  :pathname "src"
  :components ((:file "packages")
               (:file "utils")
               (:file "capture-generator")
               (:file "capture-namespace")
               (:file "capture-parser")
               (:file "standard-captures")
               (:file "main-api")))
