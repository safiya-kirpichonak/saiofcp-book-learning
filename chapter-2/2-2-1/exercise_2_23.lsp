(define (for-each function items)
  (if (null? items) 
      #t
      (begin
        (function (car items))
        (for-each function (cdr items)))))

(for-each (lambda (x) (newline) (display x)) (list 57 321 88)) ; 57 321 88