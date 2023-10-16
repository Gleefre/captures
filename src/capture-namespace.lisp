(in-package #:captures/ext)

(define-namespace capture)

(defmacro defcapture (name lambda-list &body body
                      &aux (type (gensym)))
  `(setf (symbol-capture ',name)
         (lambda (,type ,@lambda-list)
           (declare (ignore ,type))
           ,@body)))
