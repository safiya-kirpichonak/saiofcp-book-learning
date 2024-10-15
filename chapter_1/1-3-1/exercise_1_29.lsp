; original integral function:
; (define (sum term a next b)
;   (if (> a b)
;       0
;       (+ (term a)
;          (sum term (next a) next b))))

; (define (identity x) x)

; (define (sum-integers a b)
;   (sum identity a inc b))

; (define (integral f a b dx)
;   (define (add-dx x) (+ x dx))
;   (* (sum f (+ a (/ dx 2)) add-dx b) dx))

; (newline)
; (display (integral cube 0 1 0.01)) ;.24998750000000042
; (newline)
; (display (integral cube 0 1 0.001)) ;.249999875000001

