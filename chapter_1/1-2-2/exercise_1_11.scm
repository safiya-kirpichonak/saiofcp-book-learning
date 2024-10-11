(define (f_recursive n)
  (if (< n 3)
      n
      (+ 
        (f_recursive (- n 1))
        (f_recursive (- n 2))
        (f_recursive (- n 3))
      )
  )
)

(define (f n)
    (f_iteration 0 1 2 n)
)

(define (f-iteration a b c count)
  (if (= count 0)
      a
      (f-iteration
        b
        c
        (+ a b c)
        (- count 1)
       )
   )
)

(newline)
(display (f_recursive 1))
(newline)
(display (f_recursive 2))
(newline)
(display (f_recursive 3))
(newline)
(display (f_recursive 4))
(newline)
(display (f_recursive 5))
(newline)
(display (f_recursive 6))

(newline)
(display (f_iteration 1))
(newline)
(display (f_iteration 2))
(newline)
(display (f_iteration 3))
(newline)
(display (f_iteration 4))
(newline)
(display (f_iteration 5))
(newline)
(display (f_iteration 6))