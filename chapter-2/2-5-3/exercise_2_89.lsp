(define (make-term order coeff) 
    (if (= order 0) 
        (list coeff) 
        (cons coeff (make-term (- order 1) 0))))

(newline) (display (make-term 5 3)) ; (3 0 0 0 0 0)
(newline) (display (make-term 0 1)) ; (1)

(define (insert-at lst index value)
  (if (zero? index)
      (cons value lst)
      (cons (car lst) (insert-at (cdr lst) (- index 1) value))))

(define (adjoin-term coeff order term-list) 
  (let ((term-length (length term-list))) 
       (cond ((= order term-length) (cons coeff term-list))
              ((> order term-length) (append (make-term (- order term-length) coeff) term-list))
              ((and (< order term-length) (> order -1)) (insert-at term-list (- term-length order) coeff))
              (error "Unknow position -- ADJOIN-TERM"))))

(define term-list '(1 2 0 3 -2 -5))
(newline) (display (adjoin-term 43 5 term-list)) ; (1 43 2 0 3 -2 -5)
(newline) (display (adjoin-term 43 6 term-list)) ; (43 1 2 0 3 -2 -5)
(newline) (display (adjoin-term 43 7 term-list)) ; (43 0 1 2 0 3 -2 -5)

; the same:
(define (=zero? term-coeff) (= term-coeff 0))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (empty-termlist? term-list) (null? term-list))