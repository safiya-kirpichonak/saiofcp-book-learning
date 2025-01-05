; you can't run this code

; let's imagined basic example: complex is a pair 
; (real-number '(image-number 'some-variable))
(define (install-complex-number-package)
    (define (remove-imag-part n)
        (if (= (car imag-part) 0) (real part n) #f))

    ; raise realization here
    (put 'project 'complex-number 
        (lambda (n) 
            (let ((projection (remove-imag-part n))) 
                 (if projection 
                    (if (eq? n (make projection 0)) projection #f) 
                    #f)))))

(define (drop n) 
    (if ((get 'project (type-tag n)) n) (drop n) n))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
  (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args)))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((is-first-higher (is-first-higher? type1 type2)))
                  (if is-first-higher
                            (apply-generic op a1 ((get 'raise type2) a2)) 
                            (apply-generic op ((get 'raise type1) a1) a2))))
              (error "There is no operations for these types -- APPLY-GENERIC" (list op type-tags)))))))