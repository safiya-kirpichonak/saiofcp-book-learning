(define (f n)
  (if (< n 3)
      n
      (+ 
        (f (- n 1))
        (f (- n 2))
        (f (- n 3))
      )
  )
)

(newline)
(display (f 2))
(newline)
(display (f 4))