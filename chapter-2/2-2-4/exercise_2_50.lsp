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
(define vp (open-viewport "A Picture Language" 500 500))

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

; transformation
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
          (make-frame new-origin
            (sub-vect (m corner1) new-origin)
            (sub-vect (m corner2) new-origin)))))))

; task fucntions
(define (flip-horiz painter)
  (transform-painter painter
    (make-vect 1.0 0.0)
    (make-vect 0.0 0.0)
    (make-vect 1.0 1.0)))

(define (rotate-180 painter)
  (transform-painter painter
    (make-vect 1.0 1.0)
    (make-vect 0.0 1.0)
    (make-vect 1.0 0.0)))

(define (rotate-270 painter)
  (transform-painter painter
    (make-vect 1.0 0.0)
    (make-vect 1.0 1.0)
    (make-vect 0.0 0.0)))

; "wave" picture
(define x1 (make-vect 75 75))
(define x2 (make-vect 125 25))
(define x3 (make-vect 175 75))
(define x4 (make-vect 125 125))
(define x5 (make-vect 125 200))
(define x6 (make-vect 75 250))
(define x7 (make-vect 175 250))
(define x8 (make-vect 75 150))
(define x9 (make-vect 175 150))
(define x10 (make-vect 225 100))
(define segment1 (make-segment x1 x2))
(define segment2 (make-segment x2 x3))
(define segment3 (make-segment x3 x4))
(define segment4 (make-segment x1 x4))
(define segment5 (make-segment x4 x5))
(define segment6 (make-segment x8 x9))
(define segment7 (make-segment x9 x10))
(define segment8 (make-segment x6 x5))
(define segment9 (make-segment x7 x5))
(define frame (make-frame (make-vect 250 250) (make-vect 1 0) (make-vect 0 1)))
(define original-painter (segments->painter (list segment1 segment2 segment3 segment4 segment5 segment6 segment7 segment8 segment9)))

; (define flipped-horiz-painter (flip-horiz original-painter))
; (flipped-horiz-painter frame)
; (define rotated-180-painter (rotate-180 original-painter))
; (rotated-180-painter frame)
(define rotated-270-painter (rotate-270 original-painter))
(rotated-270-painter frame)