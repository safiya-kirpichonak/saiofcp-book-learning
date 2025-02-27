#lang sicp

(#%require graphics/graphics)

; vectors operations
(define (make-vect x y) (cons x y))
(define (xcor-vect vector) (car vector))
(define (ycor-vect vector) (cdr vector))

(define (add-vect v1 v2)
  (make-vect 
    (+ (xcor-vect v1) (xcor-vect v2))
    (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect 
    (- (xcor-vect v1) (xcor-vect v2))
    (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect n v)
  (make-vect (* n (xcor-vect v)) (* n (ycor-vect v))))

; frames operations
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

; segment operations
(define (make-segment start-segment end-segment)
    (list start-segment end-segment))

(define (start-segment segment) (car segment))
(define (end-segment segment) (cadr segment))

; draw the pictures and additional functions to make it work
(open-graphics)
(define vp (open-viewport "A Picture Language" 100 100))

(define line (draw-line vp))

(define (vector-to-posn v)
  (make-posn (car v) (cdr v))) 

(define (segments->painter segment-list)   
  (lambda (frame)     
   (for-each     
     (lambda (segment)
       (newline) (display ((frame-coord-map frame) (start-segment segment)))
       (newline) (display ((frame-coord-map frame) (end-segment segment)))
      (line         
        (vector-to-posn ((frame-coord-map frame) (start-segment segment)))
        (vector-to-posn ((frame-coord-map frame) (end-segment segment)))))
      segment-list)))

; "wave with smile" picture
(define x1 (make-vect 30 30))
(define x2 (make-vect 50 10))
(define x3 (make-vect 70 30))
(define x4 (make-vect 50 50))
(define x5 (make-vect 50 80))
(define x6 (make-vect 30 100))
(define x7 (make-vect 70 100))
(define x8 (make-vect 30 60))
(define x9 (make-vect 70 60))
(define x10 (make-vect 90 40))
(define x11 (make-vect 40 30))
(define x12 (make-vect 50 40))
(define x13 (make-vect 60 30))
(define segment1 (make-segment x1 x2))
(define segment2 (make-segment x2 x3))
(define segment3 (make-segment x3 x4))
(define segment4 (make-segment x1 x4))
(define segment5 (make-segment x4 x5))
(define segment6 (make-segment x8 x9))
(define segment7 (make-segment x9 x10))
(define segment8 (make-segment x6 x5))
(define segment9 (make-segment x7 x5))
(define segment10 (make-segment x11 x12))
(define segment11 (make-segment x12 x13))
(define function (segments->painter (list 
  segment1 
  segment2 
  segment3 
  segment4
  segment5
  segment6
  segment7
  segment8
  segment9
  segment10
  segment11)))
(define frame (make-frame (make-vect 0 0) (make-vect 1 0) (make-vect 0 1)))
(function frame)