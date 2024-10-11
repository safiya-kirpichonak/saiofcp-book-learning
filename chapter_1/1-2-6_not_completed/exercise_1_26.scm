#|
This code will run much slower because the `expmod` function is called twice, 
resulting in two additional processes for each call. Therefore, it is better 
to use `square` since the function is called once and then the square of the 
number is calculated, rather than calling the function twice and duplicating 
the process.
|#

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m)) 
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) 
                    m))))