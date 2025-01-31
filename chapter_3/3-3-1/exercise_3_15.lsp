#|
before wow:
x: a -> b

                 ---->(a -> b)<----
                 |                |
z1: (car-link -> x ; cdr-link -> x) - car and cdr are the links to x list.

z2: (car-link -> (a -> b) ; cdr-link -> (a -> b)) - car and cdr are the link
to separated lists without names.

after wow:
x: wow -> b - because there was a link to x from z1.

                 --->(wow -> b)<---
                 |                |
z1: (car-link -> x ; cdr-link -> x) - both car and cdr were changed because 
x was changed.

z2: (car-link -> (wow -> b) ; cdr-link -> (a -> b)) - the links in car and cdr
were separated, so only car was changed.
|#

(define (set-to-wow! x) 
    (set-car! (car x) 'wow) x)

(define x (list 'a 'b))
(define z1 (cons x x))
(newline) (display z1) ; ((a b) a b)
(newline) (display (set-to-wow! z1)) ; ((wow b) wow b)
(newline) (display x) ; (wow b)

(define z2 (cons (list 'a 'b) (list 'a 'b)))
(newline) (display z2) ; ((a b) a b)
(newline) (display (set-to-wow! z2)) ; ((wow b) a b)