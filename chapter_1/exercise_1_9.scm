#|
    First function:

    (+ 4 5)
    (inc (+ (dec 4) 5))
    (inc (+ 3 5))
    (inc (inc (+ (dec 3) 5)))
    (inc (inc (+ 2 5)))
    (inc (inc (inc (+ (dec 2) 5))))
    (inc (inc (inc (+ 1 5))))
    (inc (inc (inc (inc (+ (dec 1) 5)))))
    (inc (inc (inc (inc (+ 0 5)))))
    (inc (inc (inc (inc 5))))
    (inc (inc (inc 6)))
    (inc (inc 7))
    (inc 8)
    9

    In result this is a recursive process.

    Second function:

    (+ 4 5)
    (+ (dec 4) (inc 5))
    (+ 3 6)
    (+ (dec 3) (inc 6))
    (+ 2 7)
    (+ (dec 1) (inc 8))
    (+ 0 9)
    9

    In result this is a iteration process, but with recursive syntax.
|#

#|
(define (dec x)
  (- x 1))

(define (inc x)
  (+ x 1))
|#

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

#|
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
|#

(newline)
(display (add 4 5))