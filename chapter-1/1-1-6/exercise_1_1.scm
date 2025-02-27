;;; 10
(display 10)
(newline)

;;; 12
(display (+ 5 3 4))
(newline)

;;; 8
(display (- 9 1))
(newline)

;;; 3
(display (/ 6 2))
(newline)

;;; 6
(display (+ (* 2 4) (- 4 6)))
(newline)

;;; 3
(define a 3)
(display a)
(newline)

;;; 4
(define b (+ a 1))
(display b)
(newline)

;;; 19
(display (+ a b (* a b)))
(newline)

;;; #f
(display (= a b))
(newline)

;;; 4
(display 
    (if 
        (and 
            (> b a) 
            (< b (* a b)))
        b 
        a
    )
)
(newline)

;;; 16 
(display 
        (cond 
            ((= a 4) 6)
            ((= b 4) (+ 6 7 a))
            (else 25)
        )
)
(newline)

;;; 6
(display 
    (
        + 2 (
            if 
                (> b a)
                b
                a
        )
    )
)
(newline)

;;; 16
(display
    (* 
        (cond
            ((> a b) a)
            ((< a b) b)
            (else -1)
        )
        (+ a 1)
    )
)
(newline)