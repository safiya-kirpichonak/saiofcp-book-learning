#|
a. I think these functions are the same, but first is using recursive style and second is using 
iterative style. So I can't imagine example of using even with incorrect tree where the results
would be unequal. So the results for the all trees in the tasks are the same.
b. Second one will be better for big tress, because no append (it is expensive operation) and no 
full stack of function's deferred calls. So, my answer is first is slower. The difference: 
first is O(n * n) and second is O(n) - because no stack of calls.
|#

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree) result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(newline) (display (tree->list-1 '(5 (6 (10 () ()) (3 () ())) (20 () (666 () ()))))) ; (10 6 3 5 20 666)
(newline) (display (tree->list-2 '(5 (6 (10 () ()) (3 () ())) (20 () (666 () ()))))) ; (10 6 3 5 20 666)

(newline) (display (tree->list-1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))) ; (1 3 5 7 9 11)
(newline) (display (tree->list-2 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))) ; (1 3 5 7 9 11)

(newline) (display (tree->list-1 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))) ; (1 3 5 7 9 11)
(newline) (display (tree->list-2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))) ; (1 3 5 7 9 11)

(newline) (display (tree->list-1 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))) ; (1 3 5 7 9 11)
(newline) (display (tree->list-2 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))) ; (1 3 5 7 9 11)

(newline) (display (tree->list-1 '(1 () (2 () (3 () (4 () (5 () (6 () (7 () ()))))))))) ; (1 2 3 4 5 6 7)
(newline) (display (tree->list-2 '(1 () (2 () (3 () (4 () (5 () (6 () (7 () ()))))))))) ; (1 2 3 4 5 6 7)