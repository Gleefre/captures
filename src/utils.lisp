(in-package #:captures/ext)

;; Alexandria's parse-body signals an error on duplicate docstrings;
;; I prefer to signal a warning as SBCL does.
(defun parse-body (body &key (parse-documentation t))
  (loop with doc of-type (or null string)
        for current = (car body)
        if (and parse-documentation (stringp current) (cdr body))
        if doc do (warn "Duplicate doc string ~S" (pop body))
        else do (setf doc (pop body))
        else if (and (listp current) (eq 'declare (car current)))
        collect (pop body) into decls
        else do (loop-finish)
        while (listp body)
        finally (return (values body decls doc))))

(defun get-vars (args)
  (multiple-value-bind (req optional rest key other-keys-p aux key-p)
      (alexandria:parse-ordinary-lambda-list args)
    (declare (ignore other-keys-p key-p))
    (remove nil
            (append req
                    (mapcar #'car optional)
                    (mapcar #'caddr optional)
                    (list rest)
                    (mapcar #'cadar key)
                    (mapcar #'caddr key)
                    (mapcar #'car aux)))))

(defun place (getter setter)
  (declare (ignore setter))
  (funcall getter))

(defun (setf place) (value getter setter)
  (declare (ignore getter))
  (funcall setter value))
