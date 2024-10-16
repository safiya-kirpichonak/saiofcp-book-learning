#|
Results:
.24998750000000042
.249999875000001
1/4
1/4

Simson’s method is indeed more accurate.
|#

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) 
         (sum term (next a) next b))))

(define (integral f a b dx)
  (let ((add-dx (lambda (x) (+ x dx))))
    (* dx (sum f (+ a (/ dx 2)) add-dx b))))

(define (integral-simpson f a b n)
  (let* ((h (/ (- b a) n))
         (term (lambda (i)
                 (let ((x (+ a (* i h))))
                   (cond ((or (= i 0) (= i n)) (f x))
                         ((even? i) (* 2 (f x)))
                         (else (* 4 (f x)))))))
         (next (lambda (i) (+ i 1))))
    (* (/ h 3) (sum term 0 next n))))

(newline)
(display (integral (lambda (x) (* x x x)) 0 1 0.01)) (newline)
(display (integral (lambda (x) (* x x x)) 0 1 0.001)) (newline)

(display (integral-simpson (lambda (a) (* a a a)) 0 1 100)) (newline)
(display (integral-simpson (lambda (a) (* a a a)) 0 1 1000)) (newline)
