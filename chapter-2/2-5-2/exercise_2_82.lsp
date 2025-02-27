#|
you can't run this code

1. If there is no operation for the resulting type, an error will occur.

2. Some operations can and should work with multiple types, for example, 
multiplying a vector by a matrix. However, our strategy only provides 
for operations with a single data type.

3. In our current strategy, the first successfully cast type for all 
arguments will be used, but the operation may not support it.  
|#

(define (iter1 args1 args1-iter)
    (if (null? args1) #f
          ((let ((coerced-args (iter2 (type-tag (car args1-iter)) '() args1)))
          (if (pair? coerced-args) coerced-args (iter1 args1 (cdr args1-iter)))))))

(define (iter2 arg1-type result args2)
  (if (null? args2) result
      (let ((arg2-type (type-tag (car args2))))
      (let ((arg2->arg1 (get-coercion arg2-type arg1-type)))
          (if 
            arg2->arg1 
            (iter2 arg1-type (append result (list (arg2->arg1 (car args2)))) (cdr args2))
            #f)))))

(define (apply-generic operation-name . args)
  (let ((type-tags (map type-tag args)))
  (let ((procedure (get operation-name type-tags)))
      (if procedure
          (apply procedure (map contents args))
          (let ((coerced-args (iter1 args args)))
          (if coerced-args
                (apply-generic operation-name coerced-args)
                (error "No operation for these types -- APPLY-GENERIC")))))))