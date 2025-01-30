#|
x:
a -> b -> c

after make-cycle:
a -> b -> c
^         |
|         |
<----------
|#

(define (make-cycle x) 
    (set-cdr! (last-pair x) x) x)

(define (last-pair x) 
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

(define x (list 'a 'b 'c))
(newline) (display x)
(newline) (display (last-pair x))

(define z (make-cycle x)) 
(newline) (display z) ; infinity loop like a -> b -> c -> a -> b -> c -> ....
(newline) (display (last-pair z)) ; no result