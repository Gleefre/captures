(in-package #:captures)

(defmacro defun/capture (name lambda-list &body body)
  (multiple-value-bind (macro function)
      (parse-capture name lambda-list body)
    `(progn
       (defun ,@function)
       (defmacro ,@macro))))

(defmacro flet/capture ((&rest definitions) &body body)
  (let (functions macros)
    (loop for (name lambda-list . body) in definitions
          do (multiple-value-bind (macro function)
                 (parse-capture name lambda-list body)
               (push macro macros)
               (push function functions)))
    `(macrolet (,@macros)
       (flet (,@functions)
         ,@body))))

(defmacro labels/capture ((&rest definitions) &body body)
  (let (functions macros)
    (loop for (name lambda-list . body) in definitions
          do (multiple-value-bind (macro function)
                 (parse-capture name lambda-list body)
               (push macro macros)
               (push function functions)))
    `(macrolet (,@macros)
       (labels (,@functions)
         ,@body))))
