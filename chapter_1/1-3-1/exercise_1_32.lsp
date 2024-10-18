(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b) 
    (define (iter a result)
        (if (> a b) result
               (iter (next a) (combiner (term a) result))))
    (iter a null-value)
)

(define (identity x) x)
(define (increment x) (+ x 1))

(newline)
(display (accumulate * 1 identity 1 increment 5)) ; 120
(newline)
(display (accumulate + 0 identity 1 increment 5)) ; 15
(newline)
(display (accumulate-iter * 1 identity 1 increment 5)) ; 120
(newline)
(display (accumulate-iter + 0 identity 1 increment 5)) ; 15