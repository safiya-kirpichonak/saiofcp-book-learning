(define (rand initial)
    (define random-number initial)

    (define (generate) 
        (set! random-number (random random-number))
        random-number)

    (define (reset) 
        (set! random-number initial) 
        "Done reset")

    (define (dispatch operation)
        (cond ((eq? 'generate operation) (generate))
              ((eq? 'reset operation) (reset))
              (else (error "Unknown operation -- RAND"))))

    dispatch)

(define rand-instance (rand 10))
(newline) (display (rand-instance 'generate)) ; 5
(newline) (display (rand-instance 'generate)) ; 2
(newline) (display (rand-instance 'generate)) ; 1
(newline) (display (rand-instance 'reset)) ; Done reset
(newline) (display (rand-instance 'generate)) ; 6
(newline) (display (rand-instance 'generate)) ; 3
(newline) (display (rand-instance 'generate)) ; 0