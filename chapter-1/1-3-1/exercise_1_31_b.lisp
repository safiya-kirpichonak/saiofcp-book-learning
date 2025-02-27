(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b) 
    (define (iter a result)
        (if (> a b) result
               (iter (next a) (* (term a) result))))
    (iter a 1)
)

(define (identity x) x)

(define (product-integers a b)
  (define (inc x) (+ x 1))
  (product identity a inc b))

(define (product-integers-iter a b)
  (define (inc x) (+ x 1))
  (product-iter identity a inc b))

(newline)
(display (product-integers 1 5)) ; 120
(newline)
(display (product-integers-iter 1 5)) ; 120