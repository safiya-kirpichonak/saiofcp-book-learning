(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

; correct variant
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

; my bad variant:
; (define (adjoin-set x set) 
;     (if (element-of-set? x set) set)
;     (define (iter result set)
;         (cond ((null? set) (append result (list x)))
;         ((< x (car set)) (append result (append (list x) set)))
;         (else (iter (append result (list (car set))) (cdr set)))))
;     (iter '() set))

(newline) (display (adjoin-set 2 '(1 3 4 5))) ; (1 2 3 4 5)
(newline) (display (adjoin-set 1 '(2 3 4 5))) ; (1 2 3 4 5)
(newline) (display (adjoin-set 5 '(1 2 3 4))) ; (1 2 3 4 5)