(define (install-scheme-number-package)
    ; other internal operations
    ...

    ; transformation operation
    (define (scheme-number->rational-number n)
        (make-rational-number (contents n) 1))

    (define (tag x) (attach-tag 'scheme-number x))

    ; other external operations
    ...

    (put 'raise 'scheme-number scheme-number->rational-number)

    (put-coercion 'scheme-number 'rational-number scheme-number->rational-number)

    'done)

(define (install-rational-number-package)
    ; other internal operations
    ...

    ; transformation operation
    (define (rational-number->real-number n)
        (let ((real-number (contents n)))
            (make-real-number (/ (numer real-number) (denom real-number)))))

    (define (tag x) (attach-tag 'rational-number x))

    ; other operations
    ...
  
    (put 'raise 'rational-number rational-number->real-number)

    (put-coercion 'rational-number 'real-number rational-number->real-number)

    'done)

(define (install-real-number-package)
    ; other internal operations
    ...

    ; transformation operation
    (define (real-number->complex-number n)
        (make-complex-from-real-imag (contents n) 0))

    (define (tag x) (attach-tag 'real-number x))

    ; other operations
    ...
  
    (put 'raise 'real-number real-number->complex-number)

    (put-coercion 'real-number 'complex-number real-number->complex-number)

    'done)