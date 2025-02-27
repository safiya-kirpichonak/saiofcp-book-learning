; you can't run this code

(define (install-schema-number-package)
    (define (sine r) (sin r))

    (define (cosine r) (cos r))

    (put 'sine '(schema-number) sine)

    (put 'cosine '(schema-number) cosine))

(define (install-rational-number-package)
    (define (numer x) (car x))
    (define (denom x) (cdr x))

    (define (project r) (/ (numer r) (denom r)))

    (define (sine r) (sin (project r)))

    (define (cosine r) (cos (rational-to-real r)))

    (put 'sine '(rational-number) sine)

    (put 'cosine '(rational-number) cosine))

(define (install-complex-number-package)
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))

    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))

    (define (make-from-scheme-number-real-imag x1 x2)
        (make-from-real-imag 
                ((get 'make 'scheme-number) x1) 
                ((get 'make 'scheme-number) x2)))

    (define (make-from-scheme-number-mag-ang x1 x2)
        (make-from-mag-ang 
                ((get 'make 'scheme-number) x1) 
                ((get 'make 'scheme-number) x2)))

    (define (make-from-rational-number-real-imag x1 x2)
        (make-from-real-imag 
                ((get 'make 'rational-number) x1) 
                ((get 'make 'rational-number) x2)))

    (define (make-from-rational-number-mag-ang x1 x2)
        (make-from-mag-ang 
                ((get 'make 'rational-number) x1) 
                ((get 'make 'rational-number) x2)))

    (put 'make-from-scheme-number-real-imag '(complex) 
        (lambda (x1 x2) (tag (make-from-scheme-number-real-imag x1 x2))))

    (put 'make-from-scheme-number-mag-ang '(complex) 
        (lambda (x1 x2) (tag (make-from-scheme-number-mag-ang x1 x2))))

    (put 'make-from-rational-number-real-imag '(complex) 
        (lambda (x1 x2) (tag (make-from-rational-number-real-imag x1 x2))))

    (put 'make-from-rational-number-mag-ang '(complex) 
        (lambda (x1 x2) (tag (make-from-rational-number-mag-ang x1 x2)))))