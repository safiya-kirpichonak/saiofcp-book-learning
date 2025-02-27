(define (cons x y)
    (define (set-x! v) (set! x v)) 
    (define (set-y! v) (set! y v)) 
    (define (dispatch m)
        (cond ((eq? m 'car) x) 
              ((eq? m 'cdr) y)
              ((eq? m 'set-car!) set-x!)
              ((eq? m 'set-cdr!) set-y!)
              (else (error "Unknown operation -- CONS" m))))
dispatch)

(define (car z) (z 'car))

(define (cdr z) (z 'cdr))

(define (set-car! z new-value) 
    ((z 'set-car!) new-value) z)

(define (set-cdr! z new-value) 
    ((z 'set-cdr!) new-value) z)

#|
+----------------------------------------+
global env:
x, z, cons, car, cdr, set-car!, set-cdr!
+----------------------------------------+
cons        |     x |           z |
|           |     | |           | |
*------------     *-            *-
|        |        |             |
x and y  body     +-----------+ +-----------+
                  E1:           E2:
                  x = 1 y = 2   x => Link E1 y => Link E1
                  body ...      body...
                  +-----------+ +-----------+

|#

(define x (cons 1 2)) 
(define z (cons x x))

#|
So after (cdr z) it is x (link to E1). So, (set-car! x 17) 
change in x from E1 (x = 1 and y = 2) to E1 (x = 17 and y = 2). 
So now all x links is (x = 17 and y = 2). To prove it, check code results:
|#

(set-car! (cdr z) 17)
(newline) (display (car x)) ; 17
(newline) (display (car (car z))) ; 17
(newline) (display (car (cdr z))) ; 17