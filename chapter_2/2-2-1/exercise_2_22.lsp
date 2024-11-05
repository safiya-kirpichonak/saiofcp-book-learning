#|
In square-list-1, where (cons (square (car things)) answer) is used, it does 
produce a reversed list because new elements are added to the beginning of 
answer, starting from the last element of the items list. This causes the 
result to be in reverse order. Here, (square (car things)) is added in front 
of answer, and since iter moves towards the end of the list, the order ends up reversed.
|#

(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)) 
                    answer))))
  (iter items (list)))

#|
In square-list-2, when the line is changed to (cons answer (square (car things))), 
the result doesn’t change as intended because, in Lisp, the cons function creates 
pairs. If the second argument of cons is not a list, the result will be a nested 
structure instead of a standard list. In this case, answer is added as the 
first element, and since it is a list, each cons call creates a pair, resulting 
in a nested structure.
|#

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items (list)))

(newline) (display (square-list-1 (list 1 2 3 4))) ; (16 9 4 1)
(newline) (display (square-list-2 (list 1 2 3 4))) ; ((((() . 1) . 4) . 9) . 16)