(define (make-monitored operation)
    (define counter 0)

    (define (increment-counter) (set! counter (+ counter 1)))

    (define (reset-count) (set! counter 0) 0)

    (define (dispatch input)
        (cond ((eq? 'reset-count input) (reset-count))
              ((eq? 'how-many-calls? input) counter)
              (else 
                (begin 
                    (increment-counter)
                    (operation input)))))

    dispatch)

(define s (make-monitored sqrt))
(newline) (display (s 100)) ; 10
(newline) (display (s 'how-many-calls?)) ; 1
(newline) (display (s 100)) ; 10
(newline) (display (s 'how-many-calls?)) ; 2
(newline) (display (s 'reset-count)) ; 0
(newline) (display (s 'how-many-calls?)) ; 0
(newline) (display (s 100)) ; 10
(newline) (display (s 'how-many-calls?)) ; 1