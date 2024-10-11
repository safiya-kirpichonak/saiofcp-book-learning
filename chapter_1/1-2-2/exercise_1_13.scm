#|
    As you can see, the x functions is something like fibonacci and the y is 
    exactly the sam as fibonacci.
|#

(define phi (/ (+ 1 (sqrt 5)) 2))
(define psi (/ (- 1 (sqrt 5)) 2))

(define (x n)
  (/ (expt phi n) (sqrt 5)))

(define (y n)
  (/ (- (expt phi n) (expt psi n)) (sqrt 5)))

(define (fibonacci-iteration n)
  (fibonacci 1 0 n))

(define (fibonacci a b count)
  (if (= count 0)
      b
      (fibonacci (+ a b) a (- count 1))))

(define (main)
  (let loop ((i 1))
    (when (<= i 10)
      (let ((fr (fibonacci-iteration i))
            (xr (x i))
            (yr (y i)))
        (display fr) (display " ") (display xr) (display " ") (display yr) (newline))
      (loop (+ i 1)))))

(main)
