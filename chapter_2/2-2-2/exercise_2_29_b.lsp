(define (make-mobile left right) 
    (list left right))

(define (make-branch length structure) 
    (list length structure))

(define (left-branch mobile)
  (list-ref mobile 0))

(define (right-branch mobile)
  (list-ref mobile 1))

(define (branch-length branch)
  (list-ref branch 0))

(define (branch-structure branch)
  (list-ref branch 1))

; my version:
(define (total-weight mobile)
  (define ls (branch-structure (left-branch mobile)))
  (define rs (branch-structure (right-branch mobile)))
  (cond
    ((and (pair? ls) (pair? rs)) (+ (total-weight ls) (total-weight rs)))
    ((and (not (pair? ls)) (pair? rs)) (+ ls (total-weight rs)))
    ((and (pair? ls) (not (pair? rs))) (+ (total-weight ls) rs))
    ((and (not (pair? ls)) (not (pair? rs))) (+ ls rs))
    (else (error "Something went wrong."))))

; better version:
; (define (total-weight structure)
;   (if (number? structure)
;       structure
;       (+ (total-weight (branch-structure (left-branch structure)))
;          (total-weight (branch-structure (right-branch structure))))))

#|
result: 22

    mobile1
   5|      \3
    mobile2  10
   2|    |1
    4    8
|#

(define mobile2-right-branch (make-branch 1 8))
(define mobile2-left-branch (make-branch 2 4))
(define mobile2 (make-mobile mobile2-left-branch mobile2-right-branch))

(define mobile1-left-branch (make-branch 5 mobile2))
(define mobile1-right-branch (make-branch 3 10))
(define mobile1 (make-mobile mobile1-left-branch mobile1-right-branch))

(newline) (display (total-weight mobile1))
