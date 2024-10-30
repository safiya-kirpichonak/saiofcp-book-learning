; basic intervals selectors

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

; 3.5 ± 0.15 - 3.5 is center, 0.15 is width
; basic center/width selectors

(define (make-interval-by-center-width c w) 
    (make-interval (- c w) (+ c w)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

; percent selectors

(define (width-percent interval) 
    (* (/ (width interval) (center interval)) 100))

(define (make-interval-by-center-width-percent center width-percent)
    (define width (* (/ width-percent 100) center))
    (make-interval-by-center-width center width))

(define (multiply-intervals-percent interval1 interval2)
    (define new-center (* (center interval1) (center interval2)))
    (define new-width-percent (+ (width-percent interval1) (width-percent interval2)))
    (make-interval-by-center-width-percent new-center new-width-percent))

(define (display-interval interval)
      (newline)
      (display "(")
      (display (lower-bound interval))
      (display " ; ")
      (display (upper-bound interval))
      (display ")"))

; - interval1 [2.9, 3.1]:

; center: 3
; width: 0.1
; percent-width: 3.33%

(define interval1 (make-interval 2.9 3.1))

; - interva2 [3.8, 4.2]

; center: 4
; width: 0.2
; percent-width: 5%

(define interval2 (make-interval 3.8 4.2))

; - result [11, 13]:

; center: 3 * 4 = 12
; width: 8.33% / 100 * 12 = 1
; percent-width: 3.33% + 5% = 8.33%

(display-interval (multiply-intervals-percent interval1 interval2)) ; [11, 13]
