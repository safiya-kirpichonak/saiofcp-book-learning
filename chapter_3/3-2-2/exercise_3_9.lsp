; I am not sure about this task

#|
+------+
global env
+------+
|       | link to env
code    |
        +-------+
        E1: env where n = 2
        +-------+
        |       | link to env
        code    |
              +-------+
              E2: env where n = 1
              +-------+
              |
              code -> calculate result
|#

(define (factorial n) 
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))

(newline) (display (factorial 2)) ; 2

#|
+-------------------------------+
global env
+-------------------------------+
| |                         |   |
| code of factorial-2       |   code of fact-iter
+----------------------+    +------------------+
E1: where run fact-iter  -> E2: run fact-iter with (product = 1; counter = 1 max-count = 2)
+----------------------+    +------------------+
                            |
                            +------------------+
                            E3: run fact-iter with (product = 1; counter = 2 max-count = 2)
                            +------------------+
                            |
                            +------------------+
                            E4: run fact-iter with (product = 2; counter = 3 max-count = 2) => result
                            +------------------+
|#

(define (factorial-2 n) (fact-iter 1 1 n))

(define (fact-iter product counter max-count) 
    (if (> counter max-count)
        product
        (fact-iter (* counter product) 
                   (+ counter 1) 
                   max-count)))

(newline) (display (factorial-2 2)) ; 2