(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b) 
    (define (iter a result)
        (if (> a b) result
               (iter (next a) (+ (term a) result))))
    (iter a 0)
)

(define (identity x) x)

(define (sum-integers a b)
  (define (inc x) (+ x 1))
  (sum identity a inc b))

(define (sum-integers-iter a b)
  (define (inc x) (+ x 1))
  (sum-iter identity a inc b))

(newline)
(display (sum-integers 1 10)) ; 55
(newline)
(display (sum-integers-iter 1 10)) ; 55