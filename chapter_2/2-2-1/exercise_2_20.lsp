(define (same-parity . items) 
    (if (null? items) (error "Empty list is not allowed!"))
    (if (odd? (car items)) 
        (filter odd? items)
        (filter even? items)))

(newline) (display (same-parity 1 2 3 4 5 6 7)) ; (1 3 5 7)
(newline) (display (same-parity 2 3 4 5 6 7)) ; (2 4 6)