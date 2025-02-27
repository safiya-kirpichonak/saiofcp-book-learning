#|
Structure:

a -> b -> null
c -> d -> null

cdr of last pair (b) is null, so after append!:

a -> b -> c -> d

because the link of cdr was changed to the (c d) list.
|#

(define (append x y) 
    (if (null? x)
        y
        (cons (car x) (append (cdr x) y))))

(define (append! x y) 
    (set-cdr! (last-pair x) y) x)

(define (last-pair x) 
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y))

(newline) (display z) ; (a b c d)
(newline) (display (cdr x)) ; (b)
(newline) (display (last-pair x)) ; (b)

(define w (append! x y))

(newline) (display w) ; (a b c d)
(newline) (display (cdr w)) ; (b c d)