; TODO

(define (accumulate op initial sequence) 
    (if (null? sequence)
      initial
      (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(newline) (display (accumulate + 0 (list 1 2 3 4 5)))
