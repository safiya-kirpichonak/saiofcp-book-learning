(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    ; ...
    (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
    'done)

(define (install-rational-package)
    (define (tag x) (attach-tag 'rational x))
    ; ...
    (put 'eq? '(rational rational) 
        (lambda (x y) (= (* (numer x) (denom y)) (* (denom x) (numer y)))))
    'done)

(define (install-complex-package)
    (define (tag z) (attach-tag 'complex z))
    ; ...
    (define (eq-complex? x y)
        (and (= (real-part x) (real-part y))
                             (= (imag-part x) (imag-part y))))

    (put 'eq? '(complex complex) eq-complex?)
    'done)
