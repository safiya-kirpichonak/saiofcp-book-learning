(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    ; ...
    (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
    'done)

(define (install-rational-package)
    (define (tag x) (attach-tag 'rational x))
    ; ...
    (put '=zero? '(rational) 
        (lambda (x) 
            (cond ((= (numer x) 0) #t)
                  ((= (denom x) 0) (error "Denom can't be 0! -- =ZERO?"))
                  (else #f))))
    'done)

(define (install-complex-package)
    (define (tag z) (attach-tag 'complex z))
    ; ...
    (put '=zero? '(complex) 
        (lambda (x) (and 
                        (= (real-part x) 0) 
                        (= (imag-part x) 0))))
    'done)