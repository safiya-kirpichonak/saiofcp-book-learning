#|

Tpq:
a <- bq + aq + ap
b <- bp + aq

Tp'q':
a' <- bq' + aq'
b' <- bp' + aq'

Step 1:

a1 = bq + aq + ap
b1 = bp + aq

Step 2:

a2 = b1q + a1q + a1p
b2 = b1p + a1q

Step 3:

a2 = (bp + aq) * q + (bq + aq + ap) * q + (bq + aq + ap) * p
b2 = (bp + aq) * p + (bq + aq + ap) * q

Step 4:

a2 = b(2pq + qq) + a(2qq)
b2 = b(pp + qq) + a(2pq + qq)

Step 5:

a2 = a' => b(2pq + qq) + a(2qq) = bq' + aq' => q' = 2pq + qq; q' = 2qq;
b2 = b' => b(pp + qq) + a(2pq + qq) = bp' + aq' => p' = pp + qq.

So, the final parameters:
q' = 2pq + qq.
p' = pp + qq.
|#

(define (fib n) 
    (fib-iter 1 0 0 1 n)
)

(define (fib-iter a b p q count) 
    (cond ((= count 0) b)
          ((even? count)
                (fib-iter a
                          b
                          (+ (* p p) (* q q))
                          (+ (* q q) (* 2 p q))
                          (/ count 2)))
            (else (fib-iter (+ (* b q) (* a q) (* a p)) 
                            (+ (* b p) (* a q))
                            p
                            q
                            (- count 1)
                   )
            )
    )
)

(newline)
(display (fib 10))
(newline)