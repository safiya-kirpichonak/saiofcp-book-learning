(define (last-pair items) 
    (if (null? items) (error "Empty list is not allowed!"))
    (if (= (length items) 1)
        items
        (last-pair (cdr items))))

(newline) (display (last-pair (list 23 72 149 34))) ; (34)
(newline) (display (last-pair (list))) ; ;Empty list is not allowed!