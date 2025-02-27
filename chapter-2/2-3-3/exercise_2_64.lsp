(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right) 
    (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

#|
The growth rate is O(n), because in the worst scenario (when n = length of elements)
we process all elements.
|#

(define (partial-tree elements n)
  (if (= n 0)
      ; if n == 0, return elements (base case, if n = 0 it means return '())
      (cons '() elements)
      ; create left branch of the tree: half of the tree for left, other for right
      (let ((left-size (quotient (- n 1) 2)))
        ; continue creating next nodes of left side by recursion
        (let ((left-result (partial-tree elements left-size)))
          (let ((left-tree (car left-result))
                (non-left-elements (cdr left-result)))
            ; create right branch of the tree
            (let ((right-size (- n (+ left-size 1))))
              ; first element of the non left elements will be the value of node
              (let ((this-entry (car non-left-elements))
                    ; continue creating next nodes of right side by recursion
                    (right-result (partial-tree (cdr non-left-elements) right-size)))
                (let ((right-tree (car right-result))
                      (remaining-elements (cdr right-result)))
                  ; complete tree by addition node value, right and left size
                  (cons (make-tree this-entry left-tree right-tree) remaining-elements)))))))))

(newline) (display (list->tree '(1 3 5 7 9 11)))
; Result:
; (5 
;     (1 
;         () 
;         (3 () ())) 
;     (9 
;         (7 () ())
;         (11 () ())))
(newline) (display (list->tree '(1 3 5 7 9 11 13)))
; (7 
;     (3 
;         (1 () ()) 
;         (5 () ())) 
;     (11 
;         (9 () ()) 
;         (13 () ())))