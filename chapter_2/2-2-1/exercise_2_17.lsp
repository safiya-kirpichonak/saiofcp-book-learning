(define (last-pair items) 
    (if (= (length items) 1)
        items
        (last-pair (cdr items))))

(newline) (display (last-pair (list 23 72 149 34))) ; (34)