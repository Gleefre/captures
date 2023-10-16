(in-package #:captures/ext)

(defun undefined-capture (type name &rest args)
  (warn "Undefined capture of type ~S for the name ~S."
        `(,type ,@args)
        name))

(defun parse-capture (name lambda-list body)
  (multiple-value-bind (body declarations doc)
      (parse-body body)
    (let (unused-decls captures)
      (loop for (nil . decls) in declarations
            do (loop for (decl-type . args) in decls
                     if (member decl-type '(capture spooky))
                     do (push args captures)
                     else
                     do (push (list* decl-type args) unused-decls)))
      (let ((*capture*
              (make-capture :args lambda-list
                            :body `(progn
                                     ,@body)
                            :name name
                            :function-name (gensym (concatenate 'string (symbol-name name) "-")))))
        (loop for (type . vars) in captures
              for (capture-name . args) = (alexandria:ensure-list type)
              do (loop for var in vars
                       do (apply (symbol-capture capture-name #'undefined-capture)
                                 capture-name
                                 var
                                 args)))
        (with-slots (lambda-list call-args body call args name function-name)
            *capture*
          (let ((form (gensym)))
            (values
             `(,name (&whole ,form ,@args)
                ,@(when doc `(,doc))
                (declare (ignorable ,@(get-vars args)))
                `(symbol-macrolet ((%call (,',function-name ,@',call-args ,@(cdr ,form))))
                   ,',call))
             `(,function-name (,@lambda-list ,@args)
                              (declare ,@unused-decls)
                              ,body))))))))
