(define (make-frame-1 origin edge1 edge2) 
    (list origin edge1 edge2))

(define (origin-frame-1 frame) 
    (car frame))

(define (edge1-frame-1 frame) 
    (car (cdr frame)))

(define (edge2-frame-1 frame) 
    (cdr (cdr frame)))

(define (make-frame-2 origin edge1 edge2) 
    (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame) 
    (car frame))

(define (edge1-frame-2 frame) 
    (car (cdr frame)))

(define (edge2-frame-2 frame) 
    (cdr (cdr frame)))
