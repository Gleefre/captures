(defpackage #:captures/ext
  (:use #:cl)
  (:import-from #:in-nomine #:define-namespace)
  (:import-from #:alexandria #:with-gensyms)
  (:export  ; Extension API
   #:*capture*
   #:defcapture
   #:capture-lambda-list
   #:capture-call-args
   #:capture-body
   #:capture-call
   #:capture-args
   #:capture-name
   #:capture-function-name)
  (:export  ; Parser
   #:parse-capture
   #:capture
   #:spooky)
  (:export  ; Extension utilities
   #:pass-as-arg))

(defpackage #:captures
  (:import-from #:captures/ext
                #:parse-capture
                #:capture
                #:spooky)
  (:use #:cl)
  (:export  ; Public API
   #:capture
   #:spooky
   #:defun/capture
   #:flet/capture
   #:labels/capture))
