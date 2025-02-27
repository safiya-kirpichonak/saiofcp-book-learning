(define (make-accumulator augend) 
    (lambda (addend) 
        (set! augend (+ augend addend))
        augend))

(define A (make-accumulator 5))
(newline) (display (A 10)) ; 15
(newline) (display (A 10)) ; 25