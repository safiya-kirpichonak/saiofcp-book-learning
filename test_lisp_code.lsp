; TODO
(define x (cons 5 6)) 
(define z (cons 5 (list 6 7)))
(define a (cons (list 8 9) 10)) 
(define y (cons (list 1 2) (list 3 4))) 

(newline) (display x) ; (5 . 6)
(newline) (display y) ; ((1 2) 3 4)
(newline) (display z) ; (5 6 7)
(newline) (display a) ; ((8 9) . 10)