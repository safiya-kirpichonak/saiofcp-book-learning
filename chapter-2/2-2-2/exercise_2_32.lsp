#|
So how it works?

context 1:
null? (list 1 2 3) - no
(cdr subset) = (2 3)
run (subsets (2 3))
waiting for rest ...

context 2:
null? (list 2 3) - no
(cdr subset) = (3)
run (subsets (3))
waiting for rest ...

context 3:
null? (list 3) - no
(cdr subset) = ()
run (subsets ())
waiting for rest ...

context 4:
null? () - yes!
return to context 3 with (())

context 3:
subset = (3)
rest = (())
1. Go throw rest with map and put first value 
from subset to the each rest. Result: ((3))
2. Append in (()) new list ((3)). Result: (() (3))
return to context 2 with (() (3))

context 2:
subset = (2 3)
rest = (() (3))
1. Go throw rest with map and put first value 
from subset to the each rest. Result: ((2) (2 3))
2. Append in (() (3)) new list ((2) (2 3)). Result: (() (3) (2) (2 3))
return to context 1 with (() (3) (2) (2 3))

context 1:
subset = (1 2 3)
rest = (() (3) (2) (2 3))
1. Go throw rest with map and put first value 
from subset to the each rest. Result: ((1) (1 3) (1 2) (1 2 3))
2. Append in (() (3) (2) (2 3)) new list ((1) (1 3) (1 2) (1 2 3)). 

Result: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
|#

(define (subsets subset) 
    (if (null? subset) (list (list))
        (let*
            ((rest (subsets (cdr subset)))
             (result (append rest (map (lambda (rest) (cons (car subset) rest)) rest))))
            (newline) (display "rest: ") (display rest)
            (newline) (display "subset: ") (display subset)
            (newline) (display "result: ") (display result)
            (newline) (display "+--------------------------+")
            result)))

(subsets (list 1 2 3))
