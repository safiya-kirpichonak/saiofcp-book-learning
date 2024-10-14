#|
The function `f` takes another function `g` as an argument and calls it 
with the argument `2`. Therefore, if you pass the function `f` to itself, 
an error will occur because the function expects another function as a 
parameter, not a number, and tries to call it with the argument `2`.
|#

(define (f g)
  (g 2))

(newline)
(display (f square)) ;4
(newline)
(display (f (lambda (z) (* z (+ z 1))))) ;6
(newline)
(display (f f)) ; The object 2 is not applicable.