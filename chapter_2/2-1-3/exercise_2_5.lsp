(define (cons a b) 
  (* (expt 2 a) (expt 3 b)))

(define (car z)
  (define (iter z count)
    (if (= (remainder z 2) 0) 
        (iter (/ z 2) (+ count 1))
        count))
  (iter z 0))

(define (cdr z)
  (define (iter z count)
    (if (= (remainder z 3) 0) 
        (iter (/ z 3) (+ count 1))
        count))
  (iter z 0))

(define pair (cons 4 5))
(newline)
(display (car pair)) ; 4
(newline)
(display (cdr pair)) ; 5