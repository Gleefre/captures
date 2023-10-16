(in-package #:captures/ext)

(macrolet ((e (name) `(error "~A slot is not supplied." ',name)))
  (defstruct capture
    (lambda-list    ())
    (call-args      ())
    (body           (e body))
    (call           '%call)
    (args           (e args) :read-only t)
    (name           (e name) :read-only t)
    (function-name  (gensym) :read-only t)))

(defvar *capture*)

;;; Helpers

(defun pass-as-arg (var expression)
  (push var (capture-lambda-list *capture*))
  (push expression (capture-call-args *capture*)))
