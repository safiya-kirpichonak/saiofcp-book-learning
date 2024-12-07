(define (make-sum . items)
  (define (sum result-sum result-exp items)
    (cond 
      ((null? items)
       (cond
         ((= (length result-exp) 1) result-sum)
         ((and (= (length result-exp) 2) (not (= result-sum 0))) (list '+ (cadr result-exp) result-sum))
         ((and (= (length result-exp) 2) (= result-sum 0)) (cadr result-exp))
         (else (if (= result-sum 0) result-exp (append result-exp (list result-sum))))))
      ((number? (car items)) (sum (+ result-sum (car items)) result-exp (cdr items)))
      (else (sum result-sum (append result-exp (list (car items))) (cdr items)))))
  (if (= (length items) 1) (car items) (sum 0 (list '+) items)))

(newline) (display "make-sum:")
(newline) (display (make-sum 'x))                   ; x
(newline) (display (make-sum 0 'x 0 0))             ; x
(newline) (display (make-sum 2))                    ; 2
(newline) (display (make-sum 1 2 3 4 5))            ; 15
(newline) (display (make-sum 1 'x 3 4 5))           ; (+ x 13)
(newline) (display (make-sum 0 'x 0 0 'y))          ; (+ x y)
(newline) (display (make-sum 0 'x 3 'y 4))          ; (+ x y 7)
(newline) (display (make-sum 0 'x 0 0 0 'y 'z))     ; (+ x y z)

(define (sum? x)
    (and (pair? x) (eq? (car x) '+)))

(define (addend sum) (cadr sum))

(newline) (display "addend:")
(newline) (display (addend (list '+ 1 2)))                  ; 1
(newline) (display (addend (list '+ (list '+ 'x 'y) 2)))    ; (+ x y)

(define (augend sum) (apply make-sum (cdr (cdr sum))))

(newline) (display "augend:")
(newline) (display (augend (list '+ 1 2)))        ; 2
(newline) (display (augend (list '+ 1 2 3 4)))    ; 9
(newline) (display (augend (list '+ 1 2 'x)))     ; (+ x 2)