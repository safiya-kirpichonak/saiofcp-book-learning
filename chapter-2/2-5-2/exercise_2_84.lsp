; you can't run this code

(define (install-scheme-number-package) 
    ; raise realization here
    (put 'next-type 'scheme-number (lambda () 'rational-number)))

(define (install-rational-number-package) 
    ; raise realization here
    (put 'next-type 'rational-number (lambda () 'real-number)))

(define (install-real-number-package) 
    ; raise realization here
    (put 'next-type 'real-number (lambda () 'complex-number)))

(define (install-complex-number-package) 
    ; raise realization here
    (put 'next-type 'complex-number (lambda () #f)))

(define (is-first-higher? type1 type2)
    (let ((next-type2 ((get 'next-type type2))))
        (cond ((not next-type2) #f)
              ((= type1 next-type2) #t)
              (else (is-first-higher? type1 next-type2)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
  (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
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